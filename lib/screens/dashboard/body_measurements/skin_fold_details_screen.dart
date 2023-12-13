import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/widgets/end_curved_index_selector.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

class SkinFoldsDetailsScreen extends StatefulWidget {
  const SkinFoldsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<SkinFoldsDetailsScreen> createState() => SkinFoldsDetailsScreenState();
}

class SkinFoldsDetailsScreenState extends State<SkinFoldsDetailsScreen> {
  final pageColor = Colors.amber.shade600;
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      appBarColor: pageColor,
      tabCount: 3,
      title: "Skin Folds",
      tabTitles: const [
        "Dashboard",
        "Trends",
        "Timelines",
      ],
      tabs: [
        const SkinFoldsDashboardTab(),
        SkinFoldsTrendsTab(),
        Center(),
      ],
    );
  }
}

class SkinFoldDataTable extends StatelessWidget {
  const SkinFoldDataTable({
    Key? key,
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12),
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
        buildRow(["Chest", "0", "0", "0"], false),
        buildRow(["Thigh", "0", "0", "0"], false),
        buildRow(["Abdominal", "0", "0", "0"], false),
        buildRow(["Body Density", "0", "0", "0"], false),
      ],
    );
  }
}

class SkinFoldsDashboardTab extends StatefulWidget {
  const SkinFoldsDashboardTab({
    Key? key,
  }) : super(key: key);

  @override
  State<SkinFoldsDashboardTab> createState() => SkinFoldsDashboardTabState();
}

class SkinFoldsDashboardTabState extends State<SkinFoldsDashboardTab> {
  int selectedIndex = 0;
  final pageColor = Colors.amberAccent;
  final String iconPath = "assets/icons/waistcircumference.webp";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
      child: Column(
        children: [
          HorizontalIconedDataTileAdd(
            iconPath: iconPath,
            data: "0.92",
            unit: "%",
            baseColor: pageColor,
          ),
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
          const SkinFoldDataTable(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class SkinFoldsTrendsTab extends StatelessWidget {
  SkinFoldsTrendsTab({
    Key? key,
  }) : super(key: key);

  final int selectedIndex = 0;
  final pageColor = Colors.amberAccent;
  final String iconPath = "assets/icons/waistcircumference.webp";
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
      child: Column(
        children: [
          HorizontalIconedDataTileAdd(
            iconPath: iconPath,
            data: "0.92",
            unit: "%",
            baseColor: pageColor,
          ),
          Expanded(
            child: SfCartesianChart(
              series: <ChartSeries>[
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
              ],
            ),
          ),
          const Text(
            "Difference Tab",
          ),
        ],
      ),
    );
  }
}
