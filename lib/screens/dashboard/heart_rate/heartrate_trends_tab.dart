import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehealth/controller/heart_rate_controller/heart_rate_controller.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/heart_rate/add_manual_heartrate.dart';

import '../../../global/styles/text_styles.dart';

class HeartRateTrendsTab extends StatelessWidget {
  HeartRateTrendsTab({
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
      child: GetBuilder<HeartRateController>(
        builder: (controller) {
          return Column(
            children: [
              //------- COMMON Portion --------//
              HorizontalAddCameraIconedDataTile(
                data: "${controller.typeCacheMap[1]?.lastOrNull?.heartRateQty ?? 0}",
                pageColor: pageColor,
                addButtonClick: () {
                  Get.to(() => const ManualHeartRateWidget());
                },
                cameraButtonClick: () {},
              ),
              // Horizontal,
              //------- COMMON Portion --------//
              const SizedBox(height: 12),
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
              SizedBox(height: 8),
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
              SizedBox(height: 8),
              
            ],
          );
        }
      ),
    );
  }
}

class HorizontalAddCameraIconedDataTile extends StatelessWidget {
  const HorizontalAddCameraIconedDataTile({
    Key? key,
    this.data,
    required this.pageColor,
    required this.addButtonClick,
    required this.cameraButtonClick, this.iconPath,
  }) : super(key: key);

  final String? data;
  final String? iconPath;
  final Color pageColor;
  final VoidCallback addButtonClick;
  final VoidCallback cameraButtonClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 55.h,
        child: Row(
          children: [
            Image.asset(
              iconPath ??
              "assets/images/mnu_heartrate_l.webp",
              color: pageColor,
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  data ?? "00",
                  style: TextStyles.smallTextStyle()
                      .copyWith(color: pageColor),
                ),
                Text(
                  "bpm",
                  style: TextStyles.extraSmallText14BStyle()
                      .copyWith(color: pageColor),
                )
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: addButtonClick,
                icon: Icon(
                  Icons.add_circle,
                  color: pageColor,
                  size: 50,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: cameraButtonClick,
                icon: Icon(
                  Icons.camera_alt_outlined,
                  color: pageColor,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
