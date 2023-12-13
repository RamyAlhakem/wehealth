import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wehealth/controller/body_measurement_controller/body_measurement_controller.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_boxy_index_selector.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';

import '../../../global/styles/text_styles.dart';
import '../../../global/widgets/ios_close_appbar.dart';
import '../widgets/indicator_data.dart';

class BodyWaterDetailsScreen extends StatefulWidget {
  const BodyWaterDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyWaterDetailsScreen> createState() => _BodyWaterDetailsScreen();
}

class _BodyWaterDetailsScreen extends State<BodyWaterDetailsScreen> {
  int selectedIndex = 0;
  final pageColor = Colors.amber.shade700;
  final String iconPath = "assets/icons/mnu_bw_l.webp";
  final List<ChartData> chartData = [
    ChartData("2010", 35),
    ChartData("2011", 28),
    ChartData("2012", 34),
    ChartData("2013", 32),
    ChartData("2014", 60),
  ];

  @override
  void initState() {
    super.initState();
    final bodyMesure = Get.put(BodyMeasurementController());
    bodyMesure.fetchUserBodyWaterData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BodyMeasurementController>(
      builder: (bodyMeasureController) {
        return IosScaffoldWrapper(
          title: "Body Water",
          appBarColor: pageColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
            child: Column(
              children: [
                HorizontalIconedDataTileFacebook(
                  color: Colors.amber.shade700,
                  iconPath: iconPath,
                  data: bodyMeasureController.userBodyWaterData?[0].qty!.toStringAsFixed(1) ?? "-",
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
                // HeartRateDataTable(),
                Expanded(
                  child: SfCartesianChart(series: <ChartSeries>[
                    // Renders line chart
                    LineSeries<ChartData, int>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => int.parse(data.x),
                      yValueMapper: (ChartData data, _) => data.y,
                      markerSettings: MarkerSettings(
                        isVisible: true,
                        shape: DataMarkerType.circle,
                        height: 12,
                        width: 12,
                        borderColor: pageColor,
                        borderWidth: 2.5,
                      ),
                      color: pageColor,
                    )
                  ]),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Column(
                    children: [
                      const Expanded(
                        child: MeteredGaugeBodyWater(
                          needleValue: 50,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            IndicatorData(
                              color: Colors.red,
                              tag: "Low",
                              textColor: Colors.black,
                            ),
                            IndicatorData(
                              color: Colors.greenAccent,
                              tag: "Healthy",
                              textColor: Colors.black,
                            ),
                            IndicatorData(
                              color: Colors.red,
                              tag: "High",
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

class MeteredGaugeBodyWater extends StatelessWidget {
  const MeteredGaugeBodyWater({
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
                "Body Water\n 17.00%",
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
