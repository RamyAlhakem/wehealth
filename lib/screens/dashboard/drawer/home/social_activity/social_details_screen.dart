import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

class SocialDetailsScreen extends StatefulWidget {
  const SocialDetailsScreen({Key? key}) : super(key: key);

  @override
  State<SocialDetailsScreen> createState() => _SocialDetailsScreenState();
}

class _SocialDetailsScreenState extends State<SocialDetailsScreen> {
  final pageColor = Colors.purple;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      tabCount: 2,
      title: "Sleep",
      appBarColor: pageColor,
      tabTitles: const [
        "DAILY",
        "HISTORY",
      ],
      tabs: [
        SleepDailyTab(),
        const SleepHistoryTab(),
      ],
    );
  }
}

class SleepDailyTab extends StatelessWidget {
  final pageColor = Colors.purple;
  List<ChartData>? chartData = <ChartData>[
    ChartData("2010", 26),
    ChartData("2011", 30),
    ChartData("2012", 32),
    ChartData("2013", 34),
    ChartData("2014", 40),
  ];

  SleepDailyTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HorizontalIconedDataTileFacebook(
          color: pageColor,
          data: "00:00",
          unit: "hh:mm",
          iconPath: "assets/icons/mnu_brain.webp",
        ),
        SizedBox(
          height: 350,
          child: SfCartesianChart(
            plotAreaBorderWidth: 0,
            // title: ChartTitle(text: 'Monthly expense of a family'),
            // legend: Legend(isVisible: true),
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
              labelRotation: -45,
            ),
            primaryYAxis: NumericAxis(
                rangePadding: ChartRangePadding.none,
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(size: 0)),
            series: [
              LineSeries<ChartData, int>(
                markerSettings: const MarkerSettings(isVisible: true),
                dataSource: chartData!,
                xValueMapper: (ChartData data, _) => int.parse(data.x),
                yValueMapper: (ChartData data, _) => data.y,
              ),
            ],
            tooltipBehavior: TooltipBehavior(enable: true),
          ),
        ),
      ],
    );
  }
}

class SleepHistoryTab extends StatelessWidget {
  const SleepHistoryTab({
    Key? key,
  }) : super(key: key);
  final pageColor = Colors.purple;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HorizontalIconedDataTileFacebook(
          color: pageColor,
          data: "00:00",
          unit: "hh:mm",
          iconPath: "assets/icons/mnu_brain.webp",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "No Brain History Data",
            style: TextStyle(color: pageColor, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
