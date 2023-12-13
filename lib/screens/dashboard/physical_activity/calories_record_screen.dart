import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

import '../../../global/constants/color_resources.dart';

class CaloriesRecordScreen extends StatefulWidget {
  const CaloriesRecordScreen({Key? key}) : super(key: key);

  @override
  State<CaloriesRecordScreen> createState() => _CaloriesRecordScreenState();
}

class _CaloriesRecordScreenState extends State<CaloriesRecordScreen> {
  final Color _pageColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      title: "Calories Burned",
      appBarColor: _pageColor,
      tabCount: 3,
      tabTitles: const ["DAY", "WEEK", "MONTH"],
      tabs: [
        CaloriesDayTab(),
        CaloriesWeekTab(),
        CaloriesMonthTab(),
      ],
    );
  }
}

class CaloriesDayTab extends StatelessWidget {
  CaloriesDayTab({
    Key? key,
  }) : super(key: key);
  final Color color = ColorResources.physicalActivityScreenColor;

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
          iconPath: "assets/icons/mnu_calorie.webp",
          data: "0",
          unit: "kCal",
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

class CaloriesWeekTab extends StatelessWidget {
  CaloriesWeekTab({
    Key? key,
  }) : super(key: key);
  final Color color = Colors.blue.shade400;

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
          iconPath: "assets/icons/mnu_calorie.webp",
          data: "0",
          unit: "kCal",
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

class CaloriesMonthTab extends StatelessWidget {
  CaloriesMonthTab({
    Key? key,
  }) : super(key: key);
  final Color color = Colors.blue.shade400;

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
          iconPath: "assets/icons/mnu_calorie.webp",
          data: "0",
          unit: "kCal",
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
