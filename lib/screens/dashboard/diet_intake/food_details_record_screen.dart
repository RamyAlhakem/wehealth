import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/diet_intake/add_food_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/custom_gauge.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

class FoodDetailsRecordScreen extends StatefulWidget {
  const FoodDetailsRecordScreen({Key? key}) : super(key: key);

  @override
  State<FoodDetailsRecordScreen> createState() =>
      _FoodDetailsRecordScreenState();
}

class _FoodDetailsRecordScreenState extends State<FoodDetailsRecordScreen> {
  final pageColor = Colors.green.shade700;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      title: "Food",
      appBarColor: pageColor,
      tabCount: 3,
      tabTitles: const [
        "SUMMARY",
        "FOOD DIARY",
        "HISTORY",
      ],
      tabs: [
        FoodDetailSummaryTab(),
        DietFoodDiaryTab(),
        DietFoodHistoryTab(),
      ],
    );
  }
}

class DietFoodHistoryTab extends StatelessWidget {
  DietFoodHistoryTab({
    Key? key,
  }) : super(key: key);

  final chartColor = Colors.amber.shade700;
  final List<ChartData> chartData = [
    ChartData("2010", 35),
    ChartData("2011", 28),
    ChartData("2012", 34),
    ChartData("2013", 32),
    ChartData("2014", 60),
  ];

  final pageColor = Colors.green.shade700;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HorizontalIconedDataOnlyTile(
          color: pageColor,
          iconPath: "assets/icons/mnu_food.webp",
          data: "0",
          unit: "kacl",
        ),
        SizedBox(
          height: 200,
          width: double.infinity,
          child: SfCartesianChart(series: <ChartSeries>[
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
          ]),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: pageColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: Text("7 DAYS"),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: pageColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: Text("CUSTOM"),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          "No Calorie History Data",
          style: TextStyles.smallTextStyle().copyWith(
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}

class DietFoodDiaryTab extends StatelessWidget {
  DietFoodDiaryTab({
    Key? key,
  }) : super(key: key);
  final pageColor = Colors.green.shade700;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HorizontalIconedDataOnlyTile(
          color: pageColor,
          iconPath: "assets/icons/mnu_food.webp",
          data: "0",
          unit: "kacl",
        ),
        const Divider(color: Colors.black, thickness: 1, height: 0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Text(
            "Breakfast: 0 kcal",
            style: TextStyles.normalTextStyle().copyWith(color: Colors.grey),
          ),
        ),
        const Divider(color: Colors.black, thickness: 1, height: 0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Text(
            "Lunch: 0 kcal",
            style: TextStyles.normalTextStyle().copyWith(color: Colors.grey),
          ),
        ),
        const Divider(color: Colors.black, thickness: 1, height: 0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Text(
            "Dinner: 0 kcal",
            style: TextStyles.normalTextStyle().copyWith(color: Colors.grey),
          ),
        ),
        const Divider(color: Colors.black, thickness: 1, height: 0),
      ],
    );
  }
}

