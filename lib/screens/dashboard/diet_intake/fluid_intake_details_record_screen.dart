import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:social_share/social_share.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehealth/controller/dietary_controller/dietary_controller.dart';
import 'package:wehealth/controller/dietary_controller/model/water_inatake_model.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/styles/button_style.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/body_measurement/body_weight_wrapper.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/diet_intake/add_food_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

import 'add_water_screen.dart';

class FluidIntakeDetailsRecordScreen extends StatefulWidget {
  const FluidIntakeDetailsRecordScreen({Key? key}) : super(key: key);

  @override
  State<FluidIntakeDetailsRecordScreen> createState() =>
      _FluidIntakeDetailsRecordScreenState();
}

class _FluidIntakeDetailsRecordScreenState
    extends State<FluidIntakeDetailsRecordScreen> {
  final pageColor = Colors.green.shade700;

  @override
  void initState() {
    super.initState();
    Get.find<DietaryController>().getWaterIntake();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      tabCount: 2,
      title: "Fluid Intake",
      appBarColor: pageColor,
      tabTitles: const [
        "DAILY",
        "HISTORY",
      ],
      tabs: [
        const FluidIntakeDailyTab(),
        FluidIntakeHistoryTab(),
      ],
    );
  }
}

class FluidIntakeHistoryTab extends StatelessWidget {
  FluidIntakeHistoryTab({
    Key? key,
  }) : super(key: key);
  final pageColor = Colors.green.shade700;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DietaryController>(builder: (dietaryController) {
      return GetBuilder<StorageController>(
        builder: (storageController) {
          /* final totalWaterConsumed =
                storageController.getWaterIntakeHistory.fold<double>(
              0,
              (previousValue, element) => previousValue + element.waterLevel,
            ); */
          return Column(
            children: [
              HorizontalIconedDataOnlyTile(
                color: pageColor,
                iconPath: "assets/icons/food_water.webp",
                data: dietaryController.todaysTotal.toStringAsFixed(1),
                unit: "ml",
                emptyValue: (1250 - dietaryController.todaysTotal).toDouble(),
              ),
              const SizedBox(height: 8),
              const Divider(thickness: 1, color: Colors.black87),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Date                              "),
                    Text("Intake Size     "),
                    Text("Intake Type")
                  ],
                ),
              ),
              const Divider(thickness: 1, color: Colors.black87),
              Expanded(
                child: dietaryController.waterIntakeDataList.isNotEmpty
                    ? ListView.builder(
                        itemCount: dietaryController.waterIntakeDataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(DateFormat("dd-MM-yyyy HH:mm").format(
                                    stringDateWithTZ.parse(dietaryController
                                        .waterIntakeDataList[index]
                                        .recorddatetime!))),
                                Text(
                                  "${dietaryController.waterIntakeDataList[index].drinksize?.toStringAsFixed(2)} ml",
                                ),
                                Text(
                                  "${dietaryController.waterIntakeDataList[index].drinkname}",
                                ),
                                const Text("Low")
                              ],
                            ),
                          );
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No item display",
                          style: TextStyles.smallTextStyle()
                              .copyWith(color: Colors.grey),
                        ),
                      ),
              ),
            ],
          );
        },
      );
    });
  }
}

class FluidIntakeDailyTab extends StatefulWidget {
  const FluidIntakeDailyTab({Key? key}) : super(key: key);

  @override
  State<FluidIntakeDailyTab> createState() => _FluidIntakeDailyTabState();
}

class _FluidIntakeDailyTabState extends State<FluidIntakeDailyTab> {
  final chartColor = Colors.amber.shade700;

  final List<ChartData> chartData = [
    ChartData("2010", 35),
    ChartData("2011", 28),
    ChartData("2012", 34),
    ChartData("2013", 32),
    ChartData("2014", 60),
  ];

  final pageColor = Colors.green.shade800;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DietaryController>(
      builder: (c) {
        return Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  HorizontalIconedDataOnlyTile(
                    color: pageColor,
                    iconPath: "assets/icons/food_water.webp",
                    data: c.todaysTotal.toStringAsFixed(1),
                    unit: "ml",
                    emptyValue: (1250 - c.todaysTotal).toDouble(),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: SfCartesianChart(
                      series: <ChartSeries>[
                        LineSeries<WaterIntakeData, int>(
                          dataSource: c.waterIntakeDataList,
                          xValueMapper: (WaterIntakeData data, _) =>
                              // //int.parse("$data.${DateFormat("dd-MM-yyyy").format(DateFormat("yyyy-MM-dd HH:mm").parse(storageController.waterAddingList[0].date.toString()))}"
                              data.time.year,
                          yValueMapper: (WaterIntakeData data, _) =>
                              data.drinksize,
                          markerSettings: MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            height: 10,
                            width: 10,
                            borderColor: pageColor,
                            borderWidth: 1.5,
                          ),
                          color: pageColor,
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: c.todaysWaterIntakeList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = c.todaysWaterIntakeList[index];
                        return Card(
                          elevation: 0,
                          shadowColor: Colors.white,
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/icons/food_water.webp",
                                height: 80.h,
                                color: Colors.green.shade800,
                              ),
                              Text(
                                "${data.drinksize} ml",
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50.h,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade800,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () async {
                        log("add water is calling");
                        Get.to(() => const AddWaterScreen());
                      },
                      child: Text(
                        "Add Water",
                        style: TextStyles.smallTextBoldStyle()
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 50.h,
                    child: TextButton(
                      style: ButtonStyles.getBlueStyle(context).copyWith(
                        shape: const MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (Platform.isAndroid) {
                          // SocialShare.shareFacebookStory(
                          //   image.path, "#ffffff","#000000",
                          //           "https://deep-link-url","facebook-app-id",
                          //   appId: "xxxxxxxxxxxxx");
                        }
                      },
                      child: Text(
                        "FB SHARE",
                        style: TextStyles.smallTextBoldStyle()
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
