import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/widgets/custom_gauge.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';
import '../../../../controller/body_measurement_controller/body_measurement_controller.dart';
import '../../../../models/body_measurement/body_weight_wrapper.dart';
import '../../widgets/end_curved_index_selector.dart';
import '../../widgets/indicator_data.dart';
import 'add_manual_body_weight.dart';

class BodyWeightDashboardTab extends StatefulWidget {
  const BodyWeightDashboardTab({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyWeightDashboardTab> createState() => _BodyWeightDashboardTabState();
}

class _BodyWeightDashboardTabState extends State<BodyWeightDashboardTab> {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
      child: GetBuilder<BodyMeasurementController>(builder: (bodyMeasureController) {
        return SingleChildScrollView(
          child: Column(
            children: [
              HorizontalIconedDataTileAdd(
                data: "${bodyMeasureController.getDateSortedBodyWeightData().lastOrNull?.qty ?? "-" " "}",
                unit: 'kg',
                iconPath: 'assets/icons/mnu_bweight_l.webp',
                onAddClick: (){
            
                  Get.to(()=>  ManualBodyWeightWidget());
            
                },
              ),
              // const SizedBox(height: 32),
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
              BodyWeightDataTable(
                dataList: bodyMeasureController.getBodyWeightDataByDay(selectedIndex),
                currentSection: indexToString,
              ),

              const SizedBox(height: 32),
              SizedBox(
                height: 180,
                child: CustomGauge(
                  textColor: Colors.white,
                  needleValue: 20,
                  start: 0,
                  end: 50,
                  gaugeRanges: [
                    GaugeRange(
                      color: Colors.pink.shade200,
                      startValue: 0,
                      endValue: 18,
                    ),
                    GaugeRange(
                      color: Colors.greenAccent,
                      startValue: 18,
                      endValue: 23,
                    ),
                    GaugeRange(
                      color: Colors.orange,
                      startValue: 23,
                      endValue: 27,
                    ),
                    GaugeRange(
                      color: Colors.red,
                      startValue: 27,
                      endValue: 50,
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IndicatorData(
                      color: Colors.pink.shade200,
                      tag: "Under",
                      textColor: Colors.black,
                    ),
                    const IndicatorData(
                      color: Colors.greenAccent,
                      tag: "Healthy",
                      textColor: Colors.black,
                    ),
                    const IndicatorData(
                      color: Colors.orange,
                      tag: "Over",
                      textColor: Colors.black,
                    ),
                    const IndicatorData(
                      color: Colors.red,
                      tag: "Obese",
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

class BodyWeightDataTable extends StatelessWidget {
  const BodyWeightDataTable({
    Key? key,
    required this.dataList,
    required this.currentSection,
  }) : super(key: key);

  final List<BodyWeightData> dataList;
  final String currentSection;

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

  /*  List<HeartRateFetchModel> get sortedByActive {
    final data =
        dataList.where((element) => element.heartRateType == 1).toList();
    data.sort(
      (a, b) => a.heartRateQty!.compareTo(b.heartRateQty!),
    );
    return data;
  }

  List<HeartRateFetchModel> get sortedByResting {
    final data =
        dataList.where((element) => element.heartRateType == 0).toList();
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
          onList.length); */

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: Colors.amber.shade700,
      ),
      children: [
        buildRow([currentSection, "Lowest", "Highest", "Average"], true),
        buildRow([
          "Body Weight (kg)",
          '_',
          '_',
          '_',
        ], false),
      ],
    );
  }
}
