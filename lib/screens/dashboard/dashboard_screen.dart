import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wehealth/controller/blood_glucose_controller/blood_glucose_controller.dart';
import 'package:wehealth/controller/blood_oxygen_controller/blood_oxygen_controller.dart';
import 'package:wehealth/controller/blood_pressure_controller/blood_pressure_controller.dart';
import 'package:wehealth/controller/body_temp_controller/body_temp_controller.dart';
import 'package:wehealth/controller/heart_rate_controller/heart_rate_controller.dart';
import 'package:wehealth/controller/home_tiles_controller/home_tiles_controller.dart';
import 'package:wehealth/controller/google_fit_controller/google_fit_controller.dart';
import 'package:wehealth/controller/profile_controller/profile_controller.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/controller/user_devices_controller/user_devices_controller.dart';
import 'package:wehealth/global/constants/color_resources.dart';
import 'package:wehealth/global/constants/functions_extensions.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/blood_oxygen/blood_oxygen_screen.dart';
import 'package:wehealth/screens/dashboard/blood_pressure/blood_pressure_screen.dart';
import 'package:wehealth/screens/dashboard/body_measurements/body_measurements_screen.dart';
import 'package:wehealth/screens/dashboard/diet_intake/diet_intake_screen.dart';
import 'package:wehealth/screens/dashboard/family/next_of_kin.dart';
import 'package:wehealth/screens/dashboard/heart_rate/heart_rate_screen.dart';
import 'package:wehealth/screens/dashboard/med_assist/add_med_assist_screen.dart';
import 'package:wehealth/screens/dashboard/notifications/notification_screen.dart';
import 'package:wehealth/screens/dashboard/physical_activity/physical_activity_screen.dart';
import 'package:wehealth/screens/dashboard/sleep/sleep_screen.dart';
// import 'package:wehealth/screens/dashboard/sleep/sleep_screen.dart';
import 'package:wehealth/screens/dashboard/ummc_my_health/ummc_my_health_screen.dart';
import '../../controller/body_measurement_controller/body_measurement_controller.dart';
import '../../global/methods/methods.dart';
import 'blood_glucose/blood_glucose_screen.dart';
import 'body_temperature/body_temperature_screen.dart';
import 'drawer/drawer_items.dart';
import 'med_assist/med_assist_dashboard.dart';

