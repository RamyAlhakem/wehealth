import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/msg_notification_controller/msg_notification_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/user_sent_msg_wrapper.dart';


class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key, required this.contactId, required this.name})
      : super(key: key);
  final int contactId;
  final String name;
  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  late final TextEditingController _msgController;
  late final ScrollController _controller;
  late final Timer _refreshTimer;
  late final MessageNotificationController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = Get.find<MessageNotificationController>();
    _msgController = TextEditingController();
    _controller = ScrollController();
    /* WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        );
      }
    }); */
    _refreshTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      log("Calling refresh!");
      _messageController.fetchUserRecievedMsgList();
      _messageController.fetchUserSentMsgList();
    });
  }

  @override
  void dispose() {
    _refreshTimer.cancel();
    _controller.dispose();
    _msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !Platform.isIOS,
        leading: Platform.isIOS
            ? IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close),
              )
            : null,
        title: Text(widget.name),
        // actions: [
        //   IconButton(
        //     padding: EdgeInsets.zero,
        //     onPressed: () {
        //       Get.to(() => const NotificationScreen(), arguments: 250);
        //     },
        //     icon: const Icon(Icons.message),
        //   ),
        // ],
      ),
      body: GetBuilder<MessageNotificationController>(builder: (controller) {
        return Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            children: [
              const SizedBox(height: 4),
              Expanded(
                child: ListView.builder(
                  controller: _controller,
                  reverse: true,
                  addAutomaticKeepAlives: true,
                  itemCount: controller.getFinalMap[widget.contactId]?.length,
                  itemBuilder: (context, index) => MsgWidget(
                    msgData: controller.getFinalMap[widget.contactId]![index],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(
                      color: Colors.grey,
                    )),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _msgController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            hintText: "Enter message",
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (_msgController.text.trim().isNotEmpty) {
                            final check = await controller.postUserMsg(
                                widget.contactId,
                                _msgController.text,
                                widget.name);
                            if (check) {
                              setState(() {
                                _msgController.text = "";
                              });
                            }
                          }
                        },
                        child: Ink(
                          color: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: SizedBox(
                            height: double.infinity,
                            child: Center(
                              child: Text(
                                "SEND",
                                style: TextStyles.smallTextStyle()
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.sp),
            ],
          ),
        );
      }),
    );
  }
}

class MsgWidget extends StatelessWidget {
  const MsgWidget({
    Key? key,
    required this.msgData,
  }) : super(key: key);

  final MsgDetailsClass msgData;

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetList = <Widget>[
      Flexible(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: msgData.isMe ? Colors.green : Colors.amber.shade900,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            msgData.details ?? "",
            maxLines: 40,
            softWrap: true,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      const SizedBox(width: 8),
      Text(
        DateFormat("yyyy-M-dd hh:mm:ss").format(msgData.timeStamp),
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    ];
    return GestureDetector(
      onTap: () {
        log(msgData.toJson().toString());
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment:
              msgData.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: msgData.isMe ? widgetList.reversed.toList() : widgetList,
        ),
      ),
    );
  }
}
