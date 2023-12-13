
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/home_tiles_controller/home_tiles_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/drawer/drawer_items.dart';

import '../../notifications/notification_screen.dart';

class CardManagementScreen extends StatefulWidget {
  const CardManagementScreen({Key? key}) : super(key: key);

  @override
  State<CardManagementScreen> createState() => _CardManagementScreenState();
}

class _CardManagementScreenState extends State<CardManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Card Management"),
        //  automaticallyImplyLeading: !Platform.isIOS,
        // leading: Platform.isIOS  
        // ?  IconButton(onPressed: (){
        //   Get.back();
        //   }, icon: const Icon(Icons.close),) 
        // : null,
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.to(() => const NotificationScreen());
            },
            icon: const Icon(Icons.message),
          ),
        ],
      ),
      drawer:   const DrawerSide(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please drag and drop for changing the position of the card. You can select ATMOST 5 cards at one time!",
              style: TextStyles.smallTextStyle(),
            ),
            const SizedBox(height: 5),
            Expanded(
                child: GetBuilder<HomeTileController>(builder: (controller) {
              return ReorderableListView.builder(
                itemCount: controller.tiles.length,
                itemBuilder: (context, index) => SwitchListTile(
                  key: ValueKey(controller.tiles[index].identifier),
                  contentPadding: EdgeInsets.zero,
                  secondary: const Icon(Icons.menu),
                  onChanged: (value) =>
                      controller.activitySetting(index, value),
                  value: controller.tiles[index].isActive,
                  title: Text(
                    controller.tiles[index].title,
                    style: TextStyles.smallTextStyle(),
                  ),
                ),
                onReorder: controller.reOrderFunction,
              );
            }))
          ],
        ),
      ),
    );
  }
}
