import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wehealth/controller/body_temp_controller/body_temp_controller.dart';
import 'package:wehealth/global/constants/functions_extensions.dart';
import 'package:wehealth/models/data_model/body_temp_fetch_wrapper.dart';
import 'package:wehealth/screens/dashboard/body_temperature/manual_body_temp_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/end_curved_index_selector.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';

import '../../../global/styles/text_styles.dart';
import '../widgets/custom_gauge.dart';
import '../widgets/indicator_data.dart';

class BodyTempDashboard extends StatefulWidget {
  const BodyTempDashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyTempDashboard> createState() => BodyTempDashboardState();
}

class BodyTempDashboardState extends State<BodyTempDashboard> {
  final baseColor = Colors.amber.shade700;
  int selectedIndex = 0;
  final optionList = ["Today", "7", "14", "30", "60", "90"];
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
  Widget build(BuildContext context) {
    return GetBuilder<BodyTemperatureController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
        child: Column(
          children: [
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
            HorizontalEndCurvedIndexSelector(
              selectedIndex: selectedIndex,
              itemsList: optionList,
              onChange: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
            const SizedBox(height: 24),
            BodyTempDataTable(
              selectedSection: indexToString,
              dataList: controller.tempDataByDay(indexToDay),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: CustomGauge(
                      needleValue: double.parse("32"),
                      title: "BMI",
                      start: 0,
                      end: 50,
                      textColor: Colors.white,
                      gaugeRanges: [
                        GaugeRange(
                          startValue: 0,
                          endValue: 35,
                          color: Colors.pink.shade200,
                        ),
                        GaugeRange(
                          startValue: 35,
                          endValue: 38,
                          color: Colors.green,
                        ),
                        GaugeRange(
                          startValue: 38,
                          endValue: 50,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IndicatorData(
                          color: Colors.orange.shade700,
                          tag: "Hypothermia",
                          textColor: Colors.black,
                        ),
                        const IndicatorData(
                          color: Colors.greenAccent,
                          tag: "Normal",
                          textColor: Colors.black,
                        ),
                        const IndicatorData(
                          color: Colors.red,
                          tag: "Fever",
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
  final List<BodyTempData> dataList;

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
                  style: TextStyles.extraSmallTextStyle()
                      .copyWith(color: Colors.green.shade200),
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
                    textAlign: TextAlign.center,
                    style: TextStyles.extraSmallBoldTextStyle(),
                  ),
                ),
              ),
              ...data
            ],
    );
  }

  List<BodyTempData> get sortedList {
    dataList.sort(
      (a, b) => a.pursedTempC.compareTo(b.pursedTempC),
    );
    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: Colors.amber.shade700,
      ),
      children: [
        buildRow([selectedSection, "Lowest", "Highest", "Average"], true),
        buildRow([
          "Body Temperature (C)",
          "${nanConverter(sortedList.firstOrNull?.pursedTempC ?? 0)}",
          "${nanConverter(sortedList.lastOrNull?.pursedTempC ?? 0)}",
          "${nanConverter((dataList.fold<double>(0, (previousValue, element) => previousValue + element.pursedTempC)) / dataList.length)}"
        ], false),
      ],
    );
  }
}
