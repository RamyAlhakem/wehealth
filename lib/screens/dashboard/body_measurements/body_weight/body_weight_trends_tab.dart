import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehealth/controller/body_measurement_controller/body_measurement_controller.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';


class BodyWeightTrendsTab extends StatelessWidget {
  BodyWeightTrendsTab({
    Key? key,
  }) : super(key: key);

  final pageColor = Colors.amber.shade700;

  final List<ChartData> chartData = [
    ChartData("2010", 35),
    ChartData("2011", 28),
    ChartData("2012", 34),
    ChartData("2013", 32),
    ChartData("2014", 60),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
      child: GetBuilder<BodyMeasurementController>(
        builder: (bodyMeasureController) {
          return Column(
            children: [
              //------- COMMON Portion --------//
              HorizontalIconedDataTileAdd(
                data: "${bodyMeasureController.getDateSortedBodyWeightData().lastOrNull?.qty ?? "-" " "}",
                unit: 'kg',
                iconPath: 'assets/icons/mnu_bweight_l.webp',
              ),
              // Horizontal,
              //------- COMMON Portion --------//
              // const SizedBox(height: 12),
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
                        borderColor: pageColor,
                        borderWidth: 2.5,
                      ),
                      color: pageColor,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8),
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
                        borderColor: pageColor,
                        borderWidth: 2.5,
                      ),
                      color: pageColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text('Difference Chart'),
              const SizedBox(height: 8),
            ],
          );
        }
      ),
    );
  }
}
