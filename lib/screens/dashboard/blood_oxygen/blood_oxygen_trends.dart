import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehealth/controller/blood_oxygen_controller/blood_oxygen_controller.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/blood_oxygen/manual_blood_oxygen_widget.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';

class BloodOxygenTrendsTab extends StatelessWidget {
  BloodOxygenTrendsTab({
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
    return GetBuilder<BloodOxygenController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
        child: Column(
          children: [
            //------- COMMON Portion --------//
            HorizontalIconedDataTileAdd(
              iconPath: "assets/images/mnu_bo_l.webp",
              data:
                  "${controller.getTheSortedList.lastOrNull?.oxygenlevel ?? 0}%",
              onAddClick: () {
                Get.to(() => const ManualBloodOxygenWidget());
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
            SizedBox(height: 12.h),
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
    });
  }
}
