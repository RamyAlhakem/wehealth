// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wehealth/controller/profile_controller/profile_controller.dart';
import '/screens/dashboard/body_measurements/body_weight/body_weight_detail_screen.dart';
import '/screens/dashboard/widgets/custom_gauge.dart';
import 'package:wehealth/screens/dashboard/widgets/single_data_span.dart';
import '../../../controller/body_measurement_controller/body_measurement_controller.dart';
import '../../../global/constants/color_resources.dart';
import '../../../global/styles/text_styles.dart';
import '../../../global/widgets/ios_close_appbar.dart';
import '../widgets/indicator_data.dart';

class BodyMeasurementsScreen extends StatefulWidget {
  const BodyMeasurementsScreen({Key? key}) : super(key: key);

  @override
  State<BodyMeasurementsScreen> createState() => _HeatrRateScreenState();
}

class _HeatrRateScreenState extends State<BodyMeasurementsScreen> {
  onTap() {
    Get.to(() => BodyWeightDetailScreen());
  }

  String gaugeRate = "24";
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BodyMeasurementController>(
      builder: (controller) {
        return GetBuilder<ProfileController>(
          builder: (profileController) {
            return IosScaffoldWrapper(
              title: "Body Measurements",
              appBarColor: Colors.yellow.shade800,
              body: GestureDetector(
                onTap: onTap,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade800,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Body Measurements",
                          style: TextStyles.smallTextStyle()
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
                                    data:
                                        "${controller.getDateSortedBodyWeightData().lastOrNull?.qty ?? 0}",
                                    unit: "kg",
                                    title: "Weight",
                                  ),
                                  //---------- One Span End ----------//
                                  //---------- One Span Start ----------//
                                  SingleDataSpanFS(
                                    data: profileController.bmi.toStringAsFixed(0),
                                    unit: "kg/m2",
                                    title: "BMI",
                                  ),
                                  //---------- One Span End ----------//
                                  //---------- One Span Start ----------//
                                  SingleDataSpanFS(
                                    data: "-",
                                    unit: "%",
                                    title: "Body Fat",
                                  ),
                                  //---------- One Span End ----------//
                                  //---------- One Span Start ----------//
                                  SingleDataSpanFS(
                                    data: "-",
                                    unit: "kg",
                                    title: "Muscle Mass",
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
                                            child: CustomGauge(
                                              needleValue: double.parse(gaugeRate),
                                              title: "BMI",
                                              start: 0,
                                              end: 40,
                                              textColor: Colors.white,
                                              gaugeRanges: [
                                                GaugeRange(
                                                    startValue: 0,
                                                    endValue: 18,
                                                    color: Colors.pink.shade200),
                                                GaugeRange(
                                                    startValue: 18,
                                                    endValue: 25,
                                                    color: Colors.green),
                                                GaugeRange(
                                                    startValue: 25,
                                                    endValue: 30,
                                                    color: Colors.yellow),
                                                GaugeRange(
                                                    startValue: 30,
                                                    endValue: 40,
                                                    color: Colors.red),
                                              ],
                                            ),
                                          ),
                                          // SizedBox(height: 12),
                                          Expanded(
                                            flex: 5,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 18.0),
                                              child: SizedBox(
                                                child: Wrap(
                                                  spacing: 20,
                                                  runSpacing: 8,
                                                  alignment: WrapAlignment.center,
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.center,
                                                  direction: Axis.vertical,
                                                  children: [
                                                    IndicatorData(
                                                      color: Colors.pinkAccent,
                                                      tag: "Under",
                                                    ),
                                                    IndicatorData(
                                                      color: Colors.green,
                                                      tag: "Healthy",
                                                    ),
                                                    IndicatorData(
                                                      color: Colors.yellow,
                                                      tag: "Over",
                                                    ),
                                                    IndicatorData(
                                                      color: Colors.red,
                                                      tag: "Obese",
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
                                          "assets/images/illustration_body_measurement.webp",
                                          height: 180,
                                        )
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
        );
      },
    );
  }
}