class FoodDetailSummaryTab extends StatelessWidget {
  FoodDetailSummaryTab({
    Key? key,
  }) : super(key: key);
  final pageColor = Colors.green.shade700;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 150.h,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/icons/mnu_food.webp",
                                  color: pageColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "0 kcal",
                                    style: TextStyles.extraSmallTextStyle(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                            children: [
                              Expanded(
                                child: CustomGauge(
                                  title: "Food\nIntake",
                                  textColor: Colors.green.shade700,
                                  needleValue: 0,
                                  start: 0,
                                  end: 200,
                                  gaugeRanges: [
                                    GaugeRange(
                                      startValue: 0,
                                      endValue: 50,
                                      color: Colors.green.shade100,
                                    ),
                                    GaugeRange(
                                      startValue: 50,
                                      endValue: 100,
                                      color: Colors.green,
                                    ),
                                    GaugeRange(
                                      startValue: 100,
                                      endValue: 200,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "Achieve atleast 60%",
                                  style: TextStyles.extraSmallTextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/icons/goalicon.webp",
                                  color: pageColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "0 kcal",
                                    style: TextStyles.extraSmallTextStyle(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  DietDataIndicatorWidget(
                    baseColor: pageColor,
                    name: "Carbohydrate",
                    data: "0",
                  ),
                  DietDataIndicatorWidget(
                    baseColor: pageColor,
                    name: "Protein",
                    data: "0",
                  ),
                  DietDataIndicatorWidget(
                    baseColor: pageColor,
                    name: "Fat",
                    data: "0",
                  ),
                  const SizedBox(height: 10),
                  Card(
                    color: pageColor,
                    shape: const StadiumBorder(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 24),
                      child: Text(
                        "OTHER NUTRIENTS SUMMARY",
                        style: TextStyles.smallTextStyle().copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const DietFoodRecordDataTable(),
                ],
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50.h,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.green.shade400,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      )),
                  onPressed: () async {
                    Get.to(()=>const AddFoodScreen());
                  },
                  child: Text(
                    "ADD FOOD",
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
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      )),
                  onPressed: () async {},
                  child: Text(
                    "FB SHARE",
                    style: TextStyles.smallTextBoldStyle()
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DietDataIndicatorWidget extends StatelessWidget {
  const DietDataIndicatorWidget({
    Key? key,
    required this.baseColor,
    required this.name,
    required this.data,
  }) : super(key: key);

  final Color baseColor;
  final String name;
  final String data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              name,
              style: TextStyles.smallTextStyle(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Taken \n ${data}g",
                      textAlign: TextAlign.center,
                      style: TextStyles.extraSmallTextStyle(),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox.expand(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                border: Border.all(
                                  color: baseColor,
                                  width: 1.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: baseColor,
                                      width: 2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: FittedBox(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text("20%"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "Too Low",
                            style: TextStyles.extraSmallTextStyle(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox.expand(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                border: Border.all(
                                  color: baseColor,
                                  width: 1.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: baseColor,
                                      width: 2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: FittedBox(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text("20%"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "Ok",
                            style: TextStyles.extraSmallTextStyle(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox.expand(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                border: Border.all(
                                  color: baseColor,
                                  width: 1.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: baseColor,
                                      width: 2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: FittedBox(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text("20%"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "Too High",
                            style: TextStyles.extraSmallTextStyle(),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DietFoodRecordDataTable extends StatelessWidget {
  const DietFoodRecordDataTable({
    Key? key,
  }) : super(key: key);

  buildRow(List<String> cells, bool isHeader, [bool isEven = false]) {
    List<Widget> data = [];
    if (!isHeader) {
      data = cells
          .map(
            (e) => SizedBox.square(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    e,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          )
          .toList();
    }
    return TableRow(
      decoration: BoxDecoration(
        color: isHeader
            ? null
            : isEven
                ? Colors.green.shade200
                : Colors.green.shade50,
      ),
      children: (isHeader)
          ? cells
              .asMap()
              .entries
              .map(
                (e) => SizedBox.square(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    color: e.key == 0
                        ? Colors.orange.shade400
                        : e.key + 1 == cells.length
                            ? Colors.grey.shade800
                            : Colors.green,
                    child: Text(
                      e.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
              .toList()
          : [...data],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: Colors.white,
        width: 1.5,
      ),
      children: [
        buildRow(
            ["Nutrient", "Your Intake", "Your % Intake", "Intake Goal"], true),
        buildRow(["Sodium (mg)", "N/A", "N/A", "500-2300"], false),
        buildRow(["Fibre (g)", "N/A", "N/A", "500-2300"], false, true),
        buildRow(["Calcium (mg)", "N/A", "N/A", "500-2300"], false),
        buildRow(["Vitamin C (mg)", "N/A", "N/A", "500-2300"], false, true),
        buildRow(["Iron (mg)", "N/A", "N/A", "500-2300"], false),
      ],
    );
  }
}
