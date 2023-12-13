import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehealth/controller/google_fit_controller/google_fit_controller.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

import '../../../global/constants/color_resources.dart';

class StepsRecordScreen extends StatefulWidget {
  const StepsRecordScreen({Key? key}) : super(key: key);

  @override
  State<StepsRecordScreen> createState() => _StepsRecordScreenState();
}

class _StepsRecordScreenState extends State<StepsRecordScreen> {
  final Color _pageColor = ColorResources.physicalActivityScreenColor;
  @override
  void initState() {
    super.initState();
    // Get.find<GoogleFitController>().getGoogleFitDailyData();
    // Get.find<GoogleFitController>().fetchMonthlyData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoogleFitController>(builder: (controller) {
      return ScaffoldWithDefaultTab(
        title: "Steps Walked",
        appBarColor: _pageColor,
        tabCount: 3,
        tabTitles: const ["DAY", "WEEK", "MONTH"],
        tabs: [
          StepsDayTab(controller: controller),
          StepsWeekTab(controller: controller),
          StepsMonthTab(controller: controller),
        ],
      );
    });
  }
}

class StepsDayTab extends StatelessWidget {
  StepsDayTab({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final Color color = ColorResources.physicalActivityScreenColor;

  final GoogleFitController controller;

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
    return Column(
      children: [
        HorizontalIconedDataTileFacebook(
          color: color,
          iconPath: "assets/images/sport_walking.webp",
          data: /* controller.dailySteps.toStringAsFixed(0) */ "0",
          unit: "Steps",
        ),
        Expanded(
          child: SfCartesianChart(
            series: [
              ColumnSeries<ChartData, int>(
                dataSource: chartData,
                xValueMapper: (ChartData sales, _) => int.parse(sales.x),
                yValueMapper: (ChartData sales, _) => sales.y,
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StepsWeekTab extends StatelessWidget {
  StepsWeekTab({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final Color color = Colors.blue.shade400;
  final GoogleFitController controller;

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
    return Column(
      children: [
        HorizontalIconedDataTileFacebook(
          color: color,
          iconPath: "assets/images/sport_walking.webp",
          data: /* controller.dailySteps.toStringAsFixed(0) */ "0",
          unit: "Steps",
        ),
        Expanded(
          child: SfCartesianChart(
            series: [
              ColumnSeries<ChartData, int>(
                dataSource: chartData,
                xValueMapper: (ChartData sales, _) => int.parse(sales.x),
                yValueMapper: (ChartData sales, _) => sales.y,
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StepsMonthTab extends StatelessWidget {
  StepsMonthTab({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final Color color = Colors.blue.shade400;
  final GoogleFitController controller;

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
    return Column(
      children: [
        HorizontalIconedDataTileFacebook(
          color: color,
          iconPath: "assets/images/sport_walking.webp",
          data: /* controller.dailySteps.toStringAsFixed(0) */ "0",
          unit: "Steps",
        ),
        Expanded(
          child: SfCartesianChart(
            series: [
              ColumnSeries<ChartData, int>(
                dataSource: chartData,
                xValueMapper: (ChartData sales, _) => int.parse(sales.x),
                yValueMapper: (ChartData sales, _) => sales.y,
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
