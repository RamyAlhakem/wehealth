import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/dietary_controller/dietary_controller.dart';
import 'package:wehealth/global/widgets/ios_close_appbar_float.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_picture_camera_search_bar.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({Key? key}) : super(key: key);

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final pageColor = Colors.green.shade700;
  final searchController = TextEditingController();

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
            onTap: () async {},
          ),
        ],
      ),
      body: GetBuilder<DietaryController>(builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HorizontalPictureCameraSearchBar(
              searchController: (value) {
                Get.showOverlay(
                  loadingWidget: const OverlayLoadingIndicator(),
                  asyncFunction: () async =>
                      await controller.searchFood(value ?? ""),
                );
              },
              photoClick: () {},
              cameraClick: () {},
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.suggestedFoodList.length,
                itemBuilder: (context, index) {
                  final item = controller.suggestedFoodList[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${item.englishname} (Source: ${item.country})"),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
