import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehealth/controller/body_measurement_controller/body_measurement_controller.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_boxy_index_selector.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';

import '../../../global/widgets/ios_close_appbar.dart';

class MetabolicAgeDetailsScreen extends StatefulWidget {
  const MetabolicAgeDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MetabolicAgeDetailsScreen> createState() =>
      _MetabolicAgeDetailsScreen();
}

class _MetabolicAgeDetailsScreen extends State<MetabolicAgeDetailsScreen> {
  int selectedIndex = 0;
  final String iconPath = "assets/icons/metabolicage.webp";
  final pageColor = Colors.amber.shade700;
  final List<ChartData> chartData = [
    ChartData("2010", 35),
    ChartData("2011", 28),
    ChartData("2012", 34),
    ChartData("2013", 32),
    ChartData("2014", 60),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BodyMeasurementController>(
      builder: (bodyMeasureController) {
        return IosScaffoldWrapper(
          title: "Metabolic Age",
          appBarColor: pageColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
            child: Column(
              children: [
                HorizontalIconedDataTileFacebook(
                  color: pageColor,
                  iconPath: iconPath,
                  data: bodyMeasureController.userMetabolicAgeData?[0].metabolicage ?? "-",
                  unit: "Years",
                ),
                HorizontalBoxyIndexSelector(
                  selectedIndex: selectedIndex,
                  itemsList: const <String>["Today", "7", "14", "30", "60", "90"],
                  onChange: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                Expanded(
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
              ],
            ),
          ),
        );
      }
    );
  }
}

@override
Widget build(BuildContext context) {
  final List<ChartData> chartData = [
    ChartData("2010", 35),
    ChartData("2011", 28),
    ChartData("2012", 34),
    ChartData("2013", 32),
    ChartData("2014", 40)
  ];

  return Scaffold(
      body: Center(
          child: Container(
              child: SfCartesianChart(
                  primaryXAxis: DateTimeAxis(),
                  series: <ChartSeries>[
        // Renders line chart
        LineSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y)
      ]))));
}
