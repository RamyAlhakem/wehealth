import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wehealth/controller/appt_controller/appt_controller.dart';
import 'package:wehealth/screens/dashboard/drawer/drawer_items.dart';
import 'package:wehealth/screens/dashboard/drawer/home/tele_consultation/twilio_config.dart';
import 'package:wehealth/screens/dashboard/drawer/home/tele_consultation/twillio_room.dart';
import 'package:wehealth/screens/dashboard/widgets/all_caught_up_widget.dart';
import 'package:wehealth/screens/dashboard/widgets/appt_details_widget.dart';

import '../../../notifications/notification_screen.dart';

class TeleConsultationScreen extends StatefulWidget {
  const TeleConsultationScreen({Key? key}) : super(key: key);

  @override
  State<TeleConsultationScreen> createState() => _TeleConsultationScreenState();
}

class _TeleConsultationScreenState extends State<TeleConsultationScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ApptController>().fetchUserApptList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Platform.isAndroid  ? const DrawerSide()  : null,
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text("Tele-Consultation"),
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
      body: GetBuilder<ApptController>(
        builder: (controller) {
          return (controller.userApptTeleConsultationList == null ||
                  controller.userApptTeleConsultationList!.isEmpty)
              ? GestureDetector(
                  onTap: () {
                    Get.to(() => TwilioRoom(accessToken: ""));
                  },
                  child: const AllCaughtUpWidget(
                      endLine: ""),
                )
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: controller.userApptTeleConsultationList!.length,
                    itemBuilder: (context, index) {
                      log(controller.userApptTeleConsultationList![index]
                          .toJson()
                          .toString());
                      return ApptDetailTile(
                        data: controller.userApptTeleConsultationList![index],
                        isTele: true,
                        teleFunc: () async {

                          final controllerClass = TwilioFunctionsService.instance;
                          final res = await controllerClass.createToken(
                              controller.userApptTeleConsultationList![index]
                                  .patientName!,
                              controller
                                  .userApptTeleConsultationList![index].id!);

                            if(Platform.isIOS){
                              Get.to(
                                () => TwilioRoom(
                                  accessToken: res['token'],
                                ),
                              );
                            
                            }
                        },
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
