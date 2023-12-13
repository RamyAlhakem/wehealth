// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/widgets/custom_gauge.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';
import 'package:wehealth/screens/dashboard/widgets/indicator_data.dart';
import '../../../global/constants/color_resources.dart';
import '../drawer/drawer_items.dart';
import '../notifications/notification_screen.dart';

class SleepDetailsScreen extends StatefulWidget {
  const SleepDetailsScreen({Key? key}) : super(key: key);

  @override
  State<SleepDetailsScreen> createState() => _SleepDetailsScreenState();
}

class _SleepDetailsScreenState extends State<SleepDetailsScreen> {
  final pageColor = ColorResources.sleepScreenColor;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer:  Platform.isAndroid  ? const DrawerSide()  : null,
        appBar: AppBar(
          backgroundColor: pageColor,
          title: const Text("Sleep Details"),
          automaticallyImplyLeading: !Platform.isIOS,
          leading: Platform.isIOS  
          ?  IconButton(onPressed: (){
            Get.back();
            }, icon: const Icon(Icons.close),) 
          : null,
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                Get.to(() => const NotificationScreen());
              },
              icon: const Icon(Icons.message),
            ),
          ],

          bottom: const TabBar(
              indicatorWeight: 3,
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Text(
                    "Daily",
                  ),
                ),
                Tab(
                  icon: Text(
                    "History",
                  ),
                ),
              ]),
        ),
        body: const TabBarView(
          children: [
            DailySleepTab(),
            SleepHistoryTab(),
          ],
        ),
      ),
    );
  }
}

class SleepHistoryTab extends StatefulWidget {
  const SleepHistoryTab({
    Key? key,
  }) : super(key: key);

  @override
  State<SleepHistoryTab> createState() => _SleepHistoryTabState();
}

class _SleepHistoryTabState extends State<SleepHistoryTab> {
  List<ChartData>? chartData;
  final pageColor = Colors.purple.shade200;

  @override
  void initState() {
    chartData = <ChartData>[
      ChartData("2023-00-00", 0.00),
      ChartData("2023-00-00", 0.00),
      ChartData("2023-00-00", 0.00),
      ChartData("2023-00-00", 0.00),
      ChartData("2023-00-00", 0.00),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HorizontalIconedDataTileFacebook(
          color: pageColor,
          data: "00:00",
          unit: "Hh:mm",
          iconPath: "assets/icons/brain_sleeping.webp",
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 300,
            child: SfCartesianChart(
              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat('yyyy-MM-d'),
              ),
              series: [
                ColumnSeries<ChartData, DateTime>(
                  dataSource: chartData!,
                  xValueMapper: (ChartData sales, _) =>
                      DateFormat('yyyy-MM-d').parse(sales.x),
                  yValueMapper: (ChartData sales, _) => sales.y,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 18,
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.scaleDown,
                          child: Row(
                            children: [
                              Text(
                                "Date: ${DateFormat('MMMM d yyyy').format(DateTime.now())}",
                              ),
                              // Text("Date:"),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox.square(
                            dimension: 24,
                            child: Image.asset(
                              "assets/icons/awakelatest.webp",
                            ),
                          ),
                          SizedBox.square(
                            dimension: 24,
                            child: Image.asset(
                              "assets/icons/awakelatest.webp",
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SfSparkBarChart(
                          trackball: SparkChartTrackball(
                            activationMode: SparkChartActivationMode.tap,
                          ),
                          color: Colors.blue.shade300,
                          data: const [
                            2.5,
                            6.0,
                            2.6,
                            4,
                            5,
                            44,
                            5,
                            5,
                            5,
                          ],
                        ),
                      ),
                      Text("-"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "10:00 PM",
                            textScaleFactor: 1,
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            "to",
                            textScaleFactor: 1,
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            "06:00 AM",
                            textScaleFactor: 1,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: const [
                      Expanded(
                        child: Center(),
                      ),
                      SizedBox(
                        height: 30,
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IndicatorData(
                                color: Colors.green,
                                textColor: Colors.black,
                                tag: "Deep Sleep",
                                isHorizontal: true,
                              ),
                              IndicatorData(
                                color: Colors.greenAccent,
                                textColor: Colors.black,
                                tag: "Sleep",
                                isHorizontal: true,
                              ),
                              IndicatorData(
                                color: Colors.yellow,
                                textColor: Colors.black,
                                tag: "Awake",
                                isHorizontal: true,
                              ),
                            ],
                          ),
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
    );
  }
}

class DailySleepTab extends StatelessWidget {
  const DailySleepTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 200,
              child: CustomGauge(
                  title: "Sleep\n Quality",
                  textColor: Colors.white,
                  needleValue: 50,
                  start: 0,
                  end: 100,
                  gaugeRanges: [
                    GaugeRange(
                      startValue: 0,
                      endValue: 40,
                      color: Colors.purple.shade100,
                    ),
                    GaugeRange(
                      startValue: 40,
                      endValue: 60,
                      color: Colors.purple.shade400,
                    ),
                    GaugeRange(
                      startValue: 60,
                      endValue: 100,
                      color: Colors.purple.shade800,
                    ),
                  ]),
            ),
            const SizedBox(
              height: 200,
              child: Center(
                child: Text("No Chart Data Available!"),
              ),
            ),
            Row(
              children: const [
                Expanded(
                  child: DataCard(
                    data: "0 min",
                    title: "In Bed For",
                  ),
                ),
                Expanded(
                  child: DataCard(
                    data: "0 min",
                    title: "Deep Sleep",
                  ),
                ),
                Expanded(
                  child: DataCard(
                    data: "0 min",
                    title: "Light Sleep",
                  ),
                ),
              ],
            ),
            Row(
              children: const [
                Expanded(
                  child: DataCard(
                    data: "0.00",
                    title: "Feel asleep at",
                  ),
                ),
                Expanded(
                  child: DataCard(
                    data: "0.00",
                    title: "Wake up at",
                  ),
                ),
                Expanded(
                  child: DataCard(
                    data: "0 min",
                    title: "Time awake",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DataCard extends StatelessWidget {
  const DataCard({
    Key? key,
    required this.data,
    required this.title,
    this.color = Colors.white,
  }) : super(key: key);
  final String data;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          data,
          style: TextStyles.smallTextBoldStyle(),
        ),
        Text(
          title,
          maxLines: 2,
          softWrap: true,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ]),
    );
  }
}
