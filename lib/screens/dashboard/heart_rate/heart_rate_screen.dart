import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/heart_rate_controller/heart_rate_controller.dart';
import 'package:wehealth/screens/dashboard/heart_rate/heart_rate_detail_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/single_data_span.dart';

import '../../../global/constants/color_resources.dart';
import '../../../global/styles/text_styles.dart';
import '../drawer/drawer_items.dart';
import '../notifications/notification_screen.dart';
import '../widgets/indicator_data.dart';
import '../widgets/meter_heartrate_gauge.dart';

class HeartRateScreen extends StatefulWidget {
  const HeartRateScreen({Key? key}) : super(key: key);

  @override
  State<HeartRateScreen> createState() => _HeatrRateScreenState();
}

class _HeatrRateScreenState extends State<HeartRateScreen> {
  onTap() {
    Get.to(() => const HeartRateDetailScreen());
  }


  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
        final controller = Get.find<HeartRateController>();
       await Future.value(
            controller.getHeartRateDataByType(1, true));
         await Future.value(
            controller.getHeartRateDataByType(0, true));
      /* Get.showOverlay(
        loadingWidget: const OverlayLoadingIndicator(),
        asyncFunction: () async {
      }); */
    });
  }

  String gaugeRate = "50";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Platform.isAndroid ? const DrawerSide() : null,
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: const Text("Heart Rate"),
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
      body: GetBuilder<HeartRateController>(builder: (controller) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade400,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Heart Rate",
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
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            //---------- One Span Start ----------//
                            SingleDataSpanFS(
                              data: "${controller.typeCacheMap[1]?.lastOrNull?.heartRateQty ?? 0}",
                              unit: "bpm",
                              title: "Activity Heart Rate",
                            ),
                            //---------- One Span End ----------//
                            //---------- One Span Start ----------//
                            SingleDataSpanFS(
                              data: "${controller.typeCacheMap[0]?.lastOrNull?.heartRateQty ?? 0}",
                              unit: "bpm",
                              title: "Resting Heart Rate",
                            ),
                            //---------- One Span End ----------//
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: MeteredGaugeHeartRate(
                                          needleValue: double.parse(gaugeRate)),
                                    ),
                                    // SizedBox(height: 12),
                                    Expanded(
                                      flex: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 18.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IndicatorData(
                                              color: Colors.orange.shade700,
                                              tag: "Low",
                                            ),
                                            IndicatorData(
                                              color: Colors.greenAccent,
                                              tag: "Ideal",
                                            ),
                                            IndicatorData(
                                              color: Colors.red,
                                              tag: "High",
                                            ),
                                          ],
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
                                      "assets/images/heartrateillustration.webp")
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
