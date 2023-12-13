import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/blood_oxygen_controller/blood_oxygen_controller.dart';
import 'package:wehealth/global/constants/functions_extensions.dart';
import 'package:wehealth/models/data_model/blood_oxygen_data_fetch_wrapper.dart';
import 'package:wehealth/screens/dashboard/blood_oxygen/manual_blood_oxygen_widget.dart';
import 'package:wehealth/screens/dashboard/widgets/end_curved_index_selector.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';
import 'package:wehealth/screens/dashboard/widgets/meter_bloodoxygen_gauge.dart';

import '../../../global/styles/text_styles.dart';
import '../widgets/indicator_data.dart';

class BloodOxygenDashboard extends StatefulWidget {
  const BloodOxygenDashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<BloodOxygenDashboard> createState() => BloodOxygenDashboardState();
}

class BloodOxygenDashboardState extends State<BloodOxygenDashboard> {
  final baseColor = Colors.amber.shade700;

  int selectedIndex = 0;
  final itemsList = ["Today", "7", "14", "30", "60", "90"];
  int get indexToDay {
    switch (selectedIndex) {
      case 0:
        return 1;
      case 1:
        return 7;
      case 2:
        return 14;
      case 3:
        return 30;
      case 4:
        return 60;
      case 5:
        return 90;
      default:
        return 1;
    }
  }

  String get indexToString {
    switch (selectedIndex) {
      case 0:
        return "Today";
      case 1:
        return "Seven Days";
      case 2:
        return "Fourteen Days";
      case 3:
        return "Thirty Days";
      case 4:
        return "Sixty Days";
      case 5:
        return "Ninety Days";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BloodOxygenController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HorizontalIconedDataTileAdd(
                iconPath: "assets/images/mnu_bo_l.webp",
                data:
                    "${controller.getTheSortedList.lastOrNull?.oxygenlevel ?? 0}%",
                onAddClick: () {
                  Get.to(() => const ManualBloodOxygenWidget());
                },
              ),
              HorizontalEndCurvedIndexSelector(
                selectedIndex: selectedIndex,
                itemsList: itemsList,
                onChange: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              BloodOxygenDataTable(
                selectedSector: indexToString,
                dataList: controller.getBloodOxygenDataByDay(indexToDay),
              ),
              const SizedBox(height: 32),
              SizedBox(
                  height: 180.h,
                  child:
                      MeteredGaugeBloodOxygen(needleValue: double.parse("93"))),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    IndicatorData(
                      color: Colors.red,
                      tag: "Lethal",
                      textColor: Colors.black,
                    ),
                    IndicatorData(
                      color: Colors.greenAccent,
                      tag: "Ideal",
                      textColor: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class BloodOxygenDataTable extends StatelessWidget {
  const BloodOxygenDataTable({
    Key? key,
    required this.selectedSector,
    required this.dataList,
  }) : super(key: key);

  final String selectedSector;
  final List<BloodOxygenData> dataList;

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
                      textAlign: TextAlign.center,
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
                    textAlign: TextAlign.center,
                    style: TextStyles.extraSmallBoldTextStyle(),
                  ),
                ),
              ),
              ...data
            ],
    );
  }

  List<BloodOxygenData> get sortedByOxygenLevel {
    dataList.sort(
      (a, b) => a.oxygenFromString.compareTo(b.oxygenFromString),
    );
    return dataList;
  }

  List<BloodOxygenData> get sortedByPulse {
    dataList.sort(
      (a, b) => a.pulseFromString.compareTo(b.pulseFromString),
    );
    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: Colors.amber.shade700,
      ),
      children: [
        buildRow([selectedSector, "Lowest", "Highest", "Average"], true),
        buildRow([
          "Blood Oxygen (%)",
          "${sortedByOxygenLevel.firstOrNull?.oxygenFromString ?? 0.0}",
          "${sortedByOxygenLevel.lastOrNull?.oxygenFromString ?? 0.0}",
          "${nanConverter((dataList.fold<double>(0, (previousValue, element) => previousValue + element.oxygenFromString)) / dataList.length)}"
        ], false),
        buildRow([
          "Pulse Rate",
          "${sortedByPulse.firstOrNull?.pulseFromString ?? 0.0}",
          "${sortedByPulse.lastOrNull?.pulseFromString ?? 0.0}",
          "${nanConverter((dataList.fold<double>(0, (previousValue, element) => previousValue + element.pulseFromString)) / dataList.length)}"
        ], false),
      ],
    );
  }
}
