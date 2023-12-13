import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/blood_glucose_controller/blood_glucose_controller.dart';
import 'package:wehealth/controller/user_devices_controller/user_devices_controller.dart';
import 'package:wehealth/models/data_model/blood_glucose_data_fetch_wrapper.dart';
import 'package:wehealth/screens/dashboard/blood_glucose/manual_blood_glucose_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/end_curved_index_selector.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';
import 'package:wehealth/screens/dashboard/widgets/meter_bloodoxygen_gauge.dart';
import '../../../global/styles/text_styles.dart';
import '../widgets/indicator_data.dart';

class BloodGlucoseDashboardTab extends StatefulWidget {
  const BloodGlucoseDashboardTab({
    Key? key,
  }) : super(key: key);

  @override
  State<BloodGlucoseDashboardTab> createState() =>
      BloodGlucoseDashboardTabState();
}

class BloodGlucoseDashboardTabState extends State<BloodGlucoseDashboardTab> {
  int selectedIndex = 0;
  final baseColor = Colors.grey;

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
        return "Seven days";
      case 2:
        return "Fourteen days";
      case 3:
        return "Thirty days";
      case 4:
        return "Sixty days";
      case 5:
        return "Ninety days";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BloodGlucoseController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HorizontalIconedDataTileAdd(
                iconPath: "assets/icons/mnu_bg_l.webp",
                data:
                    "${(controller.getBloodGlucoseDataByType("BeforeMeal").lastOrNull?.glucoseLevel ?? 0).toPrecision(2)}",
                unit: "mmol/L",
                baseColor: baseColor,
                seconderyWidget: Get.find<UserDevicesController>()
                        .hasBloodGlucoseDevice
                    ? Image.asset(
                        "assets/icons/devices/bluetooth_glucose_disconnect.webp")
                    : const SizedBox(),
                onAddClick: () {
                  Get.to(() => const ManualBloodGlucoseWidget());
                },
              ),
              HorizontalEndCurvedIndexSelector(
                selectedIndex: selectedIndex,
                itemsList: const [
                  "Today",
                  "7",
                  "14",
                  "30",
                  "60",
                  "90",
                ],
                borderColor: Colors.grey.shade900,
                unselectedBg: baseColor,
                onChange: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              BloodGlucoseDataTable(
                selectedSection: indexToString,
                data: controller.getBloodGlucoseDataByDay(indexToDay),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 180.h,
                child: MeteredGaugeBloodOxygen(needleValue: double.parse("93")),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    IndicatorData(
                      color: Colors.red,
                      tag: "Low",
                      textColor: Colors.black,
                    ),
                    IndicatorData(
                      color: Colors.green,
                      tag: "Ideal",
                      textColor: Colors.black,
                    ),
                    IndicatorData(
                      color: Colors.red,
                      tag: "High",
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

class BloodGlucoseDataTable extends StatelessWidget {
  final String selectedSection;
  const BloodGlucoseDataTable({
    Key? key,
    required this.data,
    required this.selectedSection,
  }) : super(key: key);

  final List<BloodGlucoseData> data;

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
                  //TODO: Change here if the titles get to squeeshed!
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
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

  List<BloodGlucoseData> getBloodGlucoseDataByType(String type) {
    final filteredList =
        data.where((element) => element.mealType == type).toList();
    filteredList.sort(
      (a, b) => a.glucoseLevel!.compareTo(b.glucoseLevel!),
    );
    return filteredList;
  }

  double getAverageById(String type) =>
      getBloodGlucoseDataByType(type).fold<double>(0,
          (previousValue, element) => previousValue + element.glucoseLevel!) /
      getBloodGlucoseDataByType(type).length;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: Colors.grey,
      ),
/*       columnWidths: const {
        0 : FlexColumnWidth(2),
      }, */
      children: [
        buildRow([selectedSection, "Lowest", "Highest", "Average"], true),
        buildRow([
          "Before Meal",
          "${getBloodGlucoseDataByType("BeforeMeal").firstOrNull?.glucoseLevel ?? 0}",
          "${getBloodGlucoseDataByType("BeforeMeal").lastOrNull?.glucoseLevel ?? 0}",
          "${getAverageById("BeforeMeal").isNaN ? 0.0 : getAverageById("BeforeMeal").toPrecision(2)}",
        ], false),
        buildRow([
          "After Meal",
          "${getBloodGlucoseDataByType("AfterMeal").firstOrNull?.glucoseLevel ?? 0}",
          "${getBloodGlucoseDataByType("AfterMeal").lastOrNull?.glucoseLevel ?? 0}",
          "${getAverageById("AfterMeal").isNaN ? 0.0 : getAverageById("AfterMeal").toPrecision(2)}",
        ], false),
        buildRow([
          "Before Bed",
          "${getBloodGlucoseDataByType("BeforeBed").firstOrNull?.glucoseLevel ?? 0}",
          "${getBloodGlucoseDataByType("BeforeBed").lastOrNull?.glucoseLevel ?? 0}",
          "${getAverageById("BeforeBed").isNaN ? 0.0 : getAverageById("BeforeBed").toPrecision(2)}",
        ], false),
        buildRow([
          "Fasting",
          "${getBloodGlucoseDataByType("Fasting").firstOrNull?.glucoseLevel ?? 0}",
          "${getBloodGlucoseDataByType("Fasting").lastOrNull?.glucoseLevel ?? 0}",
          "${getAverageById("Fasting").isNaN ? 0.0 : getAverageById("Fasting").toPrecision(2)}",
        ], false),
      ],
    );
  }
}
