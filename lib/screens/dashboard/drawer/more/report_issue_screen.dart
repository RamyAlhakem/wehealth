import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/styles/text_field_decoration.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/drawer/drawer_items.dart';
import 'package:wehealth/screens/dashboard/widgets/titled_radio.dart';

import '../../notifications/notification_screen.dart';

class ReportIssueScreen extends StatefulWidget {
  const ReportIssueScreen({Key? key}) : super(key: key);

  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  AndroidDeviceInfo? deviceInfo;
  bool isGithub = true;
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    deviceInfo = Get.find<StorageController>().deviceInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Platform.isAndroid  ? const DrawerSide()  : null,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("WeHealth"),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.teal,
        child: const Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Issue",
                          style: TextStyles.smallTextStyle(),
                        ),
                        const SizedBox(height: 32),
                        TextField(
                          controller: titleController,
                          decoration: decoration.copyWith(
                              labelText: "Title",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.auto),
                        ),
                        const SizedBox(height: 32),
                        TextField(
                          controller: descController,
                          decoration: decoration.copyWith(
                              labelText: "Description",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.auto),
                        ),
                        const SizedBox(height: 24),
                        Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            title: const Text("Device Info"),
                            tilePadding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            backgroundColor: Colors.white,
                            expandedAlignment: Alignment.topLeft,
                            childrenPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text("App Version : "),
                              const SizedBox(height: 5),
                              const Text("App version code : "),
                              const SizedBox(height: 5),
                              const Text("App build version : "),
                              const SizedBox(height: 5),
                              Text(
                                  "App release version : ${deviceInfo?.version.release}"),
                              const SizedBox(height: 5),
                              Text(
                                  "App SDK version : ${deviceInfo?.version.sdkInt}"),
                              const SizedBox(height: 5),
                              Text(
                                  "App build ID : ${deviceInfo?.version.previewSdkInt}"),
                              const SizedBox(height: 5),
                              Text("Device brand : ${deviceInfo?.brand}"),
                              const SizedBox(height: 5),
                              Text(
                                  "Device manufacturer : ${deviceInfo?.manufacturer}"),
                              const SizedBox(height: 5),
                              Text("Device name : ${deviceInfo?.device}"),
                              const SizedBox(height: 5),
                              Text("Device model : ${deviceInfo?.model}"),
                              const SizedBox(height: 5),
                              Text(
                                  "Device product name : ${deviceInfo?.product}"),
                              const SizedBox(height: 5),
                              Text(
                                  "Device hardware name : ${deviceInfo?.hardware}"),
                              const SizedBox(height: 5),
                              Text("ABIs : ${deviceInfo?.supportedAbis}"),
                              const SizedBox(height: 5),
                              Text(
                                  "ABIs (32bit) : ${deviceInfo?.supported32BitAbis}"),
                              const SizedBox(height: 5),
                              Text(
                                  "ABIs (64bit) : ${deviceInfo?.supported64BitAbis}"),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: TextStyles.smallTextStyle(),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitledRadioWidget<bool>(
                                value: true,
                                groupValue: isGithub,
                                onChange: (value) {
                                  setState(() {
                                    isGithub = value!;
                                  });
                                },
                                title: "GitHub"),
                            TitledRadioWidget<bool>(
                                value: false,
                                groupValue: isGithub,
                                onChange: (value) {
                                  setState(() {
                                    isGithub = value!;
                                  });
                                },
                                title: "Anonymous")
                          ],
                        ),
                        AnimatedCrossFade(
                          firstChild: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: usernameController,
                                  decoration: decoration.copyWith(
                                      labelText: "Username",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto),
                                ),
                                const SizedBox(height: 32),
                                TextField(
                                  controller: passwordController,
                                  decoration: decoration.copyWith(
                                      labelText: "Password",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto),
                                ),
                              ],
                            ),
                          ),
                          secondChild: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: TextField(
                              controller: emailController,
                              decoration: decoration.copyWith(
                                  labelText: "Email",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto),
                            ),
                          ),
                          crossFadeState: isGithub
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: const Duration(milliseconds: 500),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
