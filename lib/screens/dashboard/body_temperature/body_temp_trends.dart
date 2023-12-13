import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehealth/controller/body_temp_controller/body_temp_controller.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';
import 'package:collection/collection.dart';

import 'manual_body_temp_screen.dart';

class BodyTempTrendsTab extends StatelessWidget {
  BodyTempTrendsTab({
    Key? key,
  }) : super(key: key);

  final baseColor = Colors.amber.shade700;

  final List<ChartData> chartData = [
    ChartData("2010", 35),
    ChartData("2011", 28),
    ChartData("2012", 34),
    ChartData("2013", 32),
    ChartData("2014", 60),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BodyTemperatureController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
          child: Column(
            children: [
              //------- COMMON Portion --------//
              HorizontalIconedDataTileAdd(
                baseColor: baseColor,
                data:
                    "${controller.tempDataSortedByDate.lastOrNull?.pursedTempC.toStringAsFixed(1) ?? 0.0}",
                unit: "Celsisus",
                iconPath: "assets/images/mnu_bt_l.webp",
                seconderyWidget: Image.asset(
                  "assets/icons/devices/bluetooth_glucose_disconnect.webp",
                ),
                onAddClick: () {
                  Get.to(() => const ManualBodyTempWidget());
                },
              ),
              //------- COMMON Portion --------//
              SizedBox(height: 12),
              Expanded(
                child: SfCartesianChart(
                  series: <ChartSeries>[
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
                        borderColor: baseColor,
                        borderWidth: 2.5,
                      ),
                      color: baseColor,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Difference Chart"),
              ),
              SizedBox(height: 8),
            ],
          ),
        );
      }
    );
  }
}
