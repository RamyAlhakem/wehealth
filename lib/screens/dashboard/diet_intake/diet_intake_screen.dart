// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/dietary_controller/dietary_controller.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/screens/dashboard/diet_intake/diet_detail_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/single_data_span.dart';
import '../../../../global/constants/color_resources.dart';
import '../../../../global/styles/text_styles.dart';
import '../../../global/widgets/ios_close_appbar.dart';
import '../physical_activity/circular_percentage_gauge.dart';

class DietIntakeScreen extends StatefulWidget {
  const DietIntakeScreen({Key? key}) : super(key: key);

  @override
  State<DietIntakeScreen> createState() => DietIntakeScreenState();
}

class DietIntakeScreenState extends State<DietIntakeScreen> {
  final pageColor = Colors.green.shade800;
  onTap() {
    Get.to(() => DietIntakeDetailScreen());
  }

  String percentageValue = "0";
  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Dietary Intake",
      appBarColor: pageColor,
      body: GetBuilder<DietaryController>(builder: (storageController) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade800,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Dietary Intake",
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
                            data: "0",
                            unit: "Kcal",
                            title: "Total Calories Intake",
                          ),
                          //---------- One Span End ----------//
                          //---------- One Span Start ----------//
                          SingleDataSpanFS(
                            data: "0",
                            unit: "Kcal",
                            title: "Dietary Intake",
                          ),
                          //---------- One Span End ----------//
                          //---------- One Span Start ----------//
                          SingleDataSpanFS(
                            data:
                                storageController.todaysTotal.toStringAsFixed(1),
                            unit: "ml",
                            title: "Total Fluid Intake",
                          ),
                          //---------- One Span End ----------//
                          //---------- One Span Start ----------//
                          SingleDataSpanFS(
                            data: "2000",
                            unit: "ml",
                            title: "Recomended Daily Calories Intake",
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
                              title: "",
                              percentageValue: percentageValue,
                            ),
                          ),
                          Text(
                            "% Daily Calories Intake",
                            style: TextStyle(
                              fontFamily: 'monserrat',
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                    "assets/images/illustration_diet.webp")
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
          ),
        );
      }),
    );
  }
}
