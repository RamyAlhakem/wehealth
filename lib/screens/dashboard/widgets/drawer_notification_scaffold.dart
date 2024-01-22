import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/drawer/drawer_items.dart';
import 'package:wehealth/screens/dashboard/drawer/link_device/new_device_screen.dart';
import 'package:wehealth/screens/dashboard/notifications/notification_screen.dart';

class DrawerNotificationScaffold extends StatelessWidget {
  const DrawerNotificationScaffold({
    Key? key,
    this.baseColor,
    this.scaffoldBg,
    this.faButton,
    this.titleTextColor,
    required this.title,
    required this.body,
  }) : super(key: key);
  final Color? baseColor;
  final Color? titleTextColor;
  final String title;
  final Widget body;
  final Widget? faButton;
  final Color? scaffoldBg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: baseColor ?? Colors.blue,
        //  automaticallyImplyLeading: !Platform.isIOS,
        // leading: Platform.isIOS
        // ?  IconButton(onPressed: (){
        //   Get.back();
        //   }, icon: const Icon(Icons.close),)
        // : null,
        title: Text(
          title,
          overflow: TextOverflow.fade,
          style: TextStyles.largeTextBoldStyle().copyWith(
            color: titleTextColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to( const ViewFullHistory());
              },
              icon: const Icon(Icons.history)),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.to(() => const NotificationScreen(), arguments: 250);
            },
            icon: const Icon(Icons.message),
          ),
        ],
      ),
      floatingActionButton: faButton,
      drawer: const DrawerSide(),
      //drawer:  Platform.isAndroid  ? const DrawerSide()  : null,
      body: body,
    );
  }
}
