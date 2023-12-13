// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/blood_glucose_controller/blood_glucose_controller.dart';
import 'package:wehealth/screens/dashboard/blood_glucose/blood_glucose_detail_screen.dart';
import '../../../global/constants/color_resources.dart';
import '../../../global/styles/text_styles.dart';
import '../../../global/widgets/ios_close_appbar.dart';
import '../widgets/single_data_span.dart';

class BloodGlucoseScreen extends StatefulWidget {
  const BloodGlucoseScreen({Key? key}) : super(key: key);

  @override
  State<BloodGlucoseScreen> createState() => _BloodGlucoseScreenState();
}

class _BloodGlucoseScreenState extends State<BloodGlucoseScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<BloodGlucoseController>().fetchUserBloodGlucoseData();
  }
  

  onTap() {
    Get.to(() => BloodGlucoseDetialsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Blood Glucose",
      appBarColor: Colors.grey.shade400,
      body: GetBuilder<BloodGlucoseController>(builder: (controller) {
        // log("${(controller.getBloodGlucoseDataByType("BeforeMeal").lastOrNull?.toJson().toString())}");
        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorResources.bloodGlucoseScreenColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Blood Glucose",
                    style: TextStyles.normalTextBoldStyle()
                        .copyWith(color: Colors.black),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: ColorResources.colorBlack,
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
                            data:
                                "${((controller.getBloodGlucoseDataByType("BeforeMeal").lastOrNull?.glucoseLevel) ?? 0).toPrecision(1)}",
                            unit: "mmol/L",
                            title: "Before Meal",
                            color: ColorResources.colorBlack,
                          ),
                          //---------- One Span End ----------//
                          //---------- One Span Start ----------//
                          SingleDataSpanFS(
                            data:
                                "${((controller.getBloodGlucoseDataByType("AfterMeal").lastOrNull?.glucoseLevel) ?? 0).toPrecision(1)}",
                            unit: "mmol/L",
                            title: "After Meal",
                            color: ColorResources.colorBlack,
                          ),
                          //---------- One Span End ----------//
                          //---------- One Span Start ----------//
                          SingleDataSpanFS(
                            data:
                                "${((controller.getBloodGlucoseDataByType("BeforeBed").lastOrNull?.glucoseLevel) ?? 0).toPrecision(1)}",
                            unit: "mmol/L",
                            title: "Before Bed",
                            color: ColorResources.colorBlack,
                          ),
                          //---------- One Span End ----------//
                          //---------- One Span Start ----------//
                          SingleDataSpanFS(
                            data:
                                "${((controller.getBloodGlucoseDataByType("Fasting").lastOrNull?.glucoseLevel) ?? 0).toPrecision(1)}",
                            unit: "mmol/L",
                            title: "Fasting",
                            color: ColorResources.colorBlack,
                          ),
                          //---------- One Span End ----------//
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(flex: 5, child: Container()),
                          Expanded(
                            flex: 5,
                            child: Image.asset(
                                "assets/images/illustration_blood_glucose.webp"),
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
