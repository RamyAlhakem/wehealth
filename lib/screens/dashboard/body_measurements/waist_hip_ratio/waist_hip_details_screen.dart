import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehealth/controller/body_measurement_controller/body_measurement_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/body_measurements/waist_hip_ratio/manual_waist_circumference.dart';
import 'package:wehealth/screens/dashboard/widgets/colored_data_range_indicator.dart';
import 'package:wehealth/screens/dashboard/widgets/end_curved_index_selector.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

class WaistHipRatioDetailsScreen extends StatefulWidget {
  const WaistHipRatioDetailsScreen({Key? key}) : super(key: key);

  @override
  State<WaistHipRatioDetailsScreen> createState() =>
      WaistHipRatioDetailsScreenState();
}

class WaistHipRatioDetailsScreenState extends State<WaistHipRatioDetailsScreen> {

  @override
  void initState() {
    super.initState();
    final bodyMesure = Get.put(BodyMeasurementController());
    bodyMesure.fetchUserWaistHipRatioData();
  }
  final pageColor = Colors.amber.shade600;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BodyMeasurementController>(
      builder: (bodyMeasureController) {
        return ScaffoldWithDefaultTab(
          appBarColor: pageColor,
          tabCount: 3,
          title: "Waist-Hip Ratio",
          tabTitles: const [
            "Dashboard",
            "Trends",
            "Timelines",
          ],
          tabs: [
            const WaistHipRatioDashboardTab(),
            WaistHipRatioTrendsTab(),
            Center(child: Column(children: [
             HorizontalIconedDataTileAdd(
                    iconPath: "assets/icons/waistcircumference.webp",
                    data: bodyMeasureController.userWaistHipRatioData!.isEmpty ? "-" : bodyMeasureController.userWaistHipRatioData != null? bodyMeasureController.userWaistHipRatioData![0].waisttohipratio! : "-",
                    // data: bodyMeasureController.userWaistHipRatioData?[0].waisttohipratio ?? "-",
                    unit: "",
                    baseColor: pageColor,
                    onAddClick: () {
                      Get.to(() => const ManualWaistCircumferenceWidget());
                    },
                  ),
            ],)
            
            ,),
          ],
        );
      }
    );
  }
}

class WaistHipRatioDashboardTab extends StatefulWidget {
  const WaistHipRatioDashboardTab({
    Key? key,
  }) : super(key: key);

  @override
  State<WaistHipRatioDashboardTab> createState() =>
      WaistHipRatioDashboardTabState();

      
}

class WaistHipRatioDashboardTabState extends State<WaistHipRatioDashboardTab> {


  int selectedIndex = 0;
  final pageColor = Colors.amberAccent;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BodyMeasurementController>(
      builder: (bodyMeasureController) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
          child: Column(
            children: [
              HorizontalIconedDataTileAdd(
                iconPath: "assets/icons/waistcircumference.webp",
                data: bodyMeasureController.userWaistHipRatioData!.isEmpty ? "-" : bodyMeasureController.userWaistHipRatioData != null? bodyMeasureController.userWaistHipRatioData![0].waisttohipratio! : "-",
                // data: bodyMeasureController.userWaistHipRatioData?[0].waisttohipratio ?? "-",
                unit: "",
                baseColor: pageColor,
                onAddClick: () {
                  Get.to(() => const ManualWaistCircumferenceWidget());
                },
              ),
              // const SizedBox(height: 18),
              HorizontalEndCurvedIndexSelector(
                selectedIndex: selectedIndex,
                itemsList: const ["Today", "7", "14", "30", "60", "90"],
                onChange: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              const WaistHipRatioDataTable(),
              const SizedBox(height: 32),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ColoredDataRangeIndicator(
                    title: "Waist-Hip Ratio",
                    items: [
                      ColoredDataRangeWidget(
                        color: Colors.green.shade900,
                        inRange: false,
                        rangeDescription: "Below 0.85",
                        rangeName: "Healthy",
                      ),
                      ColoredDataRangeWidget(
                        color: Colors.red.shade900,
                        inRange: true,
                        rangeDescription: "Above 0.85",
                        rangeName: "Bad",
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}

class WaistHipRatioDataTable extends StatelessWidget {
  const WaistHipRatioDataTable({
    Key? key
  }) : super(key: key);

  // final List<String>

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

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: Colors.amber.shade700,
      ),
      children: [
        buildRow(["Today", "Lowest", "Highest", "Average"], true),
        buildRow(["Waist Cirumference", "0", "0", "0"], false),
        buildRow(["Hip Cirumference", "0", "0", "0"], false),
        buildRow(["Waist to Hip Ratio", "0", "0", "0"], false),
      ],
    );
  }
}

class WaistHipRatioTrendsTab extends StatelessWidget {
  WaistHipRatioTrendsTab({
    Key? key,
  }) : super(key: key);
  final Color pageColor = Colors.amber.shade600;

  final List<ChartData> chartData = <ChartData>[
    ChartData('5', 541),
    ChartData('8', 818),
    ChartData('6', 151),
    ChartData('11', 1302),
    ChartData('9', 2017),
    ChartData('13', 1683),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BodyMeasurementController>(
      builder: (bodyMeasureController) {
        return Column(
          children: [
            HorizontalIconedDataTileAdd(
              baseColor: pageColor,
              iconPath: "assets/icons/waistcircumference.webp",
              data: bodyMeasureController.userWaistHipRatioData!.isEmpty ? "-" : bodyMeasureController.userWaistHipRatioData != null? bodyMeasureController.userWaistHipRatioData![0].waisttohipratio! : "-",
              unit: "",
            ),
            Expanded(
              child: SfCartesianChart(
                series: [
                  ColumnSeries<ChartData, int>(
                    dataSource: chartData,
                    xValueMapper: (ChartData sales, _) => int.parse(sales.x),
                    yValueMapper: (ChartData sales, _) => sales.y,
                    color: pageColor,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SfCartesianChart(
                series: [
                  ColumnSeries<ChartData, int>(
                    dataSource: chartData,
                    xValueMapper: (ChartData sales, _) => int.parse(sales.x),
                    yValueMapper: (ChartData sales, _) => sales.y,
                    color: pageColor,
                  ),
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}
