import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wehealth/controller/body_measurement_controller/body_measurement_controller.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_boxy_index_selector.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';

import '../../../global/styles/text_styles.dart';
import '../../../global/widgets/ios_close_appbar.dart';
import '../widgets/indicator_data.dart';

class BodyFatDetailsScreen extends StatefulWidget {
  const BodyFatDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyFatDetailsScreen> createState() => _BodyFatDetailsScreen();
}

class _BodyFatDetailsScreen extends State<BodyFatDetailsScreen> {
  int selectedIndex = 0;
  final String iconPath = "assets/images/mnu_bf_l.webp";
  final List<ChartData> chartData = <ChartData>[
    ChartData('5', 541),
    ChartData('8', 818),
    ChartData('6', 151),
    ChartData('11', 1302),
    ChartData('9', 2017),
    ChartData('13', 1683),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BodyMeasurementController>(
      builder: (bodyMeasureController) {
        return IosScaffoldWrapper(
          title: "Body Fat",
          appBarColor: Colors.amber.shade700,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
            child: Column(
              children: [
                HorizontalIconedDataTileFacebook(
                  color: Colors.amber.shade700,
                  iconPath: iconPath,
                  data: bodyMeasureController.userbodyFatData![0].qty!.toStringAsFixed(1),
                  unit: "%",
                ),
                HorizontalBoxyIndexSelector(
                  selectedIndex: selectedIndex,
                  itemsList: const <String>["Today", "7", "14", "30", "60", "90"],
                  onChange: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: SfCartesianChart(
                    series: [
                      ColumnSeries<ChartData, int>(
                        dataSource: chartData,
                        xValueMapper: (ChartData sales, _) => int.parse(sales.x),
                        yValueMapper: (ChartData sales, _) => sales.y,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: MeteredGaugeBodyFat(
                          needleValue: bodyMeasureController.userbodyFatData![0].qty!.toDouble(),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IndicatorData(
                              color: Colors.red,
                              tag: "Thin",
                              textColor: Colors.black,
                            ),
                            IndicatorData(
                              color: Colors.greenAccent,
                              tag: "Healthy",
                              textColor: Colors.black,
                            ),
                            IndicatorData(
                              color: Colors.red,
                              tag: "Near Fat",
                              textColor: Colors.black,
                            ),
                            IndicatorData(
                              color: Colors.greenAccent,
                              tag: "Light Fat",
                              textColor: Colors.black,
                            ),
                            IndicatorData(
                              color: Colors.greenAccent,
                              tag: "Serious Obese",
                              textColor: Colors.black,
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
        );
      }
    );
  }
}

class MeteredGaugeBodyFat extends StatelessWidget {
  const MeteredGaugeBodyFat({
    Key? key,
    required this.needleValue,
  }) : super(key: key);
  final double needleValue;
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          minimum: 0,
          maximum: 100,
          ranges: [
            GaugeRange(
              startValue: 0,
              endValue: 93,
              color: Colors.red,
            ),
            GaugeRange(
              startValue: 93,
              endValue: 100,
              color: Colors.green,
            ),
          ],
          pointers: [
            NeedlePointer(
              value: needleValue,
              enableAnimation: true,
              animationDuration: 1000,
              needleEndWidth: 5,
              knobStyle: const KnobStyle(color: Colors.grey),
            ),
          ],
          annotations: [
            GaugeAnnotation(
              widget: Text(
                "Body Fat\n ${needleValue.toStringAsFixed(1)}",
                textAlign: TextAlign.center,
                style: TextStyles
                    .extraSmallTextStyle() /* .copyWith(color: Colors.white) */,
              ),
              positionFactor: 0.9,
              angle: 90,
            )
          ],
        )
      ],
    );
  }
}
