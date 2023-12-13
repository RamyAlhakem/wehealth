import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';
import 'package:wehealth/controller/appt_controller/twillio_conference_controller.dart';

class TwilioRoom extends StatefulWidget {
  const TwilioRoom({Key? key, required this.accessToken}) : super(key: key);
  final String accessToken;
  @override
  State<TwilioRoom> createState() => _TwilioRoomState();
}

class _TwilioRoomState extends State<TwilioRoom> {
  String? name;
  String? token;
  String? identity;
  late final TwilioConferenceController _controller;

  Widget _buildParticipants(BuildContext context, List<Widget> children) {
    return SizedBox.expand(
      child: LayoutBuilder(builder: (context, constraints) {
        return Wrap(
          children: children
              .map(
                (e) => Card(
                  color: Colors.white,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 80,
                      minWidth: 80,
                      maxHeight: constraints.maxHeight / 2,
                      maxWidth: constraints.maxWidth,
                    ),
                    child: e,
                  ),
                ),
              )
              .toList(),
        );
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
    token = widget.accessToken;
    _controller = Get.put(TwilioConferenceController());
    _controller.connect(token!, name ?? "Test User");
  }

  @override
  void dispose() {
    _controller.roomDispose();
    _controller.dispose();
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(name ?? "37007"),
        backgroundColor: Colors.grey.shade800,
        actions: [
          IconButton(
            onPressed: () {
            //
            },
            icon: Icon(Icons.volume_up),
          ),
          IconButton(
            onPressed: () async {
              await _controller.rotateCam();
              print("working..");
            },
            icon: Icon(Icons.cameraswitch_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.screen_share),
          ),
        ],
      ),
      body: GetBuilder<TwilioConferenceController>(builder: (controller) {
        return SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildParticipants(context, controller.participants),
              Positioned(
                bottom: 60,
                child: SizedBox(
                  // width: context.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            iconSize: 32,
                            icon: Icon(
                              controller.isVideo
                                  ? Icons.videocam_rounded
                                  : Icons.videocam_off,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              controller.toggleVideoTrack();
                              /*  controller.roomDispose();
                              Get.back(); */
                            },
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            iconSize: 32,
                            icon: const Icon(
                              Icons.call_end_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              log("click");
                              controller.roomDispose();
                              Get.back();
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            iconSize: 32,
                            icon: Icon(
                              controller.isAudio ? Icons.mic : Icons.mic_off,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              controller.toggleAudioTrack();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
