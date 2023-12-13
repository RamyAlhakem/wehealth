import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/google_fit_controller/google_fit_controller.dart';
import 'package:wehealth/screens/dashboard/widgets/custom_gauge.dart';
import '../../../global/constants/color_resources.dart';
import '../../../global/styles/text_styles.dart';
import '../drawer/drawer_items.dart';
import '../notifications/notification_screen.dart';
import '../widgets/indicator_data.dart';
import '../widgets/single_data_span.dart';
import 'sleep_detail_screen.dart';

//import 'dart:io' show Platform;

class SleepScreen extends StatefulWidget {
  const SleepScreen({Key? key}) : super(key: key);

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<GoogleFitController>().getSleepData();
  }

  String _hourMinuteConvertion(healthData) {
    if (healthData != null) {
      double minute =
          double.tryParse(healthData.value.toJson().entries.first.value as String) ?? 0;
      final data = Duration(minutes: minute.toInt());
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(data.inMinutes.remainder(60));
      return "${twoDigits(data.inHours)}:$twoDigitMinutes";
    }
    return "-";
  }



  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('hh:mm a');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9176B4),
        title: const Text("Sleep"),
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
     
      drawer:  Platform.isAndroid  ? const DrawerSide()  : null,
     
      body: GestureDetector(
        onTap: () {
          Get.to(() => const SleepDetailsScreen());
        },
        child: GetBuilder<GoogleFitController>(builder: (controller) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorResources.sleepScreenColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Sleep",
                    style: TextStyles.normalTextBoldStyle()
                        .copyWith(color: Colors.white),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: ColorResources.colorWhite,
                ),
                const SizedBox(height: 8),
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //---------- One Span Start ----------//
                          SingleDataSpanFS(
                            data: _hourMinuteConvertion(controller.lastSleepData),
                            unit: "hh:mm",
                            title: "Daily Sleep Time.",
                          ),
                          // //---------- One Span End ----------//
                          // //---------- One Span Start ----------//
                          SingleDataSpanFS(
                            data: controller.lastSleepData != null ? timeFormat.format(controller.lastSleepData!.dateTo) : "-",
                            unit: "",
                            title: "Sleep time.",
                          ),
                          // //---------- One Span End ----------//
                          SingleDataSpanFS(
                            data: controller.lastSleepData != null ? timeFormat.format(controller.lastSleepData!.dateFrom) : "-",
                            unit: "",
                            title: "Wake up time.",
                          ),
                          //---------- One Span End ----------//
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: CustomGauge(
                                      title: "Sleep\n Quality",
                                      textColor: Colors.white,
                                      needleValue: 4,
                                      start: 0,
                                      end: 12,
                                      gaugeRanges: [

                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 18.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            IndicatorData(
                                              color: Color(0xFF34A6FD),
                                              tag: "Deep Sleep",
                                                                                       
                                              isHorizontal: true,
                                            ),
                                            IndicatorData(
                                              color: Color(0xFF7193F8),
                                              tag: "Sleep",
                                              isHorizontal: true,
                                            ),
                                            IndicatorData(
                                              color: Color(0xFFF7E694),
                                              tag: "Awake",
                                              isHorizontal: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                    "assets/images/illustration_sleep.webp")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
              ],
            ),
          );
        }),
      ),
    );
  }
}