class DashboardScreen extends StatefulWidget {
  static const String id = "/dashboardScreen";
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  DateTime? currentBackPressTime;
  bool accpectPermission = false;
  bool _exitInitialized = false;
  late GoogleFitController physicalActController;
  @override
  void initState() {
    super.initState();
    physicalActController = Get.put(GoogleFitController());
    Get.find<BloodGlucoseController>().fetchUserBloodGlucoseData();
    Get.find<BloodPressureController>().fetchUserBloodPressureHistory();
    Get.find<BodyTemperatureController>().fetchBodyTempData();
    Get.find<BloodOxygenController>().fetchUserBloodOxygenData();
    Get.find<HeartRateController>()
        .fetchUserHeartRate(); // |=>  Try not to run unless delete the userdata from wehealth.my@gmail.com
    Get.put(UserDevicesController(), permanent: true).getUserDevices();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        if (!(await Permission.location.isGranted &&
            await Permission.locationAlways.isGranted)) {
          if (context.mounted) {
            await showPermissionDialog(
              context,
              androidDescription:
                  "We would ask for the following permissions while using respective freatures in the app to give your a better experience.\n\n Location permission is required for our WeHealth app to get BLE scan result.\n\nMedical devices (e.g. blood glucose meters) can be paired with your mobile device which enables data to be transferred to our WeHealth apps.\n\nIt is mendatory for our WeHealth app to have location permissions in order to work with Bluetooth devices.",
              iosDescription: iOSDescription,
              onOk: () async {
                var status = await Permission.location.request();
                var always = await Permission.locationAlways.request();
                if (status == PermissionStatus.granted) {
                  if (always != PermissionStatus.granted && context.mounted) {
                    Get.back();
                    await showPermissionDialog(
                      context,
                      androidDescription:
                          "Background location permission (Allow all the time) is needed to allow for aproximity notification service using Bluetooth LE for Health Measurement in the background even when the app is closed or not in use.\n\nHealth Measurement that are using BLE and required backgroud location permission are listed below.\n\n1)Blood Glucose Measurement\n\n2)Blood Pressure Measurement",
                      iosDescription:
                          'Background location permission (Allow all the time) is needed to allow for aproximity notification service using Bluetooth LE for Health Measurement in the background even when the app is closed or not in use.\n\nHealth Measurement that are using BLE and required backgroud location permission are listed below.\n\n1)Blood Glucose Measurement\n\n2)Blood Pressure Measurement\n\nGo to settings\n>Find the app (WeHealth) & press on\n>Then press on location & select Always',
                      onOk: () async {
                        await openAppSettings();
                        Get.back();
                      },
                      onCancel: () {
                        Get.back();
                      },
                    );
                  } else {
                    Get.back();
                  }
                } else {
                  log("Permission denied! for $status");
                  log("Permission denied! for $always");
                  log("Permission denied!");
                  Get.back();
                }
              },
              onCancel: () async {
                Get.find<StorageController>().updatePermissionStatus(false);
                Get.back();
              },
            );
          }
        }
      },
    );
  }

  Future<bool> onAttemptToExit(BuildContext context) async {
    if (_exitInitialized) {
      exit(0);
    } else {
      _exitInitialized = true;
    }
    showToast("Press again to exit!", context);
    Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        _exitInitialized = false;
        timer.cancel();
      },
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onAttemptToExit(context),
      child: GetBuilder<HomeTileController>(builder: (tileController) {
        if (tileController.tilesForHome.length == 1) {
          return getSingleTilePages(tileController.tilesForHome.first);
        }

        return Scaffold(
          drawer: const DrawerSide(),
          key: _key,
          appBar: AppBar(
            title: const Text("Dashboard"),
            actions: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  Get.to(() => const NotificationScreen());
                },
                icon: const Icon(Icons.message),
              ),
            ],
          ),
          body: Column(
            children: [
              (tileController.tilesForHome.length == 4)
                  ? Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child:
                                getTileFromData(tileController.tilesForHome[0]),
                          ),
                          Expanded(
                            child:
                                getTileFromData(tileController.tilesForHome[1]),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      //* INDEX 1
                      child: getTileFromData(tileController.tilesForHome[0]),
                    ),
              if (tileController.tilesForHome.length >= 2 &&
                  tileController.tilesForHome.length != 4)
                Expanded(
                  child: (tileController.tilesForHome.length > 4)
                      ? Row(
                          children: [
                            Expanded(
                              //* INDEX 2
                              child: getTileFromData(
                                  tileController.tilesForHome[1]),
                            ),
                            Expanded(
                              //* INDEX 3
                              child: getTileFromData(
                                  tileController.tilesForHome[2]),
                            ),
                          ],
                        )
                      :
                      //* INDEX 2
                      getTileFromData(tileController.tilesForHome[1]),
                ),
              if (tileController.tilesForHome.length >= 3)
                Expanded(
                  child: (tileController.tilesForHome.length >= 4)
                      ? Row(
                          children: [
                            Expanded(
                              //* INDEX 4
                              child: getTileFromData(
                                  tileController.tilesForHome[
                                      tileController.tilesForHome.length - 2]),
                            ),
                            Expanded(
                              //* INDEX 5
                              child: getTileFromData(
                                  tileController.tilesForHome[
                                      tileController.tilesForHome.length - 1]),
                            ),
                          ],
                        )
                      :
                      //* INDEX 3
                      getTileFromData(tileController.tilesForHome[2]),
                ),
            ],
          ),
        );
      }),
    );
  }

  showPermissionDialog(
    BuildContext context, {
    required String androidDescription,
    required String iosDescription,
    required VoidCallback onOk,
    required VoidCallback onCancel,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          contentPadding: EdgeInsets.all(12.sp),
          title: const Text("Request Permissions!!"),
          content: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Platform.isAndroid ? androidDescription : iOSDescription,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: onCancel,
              child: const Text(
                "CANCEL",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: onOk,
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Widget getTileFromData(HomeClassTile tile) {
    if (tile is PhysicalActivity) {
      return GetBuilder<GoogleFitController>(
        builder: (controller) {
          return PhysicalActiviyWidget(
            data: /* controller.dailySteps.toStringAsFixed(0) */ "0",
            dataTitle: "Daily Steps",
            title: "Physical Activity",
            unit: "Steps",
            onTap: () {
              //controller.getGoogleFitSteps(); // stop calling sync
              Get.to(() => const PhysicalActivityScreen());
            },
            secondWidget: BottomTitledGauge(
              bottomTitle: "of total goal.",
              percentageValue:
                  /* "${nanConverter((controller.dailySteps / int.parse(controller.stepTarget)) * 100)}" */ "0",
            ),
          );
        },
      );
    } else if (tile is DietaryIntake) {
      return DashboardTileWidget(
          onTap: () {
            Get.to(() => const DietIntakeScreen());
          },
          title: "Dietary Intake",
          color: Colors.green.shade700,
          data: "0",
          dataTitle: "Total Calories Intake",
          image: "assets/images/illustration_diet.webp",
          unit: "Kcal");
    } else if (tile is BodyTemperature) {
      return GetBuilder<BodyTemperatureController>(builder: (controller) {
        return DashboardTileWidget(
          data: (controller.tempDataSortedByDate.lastOrNull?.pursedTempC ?? 0)
              .toStringAsFixed(1),
          unit: "C",
          title: "Body Temperature",
          dataTitle: "Body Temperature",
          image: "assets/images/temperature.webp",
          onTap: () {
            Get.to(() => const BodyTemperatureScreen());
          },
          color: Colors.red,
        );
      });
    } else if (tile is BodyMeasurement) {
      return GetBuilder<BodyMeasurementController>(builder: (controller) {
        return DashboardTileWidget(
            onTap: () {
              Get.to(() => const BodyMeasurementsScreen());
            },
            title: "Body Measurements",
            color: Colors.yellow.shade800,
            data:
                "${controller.getDateSortedBodyWeightData().firstOrNull?.qty ?? 0}",
            dataTitle: "Weight",
            image: "assets/images/illustration_body_measurement.webp",
            unit: "kg");
      });
    } else if (tile is BloodGlucose) {
      return GetBuilder<BloodGlucoseController>(builder: (controller) {
        return DashboardTileWidget(
          data:
              "${(controller.getBloodGlucoseDataByType("BeforeMeal").lastOrNull?.glucoseLevel ?? 0).toPrecision(1)}",
          unit: "mmol/L",
          title: "Blood Glucose",
          dataTitle: "Blood Glucose Level",
          image: "assets/images/illustration_blood_glucose.webp",
          color: Colors.grey,
          onTap: () {
            Get.to(() => const BloodGlucoseScreen());
          },
        );
      });
    } else if (tile is BloodOxygen) {
      return GetBuilder<BloodOxygenController>(builder: (controller) {
        return DashboardTileWidget(
          data: "${controller.getTheSortedList.lastOrNull?.oxygenlevel ?? 0}",
          unit: "Spo2",
          title: "Blood Oxygen (Spo2)",
          dataTitle: "Blood Oxygen",
          image: "assets/images/spo2umch.webp",
          color: Colors.grey.shade600,
          onTap: () {
            Get.to(() => const BloodOxygenScreen());
          },
        );
      });
    } else if (tile is HeartRate) {
      return GetBuilder<HeartRateController>(builder: (controller) {
        return DashboardTileWidget(
          data: "${controller.typeCacheMap[1]?.lastOrNull?.heartRateQty ?? 0}",
          unit: "bpm",
          title: "Heart Rate",
          dataTitle: "Active Heart Rate",
          image: "assets/images/heartrateillustration.webp",
          onTap: () {
            Get.to(() => const HeartRateScreen());
          },
          color: Colors.green.shade400,
        );
      });
    } else if (tile is BloodPressure) {
      return GetBuilder<BloodPressureController>(builder: (controller) {
        return DashboardTileWidget(
          data:
              "${controller.currentSortedList.lastOrNull?.systolic ?? 0}/${controller.currentSortedList.lastOrNull?.diastolic ?? 0}",
          unit: "mmHg",
          title: "Blood Pressure",
          dataTitle: "Blood Pressure Level",
          image: "assets/images/illustration_blood_pressure.webp",
          onTap: () {
            Get.to(() => const BloodPressureScreen());
          },
          color: Colors.orange.shade700,
        );
      });
    } else if (tile is MedAssist) {
      return DashboardTileMedAssist(
        onTap: () {
          Get.to(() => const MedAssistDashboardScreen());
        },
        title: "Med Assist",
        color: Colors.pinkAccent,
        data: dayPortionToString(TimeOfDay.now()),
        unit: "",
        dataTitle: "Pink",
        image: "assets/images/illustration_medassist.webp",
      );
    } else if (tile is Sleep) {
      return DashboardTileWidget(
        data: "00:00",
        unit: "hh:mm",
        title: "Sleep",
        dataTitle: "Daily Sleep TIme",
        image: "assets/images/illustration_sleep.webp",
        onTap: () {
          Get.to(() => const SleepScreen());
        },
        color: Colors.purple.shade300,
      );
    } else if (tile is Family) {
      return DashboardTileWidget(
        onTap: () {
          Get.to(
            () => const NextOfKinScreen(),
          );
        },
        title: tile.title,
        color: tile.baseColor,
        data: "0",
        dataTitle: "Care Taker",
        image: tile.imageIcon,
        unit: "",
      );
    } else if (tile is MyHealth) {
      return GetBuilder<ProfileController>(builder: (controller) {
        return DashboardTileWidget(
          onTap: () {
            Get.to(() => const MyHealthScreen());
          },
          title: tile.title,
          color: tile.baseColor,
          data: "",
          dataTitle: (controller.userProfile.loginType == "0" ||
                  controller.userProfile.loginType == "")
              ? "Not Connected!"
              : "Yes, Connected!",
          image: tile.imageIcon,
          unit: "",
        );
      });
    } else {
      return DashboardTileWidget(
        data: "00:00",
        unit: "hh:mm",
        title: "Widget isn't made yet!",
        dataTitle: "Daily Sleep Time",
        image: "assets/images/illustration_sleep.webp",
        onTap: () {},
        color: Colors.purple.shade300,
      );
    }
  }

  Widget getSingleTilePages(HomeClassTile tile) {
    if (tile is PhysicalActivity) {
      return const PhysicalActivityScreen();
    }
    if (tile is DietaryIntake) {
      return const DietIntakeScreen();
    }
    if (tile is BodyTemperature) {
      return const BodyTemperatureScreen();
    }
    if (tile is BodyMeasurement) {
      return const BodyMeasurementsScreen();
    }
    if (tile is BloodGlucose) {
      return const BloodGlucoseScreen();
    }
    if (tile is BloodOxygen) {
      return const BloodOxygenScreen();
    }
    if (tile is HeartRate) {
      return const HeartRateScreen();
    }
    if (tile is BloodPressure) {
      return const BloodPressureScreen();
    }
    if (tile is MedAssist) {
      return const MedAssistScreen();
    }
    if (tile is Sleep) {
      // return const SleepScreen();
    }
    if (tile is Family) {
      return const NextOfKinScreen();
    }
    if (tile is MyHealth) {
      return const MyHealthScreen();
    } else {
      return const SizedBox();
    }
  }
}

class DashboardTileWidget extends StatelessWidget {
  const DashboardTileWidget({
    Key? key,
    required this.onTap,
    required this.title,
    required this.color,
    required this.data,
    required this.dataTitle,
    required this.image,
    required this.unit,
    this.secondWidgt,
    this.isGauge = false,
  }) : super(key: key);
  final VoidCallback onTap;
  final bool isGauge;
  final Widget? secondWidgt;
  final String title;
  final Color color;
  final String data;
  final String unit;
  final String dataTitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 4, left: 2, right: 2, bottom: 0),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.extraSmallBoldTextStyle()
                        .copyWith(color: Colors.white),
                  ),
                  const Divider(
                    thickness: 1,
                    color: ColorResources.colorWhite,
                  ),
                  RichText(
                    text: TextSpan(
                        text: data,
                        style: TextStyles.extraLargeTextBoldStyle()
                            .copyWith(color: Colors.white),
                        children: [
                          TextSpan(
                            text: " $unit",
                            style: TextStyles.extraSmallBoldTextStyle()
                                .copyWith(color: Colors.white),
                          )
                        ]),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    dataTitle,
                    style: TextStyles.customText(10.sp, FontWeight.normal)
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  if (secondWidgt != null && !isGauge) secondWidgt!,
                  if (isGauge)
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 100,
                            ),
                            child: secondWidgt!),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(
                    image,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardTileMedAssist extends StatelessWidget {
  const DashboardTileMedAssist({
    Key? key,
    required this.onTap,
    required this.title,
    required this.color,
    required this.data,
    required this.dataTitle,
    required this.image,
    required this.unit,
    this.secondWidgt,
    this.isGauge = false,
  }) : super(key: key);
  final VoidCallback onTap;
  final bool isGauge;
  final Widget? secondWidgt;
  final String title;
  final Color color;
  final String data;
  final String unit;
  final String dataTitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 4, left: 2, right: 2, bottom: 2),
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.extraSmallBoldTextStyle()
                        .copyWith(color: Colors.white),
                  ),
                  const Divider(
                    thickness: 1,
                    color: ColorResources.colorWhite,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/ic_night.png',
                        height: 15,
                        width: 15,
                      ),
                      const SizedBox(width: 8),
                      RichText(
                        text: TextSpan(
                            text: data,
                            style: TextStyles.smallTextBoldStyle()
                                .copyWith(color: Colors.white),
                            children: [
                              TextSpan(
                                text: " $unit",
                                style: TextStyles.extraSmallTextStyle()
                                    .copyWith(color: Colors.white),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Expanded(
                    child: BottomTitledGauge(
                        percentageValue: "0", bottomTitle: "Adherence Score"),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.asset(
                      image,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomTitledGauge extends StatelessWidget {
  const BottomTitledGauge({
    Key? key,
    required this.percentageValue,
    required this.bottomTitle,
  }) : super(key: key);

  final String percentageValue;
  final String bottomTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: LayoutBuilder(builder: (context, constrains) {
            return SizedBox.square(
              dimension: 100,
              //dimension: constrains.maxHeight,
              child: SfRadialGauge(
                enableLoadingAnimation: true,
                animationDuration: 800,
                axes: [
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    showLabels: false,
                    showTicks: false,
                    startAngle: 270,
                    endAngle: 270,
                    axisLineStyle: const AxisLineStyle(
                      thickness: 1,
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: double.parse(percentageValue),
                        width: 0.15,
                        color: Colors.white54,
                        pointerOffset: 0.1,
                        cornerStyle: CornerStyle.bothCurve,
                        sizeUnit: GaugeSizeUnit.factor,
                      )
                    ],
                    canScaleToFit: true,
                    showAxisLine: true,
                    annotations: [
                      GaugeAnnotation(
                        positionFactor: 0.5,
                        widget: Text(
                          "$percentageValue%",
                          style: TextStyles.extraSmallTextStyle()
                              .copyWith(color: Colors.white54),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 4),
        Text(
          bottomTitle,
          style: TextStyles.extraSmallBoldTextStyle()
              .copyWith(color: Colors.white),
        ),
      ],
    );
  }
}

class SingleDataSpanDB extends StatelessWidget {
  const SingleDataSpanDB({
    Key? key,
    required this.data,
    required this.title,
    required this.unit,
  }) : super(key: key);
  final String data;
  final String unit;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: data,
              style:
                  TextStyles.smallTextBoldStyle().copyWith(color: Colors.white),
              children: [
                TextSpan(
                  text: " $unit",
                  style: TextStyles.extraSmallTextStyle()
                      .copyWith(color: Colors.white),
                ),
              ]),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyles.extraSmallTextStyle().copyWith(color: Colors.white),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class PhysicalActiviyWidget extends DashboardTileWidget {
  const PhysicalActiviyWidget(
      {Key? key,
      required VoidCallback onTap,
      required String title,
      required String data,
      required String dataTitle,
      required String unit,
      required Widget secondWidget})
      : super(
          key: key,
          onTap: onTap,
          title: title,
          color: Colors.blue,
          data: data,
          dataTitle: dataTitle,
          image: "assets/images/illustration_physical_activity.webp",
          unit: unit,
          secondWidgt: secondWidget,
          isGauge: true,
        );
}

String iOSDescription =
    "We would ask for the following permissions while using respective freatures in the app to give your a better experience.\n\nLocation permission is required for our WeHealth app to get BLE scan result.\n\nMedical devices (e.g. blood glucose meters) can be paired with your mobile device which enables data to be transferred to our WeHealth apps.\n\nIt is mendatory for our WeHealth app to have location permissions in order to work with Bluetooth devices.\n\nGo to settings\n>Find the app (WeHealth) & press on\n>Then press on location & select Always";
