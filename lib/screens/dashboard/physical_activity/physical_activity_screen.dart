// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/google_fit_controller/google_fit_controller.dart';
import 'package:wehealth/global/constants/functions_extensions.dart';
import 'package:wehealth/screens/dashboard/widgets/single_data_span.dart';
import '../../../../global/constants/color_resources.dart';
import '../../../../global/styles/text_styles.dart';
import '../drawer/drawer_items.dart';
import '../notifications/notification_screen.dart';
import 'activity_screen.dart';
import 'circular_percentage_gauge.dart';

class PhysicalActivityScreen extends StatefulWidget {
  const PhysicalActivityScreen({Key? key}) : super(key: key);

  @override
  State<PhysicalActivityScreen> createState() => _PhysicalActivityScreenState();
}

class _PhysicalActivityScreenState extends State<PhysicalActivityScreen> {
  onTap() {
    Get.to(() => PhysicalActivityDetailsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Platform.isAndroid ? const DrawerSide() : null,
      appBar: AppBar(
        title: const Text("Physical Activity"),
        backgroundColor: ColorResources.physicalActivityScreenColor,
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
      body: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorResources.physicalActivityScreenColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: GetBuilder<GoogleFitController>(builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Physical Activity",
                    style: TextStyles.extraSmallTextStyle().copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
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
                            data: /* controller.dailySteps.toStringAsFixed(0) */
                                "",
                            unit: "Steps",
                            title: "Daily Steps",
                          ),
                          //---------- One Span End ----------//
                          //---------- One Span Start ----------//
                          SingleDataSpanFS(
                            data: /* controller.dailyDistance.toStringAsFixed(0) */
                                "",
                            unit: "meters",
                            title: "Distance Travelled",
                          ),
                          //---------- One Span End ----------//
                          //---------- One Span Start ----------//
                          SingleDataSpanFS(
                            data: /* controller.dailyActiveEnergy.toStringAsFixed(0) */
                                "",
                            unit: "kCal",
                            title: "Daily Calories Burned from Steps",
                          ),
                          //---------- One Span End ----------//
                          //---------- One Span Start ----------//
                          SingleDataSpanFS(
                            data: "-:-",
                            unit: "hh:mm",
                            title: "Daily Exercise Time",
                          ),
                          //---------- One Span End ----------//
                          //---------- One Span Start ----------//
                          SingleDataSpanFS(
                            data: /* controller.monthlyActiveEnergy.toStringAsFixed(0) */
                                "",
                            unit: "kCal",
                            title: "Total Calories Burned",
                          ),
                          //---------- One Span End ----------//
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CircularPercentageGauge(
                              percentageValue:
                                  /* ("${nanConverter(controller.dailySteps / int.parse(controller.stepTarget)) * 100}") */ "0",
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                    "assets/images/illustration_physical_activity.webp")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
              ],
            );
          }),
        ),
      ),
    );
  }
}
