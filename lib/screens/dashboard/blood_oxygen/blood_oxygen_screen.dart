import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/blood_oxygen_controller/blood_oxygen_controller.dart';
import 'package:wehealth/models/data_model/blood_oxygen_data_fetch_wrapper.dart';
import 'package:wehealth/screens/dashboard/blood_oxygen/blood_oxygen_detailscreen.dart';
import 'package:wehealth/screens/dashboard/widgets/meter_bloodoxygen_gauge.dart';
import '../../../global/constants/color_resources.dart';
import '../../../global/styles/text_styles.dart';
import '../../../global/widgets/ios_close_appbar.dart';
import '../widgets/indicator_data.dart';
import '../widgets/single_data_span.dart';

class BloodOxygenScreen extends StatefulWidget {
  const BloodOxygenScreen({Key? key}) : super(key: key);

  @override
  State<BloodOxygenScreen> createState() => _BloodOxygenScreenState();
}

class _BloodOxygenScreenState extends State<BloodOxygenScreen> {
  BloodOxygenData? data;

  @override
  void initState() {
    super.initState();
    data = Get.find<BloodOxygenController>().getTheSortedList.lastOrNull;
  }

  onTap() {
    Get.to(() => const BloodOxygenDetialsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Blood Oxygen",
      appBarColor: ColorResources.bloodOxygenScreenColor,
      body: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorResources.bloodOxygenScreenColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Blood Oxygen (SpO2)",
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
                          data: "${data?.oxygenlevel ?? 0}",
                          unit: "SpO2",
                          title: "Blood Oxygen",
                        ),
                        //---------- One Span End ----------//
                        //---------- One Span Start ----------//
                        SingleDataSpanFS(
                          data: "${data?.pulse ?? 0}",
                          unit: "bpm",
                          title: "Heart Rate",
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
                                  child: MeteredGaugeBloodOxygen(
                                    needleValue: double.parse(
                                      "${data?.oxygenlevel ?? 0}",
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        IndicatorData(
                                          color: Colors.green,
                                          tag: "Ideal",
                                        ),
                                        IndicatorData(
                                          color: Colors.red,
                                          tag: "Lethal",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Expanded(
                          flex: 5,
                          child: Image.asset("assets/images/spo2umch.webp"),
                        ),
                      ],
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
