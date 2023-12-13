import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehealth/controller/blood_glucose_controller/blood_glucose_controller.dart';
import 'package:wehealth/controller/user_devices_controller/user_devices_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';

import 'manual_blood_glucose_screen.dart';

class BloodGlucoseTrendsTab extends StatelessWidget {
  BloodGlucoseTrendsTab({
    Key? key,
  }) : super(key: key);

  final baseColor = Colors.grey;
  final List<ChartData> chartData = [
    ChartData("2010", 35),
    ChartData("2011", 28),
    ChartData("2012", 34),
    ChartData("2013", 32),
    ChartData("2014", 60),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BloodGlucoseController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
        child: Column(
          children: [
            //------- COMMON Portion --------//
            HorizontalIconedDataTileAdd(
              iconPath: "assets/icons/mnu_bg_l.webp",
              data:
                  "${(controller.getBloodGlucoseDataByType("BeforeMeal").lastOrNull?.glucoseLevel ?? 0).toPrecision(2)}",
              unit: "mmol/L",
              baseColor: baseColor,
              seconderyWidget: Get.find<UserDevicesController>()
                      .hasBloodGlucoseDevice
                  ? Image.asset(
                      "assets/icons/devices/bluetooth_glucose_disconnect.webp")
                  : const SizedBox(),
              onAddClick: () {
                Get.to(() => const ManualBloodGlucoseWidget());
              },
            ),
            //------- COMMON Portion --------//
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
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                "Before Meal",
                style: TextStyles.extraSmallTextStyle(),
              ),
            ),
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
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                "After Meal",
                style: TextStyles.extraSmallTextStyle(),
              ),
            ),
          ],
        ),
      );
    });
  }
}
