import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/blood_glucose_controller/blood_glucose_controller.dart';
import 'package:wehealth/controller/blood_oxygen_controller/blood_oxygen_controller.dart';
import 'package:wehealth/controller/blood_pressure_controller/blood_pressure_controller.dart';
import 'package:wehealth/controller/body_temp_controller/body_temp_controller.dart';
import 'package:wehealth/controller/heart_rate_controller/heart_rate_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/blood_glucose/blood_glucose_screen.dart';
import '../../../controller/profile_controller/profile_controller.dart';
import '../blood_oxygen/blood_oxygen_screen.dart';
import '../blood_pressure/blood_pressure_screen.dart';
import 'package:wehealth/screens/dashboard/body_measurements/bmi_details_screen.dart';
import 'package:wehealth/screens/dashboard/body_measurements/bmr_details_screen.dart';
import 'package:wehealth/screens/dashboard/body_measurements/body_fat_details_screen.dart';
import 'package:wehealth/screens/dashboard/body_measurements/body_water_details_screen.dart';
import 'package:wehealth/screens/dashboard/body_measurements/bone_mass_details_screen.dart';
import 'package:wehealth/screens/dashboard/body_measurements/metabolic_age_screen.dart';
import 'package:wehealth/screens/dashboard/body_measurements/muscle_mass_details_screen.dart';
import 'package:wehealth/screens/dashboard/body_measurements/skin_fold_details_screen.dart';
import 'package:wehealth/screens/dashboard/body_measurements/visceral_fat_details_screen.dart';
import 'package:wehealth/screens/dashboard/body_measurements/waist_hip_ratio/waist_hip_details_screen.dart';
import 'package:wehealth/screens/dashboard/body_temperature/body_temperature_screen.dart';
import 'package:wehealth/screens/dashboard/heart_rate/heart_rate_screen.dart';
import '../../../controller/body_measurement_controller/body_measurement_controller.dart';
import '../../../global/widgets/ios_close_appbar.dart';
import '../../../models/data_model/user_bp_model.dart';
import 'body_measurements_screen.dart';
import 'package:collection/collection.dart';

class BodyMeasurementHome extends StatefulWidget {
  const BodyMeasurementHome({Key? key}) : super(key: key);

  @override
  State<BodyMeasurementHome> createState() => _BodyMeasurementHomeState();
}

class _BodyMeasurementHomeState extends State<BodyMeasurementHome> {
  final pageColor = Colors.amber.shade700;
  BPData? _bpData;

