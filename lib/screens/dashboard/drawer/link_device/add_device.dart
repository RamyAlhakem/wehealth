// /* 
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/screens/dashboard/drawer/drawer_items.dart';

import '../../notifications/notification_screen.dart';

class NewDeviceScreen extends StatefulWidget {
  const NewDeviceScreen({Key? key}) : super(key: key);

  @override
  State<NewDeviceScreen> createState() => _NewDeviceScreenState();
}

class _NewDeviceScreenState extends State<NewDeviceScreen> {
  List<String> scannedDevices = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Platform.isAndroid  ? const DrawerSide()  : null,
      appBar: AppBar(
        title: const Text("Devices"),
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              Get.to(() => const NotificationScreen());
            },
            icon: const Icon(Icons.message),
          ),
        ],
      ),
      body: scannedDevices.isNotEmpty
          ? ListView.builder(
              itemCount: scannedDevices.length,
              itemBuilder: (context, index) => const ListTile(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 24,
                ),
                child: Column(
                  children: [
                    Image.asset("assets/images/pairdevice1.png"),
                    const SizedBox(height: 8),
                    Text("ok"),
                    Image.asset("assets/images/second.png"),
                  ],
                ),
              ),
            ),
    );
  }
}

//  */