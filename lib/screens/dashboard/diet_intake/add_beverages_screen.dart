import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:wehealth/global/widgets/ios_close_appbar_float.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_picture_camera_search_bar.dart';

import '../../../global/styles/text_field_decoration.dart';

class AddBeverageScreen extends StatefulWidget {
  const AddBeverageScreen({Key? key}) : super(key: key);

  @override
  State<AddBeverageScreen> createState() => _AddBeverageScreenState();
}

class _AddBeverageScreenState extends State<AddBeverageScreen> {
  final pageColor = Colors.green.shade800;

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapperWithFloat(
      title: "Food",
      appBarColor: pageColor,
      faButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        animatedIconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        closeManually: false,
        closeDialOnPop: true,
        renderOverlay: false,
        spacing: 12,
        spaceBetweenChildren: 12,
        onOpen: () async {},
        children: [
          SpeedDialChild(
            child: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset("assets/icons/addfoodicon.webp"),
              ),
            ),
            backgroundColor: Colors.greenAccent,
            label: 'Add Custom Food',
            onTap: () async {
            //
            },
          ),
        ],
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BeveragePictureCameraSearchBar(),
        ],
      ),
    );
  }
}


class BeveragePictureCameraSearchBar extends StatefulWidget {
  const BeveragePictureCameraSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<HorizontalPictureCameraSearchBar> createState() =>
      _HorizontalPictureCameraSearchBarState();
}

class _HorizontalPictureCameraSearchBarState
    extends State<HorizontalPictureCameraSearchBar> {
  bool isTextField = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: AnimatedCrossFade(
                      crossFadeState: isTextField
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 500),
                      firstChild: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isTextField = true;
                            });
                          },
                          iconSize: 48,
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.search),
                        ),
                      ),
                      secondChild: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextField(
                          decoration: decoration.copyWith(
                            suffixIcon: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                setState(() {
                                  isTextField = false;
                                });
                              },
                              icon: const Icon(
                                Icons.cancel_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      iconSize: 48,
                      icon: const Icon(Icons.image_sharp),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      iconSize: 48,
                      icon: const Icon(Icons.photo_camera),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
            height: 0,
          ),
        ],
      ),
    );
  }
}

