import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screens/dashboard/drawer/drawer_items.dart';
import '../../screens/dashboard/notifications/notification_screen.dart';

class IosScaffoldWrapperWithFloat extends StatelessWidget {
  const IosScaffoldWrapperWithFloat(
      {Key? key,
      required this.title,
      required this.appBarColor,
      required this.body,
      required this.faButton,
      })
      : super(key: key);
  final String title;
  final Color appBarColor;
  final Widget body;
  final Widget faButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(title),
        automaticallyImplyLeading: !Platform.isIOS,
        leading: Platform.isIOS  
        ?  IconButton(onPressed: (){
          Get.back();
          }, icon: const Icon(Icons.close),) 
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
      drawer: Platform.isAndroid  ? const DrawerSide()  : null,
      floatingActionButton: faButton,
      body: body,

    );
  }
}