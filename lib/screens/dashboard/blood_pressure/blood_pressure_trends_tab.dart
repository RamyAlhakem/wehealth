// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:wehealth/controller/blood_pressure_controller/blood_pressure_controller.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/blood_pressure/manual_blood_pressure.dart';

import '../../../controller/user_devices_controller/user_devices_controller.dart';
import '../../../global/styles/text_styles.dart';

class BloodPressureChart {
  final DateTime date;
  final double data;

  BloodPressureChart({
    required this.date,
    required this.data,
  });
}

class BloodPressureTrendsTab extends StatelessWidget {
  BloodPressureTrendsTab({
    Key? key,
  }) : super(key: key);

  final pageColor = Colors.amber.shade700;

  final List<ChartData> chartData = [
    ChartData("0", 35),
    ChartData("1", 28),
    ChartData("2", 34),
    ChartData("3", 32),
    ChartData("4", 60),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
      child: GetBuilder<BloodPressureController>(builder: (controller) {
        return Column(
          children: [
            //------- COMMON Portion --------//
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 60.h,
                child: Row(
                  children: [
                    InkWell(
                      child: Image.asset(
                        "assets/images/mnu_bp_l.webp",
                        color: Colors.orange.shade700,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${controller.currentSortedList.lastOrNull?.systolic ?? 0}/${controller.currentSortedList.lastOrNull?.diastolic ?? 0}",
                          style: TextStyles.largeTextBoldStyle()
                              .copyWith(color: Colors.orange.shade700),
                        ),
                        Text(
                          "mmHg",
                          style: TextStyles.smallTextBoldStyle()
                              .copyWith(color: Colors.orange.shade700),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: !Get.find<UserDevicesController>()
                              .hasBloodPressureDevice
                          ? const SizedBox()
                          : Image.asset(
                              "assets/icons/devices/bp_microlife_not_connected.png",
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Get.to(() => const ManualBloodPressureWidget());
                        },
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.orange.shade700,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //------- COMMON Portion --------//
            const SizedBox(height: 12),
            Expanded(
              child: SfCartesianChart(
                primaryYAxis: NumericAxis(
                  minimum: 50,
                ),
                primaryXAxis: DateTimeAxis(
                  intervalType: DateTimeIntervalType.days,
                  visibleMaximum: (controller.currentSortedList ?? [])
                          .map(
                            (bpData) => BloodPressureChart(
                              date: bpData.recordDate,
                              data: (bpData.diastolic ?? 0).toDouble(),
                            ),
                          )
                          .toList()
                          .lastOrNull
                          ?.date ??
                      DateTime.now(),
                  visibleMinimum: (
                    (controller.currentSortedList ?? [])
                          .map(
                            (bpData) => BloodPressureChart(
                              date: bpData.recordDate,
                              data: (bpData.diastolic ?? 0).toDouble(),
                            ),
                          )
                          .toList()
                          .lastOrNull
                          ?.date ??
                      DateTime.now()
                  ).subtract(15.days),
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                ),
                series: <ChartSeries>[
                  // Renders line chart

                  LineSeries<BloodPressureChart, DateTime>(
                    dataSource: (controller.currentSortedList ?? [])
                        .map(
                          (bpData) => BloodPressureChart(
                            date: bpData.recordDate,
                            data: (bpData.diastolic ?? 0).toDouble(),
                          ),
                        )
                        .toList(),
                    xAxisName: "Time",
                    xValueMapper: (data, _) => data.date,
                    yValueMapper: (data, _) => data.data,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                    ),
                    isVisible: true,
                    isVisibleInLegend: true,
                    markerSettings: MarkerSettings(
                      isVisible: true,
                      shape: DataMarkerType.circle,
                      height: 5,
                      width: 5,
                      borderColor: pageColor,
                      borderWidth: 2.5,
                    ),
                    color: pageColor,
                  ),
                  LineSeries<BloodPressureChart, DateTime>(
                    dataSource: (controller.currentSortedList ?? [])
                        .map(
                          (bpData) => BloodPressureChart(
                            date: bpData.recordDate,
                            data: (bpData.systolic ?? 0).toDouble(),
                          ),
                        )
                        .toList(),
                    xAxisName: "Time",
                    xValueMapper: (data, _) => data.date,
                    yValueMapper: (data, _) => data.data,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                    ),
                    markerSettings: MarkerSettings(
                      isVisible: true,
                      shape: DataMarkerType.circle,
                      height: 5,
                      width: 5,
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
                primaryYAxis: NumericAxis(
                  minimum: 50,
                ),
                primaryXAxis: DateTimeAxis(
                  intervalType: DateTimeIntervalType.days,
                  visibleMaximum: (controller.currentSortedList ?? [])
                          .map(
                            (bpData) => BloodPressureChart(
                              date: bpData.recordDate,
                              data: (bpData.diastolic ?? 0).toDouble(),
                            ),
                          )
                          .toList()
                          .lastOrNull
                          ?.date ??
                      DateTime.now(),
                  visibleMinimum: (
                    (controller.currentSortedList ?? [])
                          .map(
                            (bpData) => BloodPressureChart(
                              date: bpData.recordDate,
                              data: (bpData.diastolic ?? 0).toDouble(),
                            ),
                          )
                          .toList()
                          .lastOrNull
                          ?.date ??
                      DateTime.now()
                  ).subtract(15.days),
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                  enablePinching: true
                ),
                series: <ChartSeries>[
                  // Renders line chart

                  LineSeries<BloodPressureChart, DateTime>(
                    dataSource: (controller.currentSortedList ?? [])
                        .map(
                          (bpData) => BloodPressureChart(
                            date: bpData.recordDate,
                            data: (bpData.pulserate ?? 0).toDouble(),
                          ),
                        )
                        .toList(),
                    xAxisName: "Time",
                    xValueMapper: (data, _) => data.date,
                    yValueMapper: (data, _) => data.data,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                    ),
                    markerSettings: MarkerSettings(
                      isVisible: true,
                      shape: DataMarkerType.circle,
                      height: 5,
                      width: 5,
                      borderColor: pageColor,
                      borderWidth: 2.5,
                    ),
                    color: pageColor,
                  ),
                ],
              ),
            ),
            const Text("Pulse Rate"),
            SizedBox(height: 8.h),
          ],
        );
      }),
    );
  }
}
