import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehealth/controller/body_measurement_controller/body_measurement_controller.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_boxy_index_selector.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';

import '../../../global/widgets/ios_close_appbar.dart';

class BoneMassDetailsScreen extends StatefulWidget {
  const BoneMassDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BoneMassDetailsScreen> createState() => _BoneMassDetailsScreen();
}

class _BoneMassDetailsScreen extends State<BoneMassDetailsScreen> {
  int selectedIndex = 0;
  final String iconPath = "assets/icons/mnu_bd_l.webp";
  final pageColor = Colors.amber.shade700;
  final List<ChartData> chartData = <ChartData>[
    ChartData('5', 541),
    ChartData('8', 818),
    ChartData('6', 151),
    ChartData('11', 1302),
    ChartData('9', 2017),
    ChartData('13', 1683),
  ];

  @override
  void initState() {
    super.initState();
    final bodyMesure = Get.put(BodyMeasurementController());
    bodyMesure.fetchUserBoneMassoData();
  }

  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BodyMeasurementController>(
      builder: (bodyMeasureController) {
        return IosScaffoldWrapper(
          title: "Bone Mass",
          appBarColor: Colors.amber.shade700,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
            child: Column(
              children: [
                HorizontalIconedDataTileFacebook(
                  color: Colors.amber.shade700,
                  iconPath: iconPath,
                  data: bodyMeasureController.userBoneMassoData?[0].qty!
                        .toStringAsFixed(1) ?? "-",
                  unit: "kg",
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