  @override
  void initState() {
    super.initState();
    final bodyMesure = Get.put(BodyMeasurementController());
    bodyMesure.fetchUserBodyWeightData();
    bodyMesure.fetchUserBodyBmrData();
    bodyMesure.fetchUserBodyFatData();
    bodyMesure.fetchUserMetabolicAgeData();
    bodyMesure.fetchUserMuscularMassData();
    bodyMesure.fetchUserVisceralarFatData();
    bodyMesure.fetchUserBodyWaterData();
    bodyMesure.fetchUserWaistHipRatioData();
    bodyMesure.fetchUserBoneMassoData();
    //Get.find<HeartRateController>().getHeartRateDataByType(1);

    _bpData = Get.find<BloodPressureController>().currentSortedList.lastOrNull;

    Get.find<ProfileController>().addListenerId("initialization", () {});

    ProfileController controller = Get.find<ProfileController>();
    controller.calculateBMI();
  }

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      appBarColor: pageColor,
      title: "Body Measurement",
      body: GetBuilder<BodyMeasurementController>(
          builder: (bodyMeasureController) {
        return SingleChildScrollView(
          child: Column(
            children: [
              DataNavigationListTile(
                pageColor: pageColor,
                data:
                    "${bodyMeasureController.getDateSortedBodyWeightData().lastOrNull?.qty ?? "-"}",
                unit: "kg",
                name: "Body Weight",
                leading: const CircularDataLeading(data: "100%"),
                onTap: () {
                  Get.to(() => const BodyMeasurementsScreen());
                },
              ),
              DataNavigationListTile(
                pageColor: pageColor,
                data: Get.find<ProfileController>().bmi.toStringAsFixed(0),
                unit: "kg/m2",
                name: "BMI",
                leading: const CircularDataLeading(data: "100%"),
                onTap: () {
                  Get.to(() => const BMIDetailsScreen());
                },
              ),
              DataNavigationListTile(
                pageColor: pageColor,
     
                data: bodyMeasureController.userMetabolicAgeData?[0].metabolicage ?? "-",
                unit: "kg",
                name: "Metabolic Age",
                leading: Image.asset(
                  "assets/icons/metabolicage.webp",
                  color: pageColor,
                ),
                onTap: () {
                  Get.to(() => const MetabolicAgeDetailsScreen());
                },
              ),
              DataNavigationListTile(
                pageColor: pageColor,
                data: bodyMeasureController.userbodyFatData?[0].qty!.toStringAsFixed(1) ?? "-",
                unit: "%",
                name: "Body Fat",
                leading: Image.asset(
                  "assets/images/mnu_bf_l.webp",
                  color: pageColor,
                ),
                onTap: () {
                  Get.to(() => const BodyFatDetailsScreen());
                },
              ),
              DataNavigationListTile(
                pageColor: pageColor,
                data: bodyMeasureController.userBodyWaterData?[0].qty!.toStringAsFixed(1) ?? "-",
                unit: "%",
                name: "Body Water",
                leading: Image.asset(
                  "assets/icons/mnu_bw_l.webp",
                  color: pageColor,
                ),
                onTap: () {
                  Get.to(() => const BodyWaterDetailsScreen());
                },
              ),
              DataNavigationListTile(
                pageColor: pageColor,
                data: bodyMeasureController.userBoneMassoData?[0].qty!
                        .toStringAsFixed(1) ?? "-",
                unit: "kg",
                name: "Bone Mass",
                leading: Image.asset(
                  "assets/icons/mnu_bd_l.webp",
                  color: pageColor,
                ),
                onTap: () {
                  Get.to(() => const BoneMassDetailsScreen());
                },
              ),
              DataNavigationListTile(
                pageColor: pageColor,
                data: bodyMeasureController.userViscelarFatdata?[0].qty!
                        .toStringAsFixed(1) ?? "-",
                unit: "%",
                name: "Visceral Fat",
                leading: Image.asset(
                  "assets/images/mnu_bf_l.webp",
                  color: pageColor,
                ),
                onTap: () {
                  Get.to(() => const VisceralFatDetailsScreen());
                },
              ),
              DataNavigationListTile(
                pageColor: pageColor,
                data: bodyMeasureController.userMuscularMassData?[0].qty!
                        .toStringAsFixed(1) ?? "-",
                unit: "kg",
                name: "Muscle Mass",
                leading: Image.asset(
                  "assets/icons/mnu_bmm_l.webp",
                  color: pageColor,
                ),
                onTap: () {
                  Get.to(() => const MuscleMassDetailsScreen());
                },
              ),
              DataNavigationListTile(
                pageColor: pageColor,
                data: bodyMeasureController.userbodyBmrData?[0].qty!.toStringAsFixed(0) ?? "-",
                unit: "kcal",
                name: "Body Metabolic Rate (BMR)",
                leading: Image.asset(
                  "assets/images/mnu_bf_l.webp",
                  color: pageColor,
                ),
                onTap: () {
                  Get.to(() => const BMRDetailsScreen());
                },
              ),
              DataNavigationListTile(
                pageColor: pageColor,
                //data:"-",
                //data:"${Get.find<HeartRateController>().getHeartRateDataByType(1).lastOrNull?.heartRateQty ?? "-"}",
                data:"${Get.find<HeartRateController>().typeCacheMap[1]?.lastOrNull?.heartRateQty ?? "-"}",
                unit: "bpm",
                name: "Heart Rate",
                leading: Image.asset(
                  "assets/icons/mnu_heartrate_l.webp",
                  color: pageColor,
                ),
                onTap: () {
                  Get.to(() => const HeartRateScreen());
                },
              ),
              DataNavigationListTile(
                pageColor: pageColor,
                data:
                    "${_bpData?.systolic ?? "-"} / ${_bpData?.diastolic ?? "-"}",
                unit: "",
                name: "Blood Pressure",
                leading: Image.asset(
                  "assets/icons/mnu_bp_l.webp",
                  color: pageColor,
                ),
                onTap: () {
                  Get.to(() => const BloodPressureScreen());
                },
              ),
              DataNavigationListTile(
                pageColor: pageColor,
                data:
                    "${(Get.find<BloodGlucoseController>().getBloodGlucoseDataByType("BeforeMeal").lastOrNull?.glucoseLevel ?? 0).toPrecision(2)}",
                unit: "mmol/L",
                name: "Blood Glucose",
                leading: Image.asset(
                  "assets/icons/mnu_bg_l.webp",
                  color: pageColor,
                ),
                onTap: () {
                  Get.to(() => const BloodGlucoseScreen());
                },
              ),
              DataNavigationListTile(
                pageColor: pageColor,
                data:
                    "${Get.find<BodyTemperatureController>().tempDataSortedByDate.lastOrNull?.pursedTempC.toStringAsFixed(1) ?? 0.0}",
                unit: "",
                name: "Body Temperature",
                leading: Image.asset(
                  "assets/icons/mnu_bt_l.webp",
                  color: pageColor,
                ),
                onTap: () {
                  Get.to(() => const BodyTemperatureScreen());
                },
              ),
              DataNavigationListTile(
                pageColor: pageColor,
                data: "${Get.find<BloodOxygenController>().getTheSortedList.lastOrNull?.oxygenlevel ?? 0}",
                unit: "%",
                name: "Blood Oxygen",
                leading: Image.asset(
                  "assets/images/mnu_bf_l.webp",
                  color: pageColor,
                ),
                onTap: () {
                  Get.to(() => const BloodOxygenScreen());
                },
              ),
              DataNavigationListTile(
                pageColor: pageColor,
                //data: "-",
                data: bodyMeasureController.userWaistHipRatioData!.isEmpty ? "-" : bodyMeasureController.userWaistHipRatioData != null? bodyMeasureController.userWaistHipRatioData![0].waisttohipratio! : "-",
                unit: "",
                name: "Waist-Hip Ratio",
                leading: Image.asset(
                  "assets/icons/waistcircumference.webp",
                  color: pageColor,
                ),
                onTap: () {
                  Get.to(() => const WaistHipRatioDetailsScreen());
                },
              ),
              DataNavigationListTile(
                pageColor: pageColor,
                data: "-",
                unit: "",
                name: "Skin Folds",
                leading: Image.asset(
                  "assets/icons/waistcircumference.webp",
                  color: pageColor,
                ),
                onTap: () {
                  Get.to(() => const SkinFoldsDetailsScreen());
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

class DataNavigationListTile extends StatelessWidget {
  const DataNavigationListTile({
    Key? key,
    required this.pageColor,
    required this.data,
    required this.unit,
    required this.name,
    required this.leading,
    required this.onTap,
  }) : super(key: key);

  final Color pageColor;
  final String data;
  final String unit;
  final String name;
  final Widget leading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minLeadingWidth: 40,
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        horizontalTitleGap: 12,
        tileColor: Colors.white70,
        leading: SizedBox(width: 64, height: 64, child: leading),
        title: RichText(
          text: TextSpan(
            text: data,
            style: TextStyles.normalTextStyle().copyWith(color: pageColor),
            children: [
              TextSpan(
                text: " $unit",
                style: TextStyles.smallTextStyle().copyWith(color: pageColor),
              ),
            ],
          ),
        ),
        subtitle: Text(
          name,
          style: TextStyle(color: pageColor),
        ),
      ),
    );
  }
}

class CircularDataLeading extends StatelessWidget {
  const CircularDataLeading({
    Key? key,
    required this.data,
  }) : super(key: key);
  final String data;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.amber,
        ),
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
