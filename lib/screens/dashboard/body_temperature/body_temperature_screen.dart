import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wehealth/controller/body_temp_controller/body_temp_controller.dart';
import 'package:wehealth/models/data_model/body_temp_fetch_wrapper.dart';
import 'package:wehealth/screens/dashboard/body_temperature/body_temp_detail_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/single_data_span.dart';

import '../../../global/constants/color_resources.dart';
import '../../../global/styles/text_styles.dart';
import '../../../global/widgets/ios_close_appbar.dart';
import '../widgets/custom_gauge.dart';
import '../widgets/indicator_data.dart';

class BodyTemperatureScreen extends StatefulWidget {
  const BodyTemperatureScreen({Key? key}) : super(key: key);

  @override
  State<BodyTemperatureScreen> createState() => _HeatrRateScreenState();
}

class _HeatrRateScreenState extends State<BodyTemperatureScreen> {
  BodyTempData? tempData;
  onTap() {
    Get.to(() => const BodyTempDetialsScreen());
  }

  @override
  void initState() {
    super.initState();
    tempData =
        Get.find<BodyTemperatureController>().tempDataSortedByDate.lastOrNull;
  }

  String gaugeRate = "0.0";
  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.red.shade700;
    return IosScaffoldWrapper(
      title: "Body Temperature",
      appBarColor: baseColor,
      body: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.shade700,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Body Temperature",
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
                            data: "${tempData?.pursedTempC ?? 0}",
                            unit: "Celsisus",
                            title: "Body Temperature",
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
                                      needleValue: tempData?.pursedTempC ?? double.parse(gaugeRate),
                                      title: "Body Temperature",
                                      start: 0,
                                      end: 45,
                                      textColor: Colors.white,
                                      gaugeRanges: [
                                        GaugeRange(
                                            startValue: 0,
                                            endValue: 34,
                                            color: Colors.pink.shade200),
                                        GaugeRange(
                                            startValue: 35,
                                            endValue: 38,
                                            color: Colors.green),
                                        GaugeRange(
                                            startValue: 39,
                                            endValue: 45,
                                            color: Colors.red),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 18.0),
                                      child: Wrap(
                                        runSpacing: 8,
                                        children: [
                                          IndicatorData(
                                            color: Colors.orange.shade700,
                                            tag: "Hypothermia",
                                          ),
                                          const IndicatorData(
                                            color: Colors.greenAccent,
                                            tag: "Normal",
                                          ),
                                          const IndicatorData(
                                            color: Colors.red,
                                            tag: "Fever",
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
                                Image.asset("assets/images/temperature.webp"),
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
      ),
    );
  }
}
