import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/blood_pressure_controller/blood_pressure_controller.dart';
import 'package:wehealth/models/data_model/user_bp_model.dart';
import 'package:wehealth/screens/dashboard/blood_pressure/blood_pressure_details.dart';
import 'package:wehealth/screens/dashboard/widgets/single_data_span.dart';

import '../../../global/constants/color_resources.dart';
import '../../../global/styles/text_styles.dart';
import '../../../global/widgets/ios_close_appbar.dart';

class BloodPressureScreen extends StatefulWidget {
  const BloodPressureScreen({Key? key}) : super(key: key);

  @override
  State<BloodPressureScreen> createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
  BPData? _bpData;

  @override
  void initState() {
    super.initState();
    _bpData =
        Get.find<BloodPressureController>().currentSortedList.lastOrNull;
  }

  onTap() {
    Get.to(() => const BloodPressureDetailsScreen());
  }

  String gaugeRate = "0";
  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      appBarColor: ColorResources.bloodPressureScreenColor,
      title: "Blood Pressure",
      body: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorResources.bloodPressureScreenColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Blood Pressure",
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
                            data: "${_bpData?.systolic ?? 0}",
                            unit: "mmHg",
                            title: "Systolic",
                          ),
                          //---------- One Span End ----------//
                          //---------- One Span Start ----------//
                          SingleDataSpanFS(
                            data: "${_bpData?.diastolic ?? 0}",
                            unit: "mmHg",
                            title: "Diastolic",
                          ),
                          //---------- One Span End ----------//
                          //---------- One Span Start ----------//
                          SingleDataSpanFS(
                            data: "${_bpData?.pulserate ?? 0}",
                            unit: "bpm",
                            title: "Pulse Rate",
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset("assets/images/illustration_blood_pressure.webp")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
