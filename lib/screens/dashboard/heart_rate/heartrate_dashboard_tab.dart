import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/heart_rate_controller/heart_rate_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/fetch_heart_rate_model.dart';
import 'package:wehealth/screens/dashboard/heart_rate/add_manual_heartrate.dart';
import 'package:wehealth/screens/dashboard/heart_rate/heartrate_trends_tab.dart';

import '../widgets/end_curved_index_selector.dart';
import '../widgets/indicator_data.dart';
import '../widgets/meter_heartrate_gauge.dart';

class HeartRateDashboardTab extends StatefulWidget {
  const HeartRateDashboardTab({
    Key? key,
  }) : super(key: key);

  @override
  State<HeartRateDashboardTab> createState() => _HeartRateDashboardTabState();
}

class _HeartRateDashboardTabState extends State<HeartRateDashboardTab> {
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
        return 0;
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
      child: GetBuilder<HeartRateController>(builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              HorizontalAddCameraIconedDataTile(
                data:
                    "${controller.typeCacheMap[1]?.lastOrNull?.heartRateQty ?? 0}",
                pageColor: Colors.orange.shade700,
                addButtonClick: () {
                  Get.to(() => const ManualHeartRateWidget());
                },
                cameraButtonClick: () {},
              ),
              const SizedBox(height: 32),
              /* SizedBox(
                height: 40.h,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: (selectedIndex == 1)
                                ? Colors.white
                                : Colors.amberAccent,
                            border:
                                Border.all(color: Colors.orange, width: 1.5),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                            ),
                          ),
                          child: Center(
                              child: Text(
                            "Today",
                            style: TextStyles.extraSmallTextStyle(),
                          )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 7;
                          });
                        },
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: (selectedIndex == 7)
                                ? Colors.white
                                : Colors.amberAccent,
                            border: Border.all(
                              color: Colors.orange.shade700,
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                              child: Text(
                            "7",
                            style: TextStyles.extraSmallTextStyle(),
                          )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 14;
                          });
                        },
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: (selectedIndex == 14)
                                ? Colors.white
                                : Colors.amberAccent,
                            border: Border.all(
                                color: Colors.orange.shade700, width: 1.5),
                          ),
                          child: Center(
                              child: Text(
                            "14",
                            style: TextStyles.extraSmallTextStyle(),
                          )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 30;
                          });
                        },
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: (selectedIndex == 30)
                                ? Colors.white
                                : Colors.amberAccent,
                            border: Border.all(
                                color: Colors.orange.shade700, width: 1.5),
                          ),
                          child: Center(
                              child: Text(
                            "30",
                            style: TextStyles.extraSmallTextStyle(),
                          )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 60;
                          });
                        },
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: (selectedIndex == 60)
                                ? Colors.white
                                : Colors.amberAccent,
                            border: Border.all(
                                color: Colors.orange.shade700, width: 1.5),
                          ),
                          child: Center(
                              child: Text(
                            "60",
                            style: TextStyles.extraSmallTextStyle(),
                          )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 90;
                          });
                        },
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: (selectedIndex == 90)
                                ? Colors.white
                                : Colors.amberAccent,
                            border: Border.all(
                                color: Colors.orange.shade700, width: 1.5),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: Center(
                              child: Text(
                            "90",
                            style: TextStyles.extraSmallTextStyle(),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ) */
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
              HeartRateDataTable(
                index: indexToDay,
                dataList: controller.dayTableDataCache[indexToDay] ?? [],
                currentSection: indexToString,
              ),

              const SizedBox(height: 32),
              SizedBox(
                height: 180,
                child: MeteredGaugeHeartRate(
                  needleValue: double.parse("50"),
                ),
              ),
              // SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IndicatorData(
                      color: Colors.orange.shade700,
                      tag: "Low",
                      textColor: Colors.black,
                    ),
                    const IndicatorData(
                      color: Colors.greenAccent,
                      tag: "Ideal",
                      textColor: Colors.black,
                    ),
                    const IndicatorData(
                      color: Colors.red,
                      tag: "High",
                      textColor: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class HeartRateDataTable extends StatefulWidget {
  const HeartRateDataTable({
    Key? key,
    required this.index,
    required this.dataList,
    required this.currentSection,
  }) : super(key: key);

  final int index;
  final String currentSection;
  final List<HeartRateFetchModel> dataList;

  @override
  State<HeartRateDataTable> createState() => _HeartRateDataTableState();
}

class _HeartRateDataTableState extends State<HeartRateDataTable> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      Get.find<HeartRateController>().getBpDataByDay(widget.index, true);
    });
  }

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

  List<HeartRateFetchModel> get sortedByActive {
    final data =
        widget.dataList.where((element) => element.heartRateType == 1).toList();
    data.sort(
      (a, b) => a.heartRateQty!.compareTo(b.heartRateQty!),
    );
    return data;
  }

  List<HeartRateFetchModel> get sortedByResting {
    final data =
        widget.dataList.where((element) => element.heartRateType == 0).toList();
    data.sort(
      (a, b) => a.heartRateQty!.compareTo(b.heartRateQty!),
    );
    return data;
  }

  double getListToAverage(List<HeartRateFetchModel> onList) =>
      (onList.fold<int>(
            0,
            (previousValue, element) =>
                (previousValue + (element.heartRateQty ?? 0)),
          ) /
          onList.length);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: Colors.amber.shade700,
      ),
      children: [
        buildRow([widget.currentSection, "Lowest", "Highest", "Average"], true),
        buildRow([
          "Active Heart Rate",
          "${sortedByActive.firstOrNull?.heartRateQty ?? 0}",
          "${sortedByActive.lastOrNull?.heartRateQty ?? 0}",
          "${getListToAverage(sortedByActive).isNaN ? 0 : getListToAverage(sortedByActive).toPrecision(2)}",
        ], false),
        buildRow([
          "Resting Heart Rate",
          "${sortedByResting.firstOrNull?.heartRateQty ?? 0}",
          "${sortedByResting.lastOrNull?.heartRateQty ?? 0}",
          "${getListToAverage(sortedByResting).isNaN ? 0 : getListToAverage(sortedByResting).toPrecision(2)}",
        ], false),
      ],
    );
  }
}
