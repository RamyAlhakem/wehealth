import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import '../../screens/dashboard/drawer/drawer_items.dart';
import '../../screens/dashboard/notifications/notification_screen.dart';

class IosScaffoldWrapper extends StatelessWidget {
  const IosScaffoldWrapper({
    Key? key,
    required this.title,
    required this.appBarColor,
    required this.body,
  }) : super(key: key);
  final String title;
  final Color appBarColor;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          title,
          style: TextStyles.smallTextStyle(),
        ),
        automaticallyImplyLeading: !Platform.isIOS,
        leading: Platform.isIOS
            ? IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close),
              )
            : null,
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
      drawer: Platform.isAndroid ? const DrawerSide() : null,
      body: Container(
        margin: Platform.isIOS ? const EdgeInsets.only(bottom: 20) : null,
        child: body,
      ),
    );
  }
}
