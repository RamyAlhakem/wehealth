import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:wehealth/controller/blood_pressure_controller/blood_pressure_controller.dart';
import 'package:wehealth/controller/user_devices_controller/user_devices_controller.dart';
import 'package:wehealth/global/constants/functions_extensions.dart';
import 'package:wehealth/models/data_model/user_bp_model.dart';
import 'package:wehealth/screens/dashboard/blood_pressure/manual_blood_pressure.dart';
import 'package:wehealth/screens/dashboard/widgets/end_curved_index_selector.dart';

import '../../../global/styles/text_styles.dart';

class BloodPressureDashboard extends StatefulWidget {
  const BloodPressureDashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<BloodPressureDashboard> createState() => BloodPressureDashboardState();
}

class RangeData {
  final String systole;
  final String diastole;
  final Color areaColor;

  RangeData({
    required this.systole,
    required this.diastole,
    required this.areaColor,
  });
}

class BloodPressureDashboardState extends State<BloodPressureDashboard> {
  int selectedIndex = 0;
  final itemList = ["Today", "7", "14", "30", "60", "90"];

  int get indexToDay {
    switch (selectedIndex) {
      case 0:
        return 1;
      case 1:
        return 7;
      case 2:
        return 14;
      case 3:
        return 30;
      case 4:
        return 60;
      case 5:
        return 90;
      default:
        return 1;
    }
  }

  String get indexToString {
    switch (selectedIndex) {
      case 0:
        return "Today";
      case 1:
        return "Seven Days";
      case 2:
        return "Fourteen Days";
      case 3:
        return "Thirty Days";
      case 4:
        return "Sixty Days";
      case 5:
        return "Ninety Days";
      default:
        return "";
    }
  }

  @override
  void initState() {
    Get.find<BloodPressureController>().fetchUserBloodPressureHistory();
    super.initState();
  }

