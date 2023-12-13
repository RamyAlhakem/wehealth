import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/drawer/drawer_items.dart';

import '../notifications/notification_screen.dart';

class ScaffoldWrapper extends StatelessWidget {
  const ScaffoldWrapper(
      {Key? key,
      required this.title,
      required this.appBarColor,
      required this.body,
      this.withDrawer = false})
      : super(key: key);
  final String title;
  final Color appBarColor;
  final Widget body;
  final bool withDrawer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          title,
          style: TextStyles.largeTextBoldStyle(),
        ),
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
      drawer: withDrawer ? const DrawerSide() : null,
      body: body,
    );
  }
}
