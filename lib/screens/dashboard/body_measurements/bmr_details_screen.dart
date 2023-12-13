import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehealth/controller/body_measurement_controller/body_measurement_controller.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_boxy_index_selector.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';

import '../../../global/widgets/ios_close_appbar.dart';

class BMRDetailsScreen extends StatefulWidget {
  const BMRDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BMRDetailsScreen> createState() => _BMRDetailsScreen();
}

class _BMRDetailsScreen extends State<BMRDetailsScreen> {
  int selectedIndex = 0;
  final String iconPath = "assets/images/mnu_bf_l.webp";
  final pageColor = Colors.amber.shade700;
  final List<ChartData> chartData = <ChartData>[
    ChartData('1', 0),
    ChartData('2', 0),
    ChartData('3', 0),
    ChartData('4', 0),
    ChartData('5', 0),
    ChartData('6', 0),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BodyMeasurementController>(
      builder: (bodyMeasureController) {
        return IosScaffoldWrapper(
          title: "BMR",
          appBarColor: Colors.amber.shade700,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
            child: Column(
              children: [
                HorizontalIconedDataTileFacebook(
                  color: Colors.amber.shade700,
                  iconPath: iconPath,
                  data: "${bodyMeasureController.userbodyBmrData![0].qty}",
                  unit: "kcal",
                ),
                HorizontalBoxyIndexSelector(
                  selectedIndex: selectedIndex,
                  itemsList: const <String>[
                    "Today",
                    "7",
                    "14",
                    "30",
                    "60",
                    "90",
                  ],
                  onChange: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: SfCartesianChart(series: <ChartSeries>[
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
                  ],),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