  final rangeData = [
    RangeData(
      systole: "0",
      diastole: "0",
      areaColor: Colors.greenAccent,
    ),
    RangeData(
      systole: "90",
      diastole: "60",
      areaColor: Colors.greenAccent,
    ),
    RangeData(
      systole: "120",
      diastole: "80",
      areaColor: Colors.green,
    ),
    RangeData(
      systole: "140",
      diastole: "90",
      areaColor: Colors.orange,
    ),
    /* RangeData(
      systole: 140,
      diastole: 90,
      areaColor: Colors.orange,
    ), */
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BloodPressureController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
        child: Column(
          children: [
            SizedBox(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${controller.currentSortedList.lastOrNull?.systolic ?? 0}/${controller.currentSortedList.lastOrNull?.diastolic ?? 0}",
                        style: TextStyles.largeTextStyle().copyWith(
                            color: Colors.orange.shade700,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "mmHg",
                        style: TextStyles.extraSmallText12BStyle()
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
            const SizedBox(height: 32),
            HorizontalEndCurvedIndexSelector(
              selectedIndex: selectedIndex,
              itemsList: itemList,
              onChange: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
            const SizedBox(height: 24),
            BodyTempDataTable(
              selectedSection: indexToString,
              dataList: controller.getBpDataByDay(indexToDay),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "Average Blood Pressure",
                    style: TextStyles.extraSmallTextStyle()
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: SfCartesianChart(
                      /* primaryXAxis: CategoryAxis(
                        isVisible: true,
                        // minimum: "0",
                        // maximum: 150,
                      ),
                      primaryYAxis: NumericAxis(
                        minimum: 0,
                        maximum: 200,
                      ),
                      annotations: const [
                        CartesianChartAnnotation(
                          coordinateUnit: CoordinateUnit.point,
                          widget: ColoredBox(
                            color: Colors.green,
                            child: Text(
                              "",
                              style: TextStyle(
                                color: Colors.amber,
                              ),
                            ),
                          ),
                          x: 60,
                          y: 90,
                          region: AnnotationRegion.chart,
                          xAxisName: "60 - 80",
                          yAxisName: "90 - 120",
                          horizontalAlignment: ChartAlignment.center,
                        ),
                        CartesianChartAnnotation(
                          widget: ColoredBox(
                            color: Colors.greenAccent,
                          ),
                          x: 0,
                          y: 0,
                          region: AnnotationRegion.chart,
                          xAxisName: "Below 60",
                          yAxisName: "Below 90",
                        ),
                      ], */
                      series: <LineSeries>[
                        /* StackedAreaSeries<RangeData, String>(
                          groupName: 'Group A',
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            showCumulativeValues: true,
                            useSeriesColor: true,
                          ),
                          dataSource: rangeData,
                          xValueMapper: (data, _) => data.diastole,
                          xAxisName: "Diastolic(mmHG)",
                          isVisible: true,
                          yAxisName: "Dia",
                        
                          isVisibleInLegend: true,
                          yValueMapper: (data, _) => /* int.tryParse(data.systole) */,
                        ), */

                        /* RangeAreaSeries<RangeData, String>(
                          dataSource: rangeData,
                          color: Colors.green,
                          xValueMapper: (d, t) => d.diastole,
                          highValueMapper: (d, t) => int.parse(d.diastole),
                          lowValueMapper: (d, t) => int.parse(d.systole),
                        ) */

                        /* StackedAreaSeries<RangeData, double>(
                          groupName: 'Group A',
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            showCumulativeValues: true,
                            useSeriesColor: true,
                          ),
                          dataSource: rangeData,
                          xValueMapper: (data, _) => data.diastole,
                          yValueMapper: (data, _) => data.systole,
                        ),
                        StackedAreaSeries<RangeData, double>(
                          groupName: 'Group A',
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            showCumulativeValues: true,
                            useSeriesColor: true,
                          ),
                          dataSource: rangeData,
                          xValueMapper: (data, _) => data.diastole,
                          yValueMapper: (data, _) => data.systole,
                        ), */
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

class BodyTempDataTable extends StatelessWidget {
  const BodyTempDataTable({
    Key? key,
    required this.dataList,
    required this.selectedSection,
  }) : super(key: key);

  final String selectedSection;
  final List<BPData> dataList;

  buildRow(List<String> cells, bool isHeader) {
    String header = "";
    List<Widget> data = [];
    if (!isHeader) {
      header = cells[0];
      data = cells
          .sublist(1)
          .map(
            (e) => Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  e,
                  textAlign: TextAlign.center,
                  style: TextStyles.extraSmallTextStyle().copyWith(
                      color: Colors.green.shade400,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
          .toList();
    }
    return TableRow(
      children: (isHeader)
          ? cells
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      e,
                      textAlign: TextAlign.center,
                      style: TextStyles.extraSmallBoldTextStyle(),
                    ),
                  ),
                ),
              )
              .toList()
          : [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    header,
                    style: TextStyles.extraSmallBoldTextStyle(),
                  ),
                ),
              ),
              ...data
            ],
    );
  }

  List<BPData> get sortBySystolic {
    dataList.sort(
      (a, b) => a.systolic!.compareTo(b.systolic!),
    );
    return dataList;
  }

  List<BPData> get sortByDiastole {
    dataList.sort(
      (a, b) => a.diastolic!.compareTo(b.diastolic!),
    );
    return dataList;
  }

  List<BPData> get sortByPulse {
    dataList.sort(
      (a, b) => a.pulserate!.compareTo(b.pulserate!),
    );
    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.orange.shade700, width: 1.2.w),
      children: [
        buildRow([selectedSection, "Lowest", "Highest", "Average"], true),
        buildRow([
          "Systolic (mmHg)",
          "${sortBySystolic.firstOrNull?.systolic ?? 0}",
          "${sortBySystolic.lastOrNull?.systolic ?? 0}",
          "${nanConverter(dataList.fold<int>(0, (previousValue, element) => (previousValue + (element.systolic ?? 0))) / dataList.length)}",
        ], false),
        buildRow([
          "Diastolic (mmHg)",
          "${sortByDiastole.firstOrNull?.diastolic ?? 0}",
          "${sortByDiastole.lastOrNull?.diastolic ?? 0}",
          "${nanConverter(dataList.fold<int>(0, (previousValue, element) => (previousValue + (element.diastolic ?? 0))) / dataList.length)}",
        ], false),
        buildRow([
          "Pulse Rate",
          "${sortByPulse.firstOrNull?.pulserate ?? 0}",
          "${sortByPulse.lastOrNull?.pulserate ?? 0}",
          "${nanConverter(dataList.fold<int>(0, (previousValue, element) => (previousValue + (element.pulserate ?? 0))) / dataList.length)}",
        ], false),
      ],
    );
  }
}
