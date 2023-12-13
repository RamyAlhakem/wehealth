import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehealth/global/constants/color_resources.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

class DistanceRecordScreen extends StatefulWidget {
  const DistanceRecordScreen({Key? key}) : super(key: key);

  @override
  State<DistanceRecordScreen> createState() => _DistanceRecordScreenState();
}

class _DistanceRecordScreenState extends State<DistanceRecordScreen> {
  final Color _pageColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      title: "Walking Distance",
      appBarColor: _pageColor,
      tabCount: 3,
      tabTitles: const ["DAY", "WEEK", "MONTH"],
      tabs: [
        DistanceDayTab(),
        DistanceWeekTab(),
        DistanceMonthTab(),
      ],
    );
  }
}

class DistanceDayTab extends StatelessWidget {
  DistanceDayTab({
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
          iconPath: "assets/icons/mnu_distance.webp",
          data: "0",
          unit: "meters",
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

class DistanceWeekTab extends StatelessWidget {
  DistanceWeekTab({
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
          iconPath: "assets/icons/mnu_distance.webp",
          data: "0",
          unit: "meters",
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

class DistanceMonthTab extends StatelessWidget {
  DistanceMonthTab({
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
          iconPath: "assets/icons/mnu_distance.webp",
          data: "0",
          unit: "meters",
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
