import 'dart:developer';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';

class GoogleFitController extends GetxController {

  double dailyHeartRate=0.0;
  double dailyDistance=0.0;
  double dailySteps=0.0;
  double dailyActiveEnergy=0.0;

  double monthlySteps=0.0;
  double monthlyDistance=0.0;
  double monthlyHeartRate=0.0;
  double monthlyActiveEnergy=0.0;

  List<HealthDataPoint> healthData = [];

  HealthFactory health = HealthFactory();

  final _dataTypeList = [
    Platform.isIOS
      ? HealthDataType.DISTANCE_WALKING_RUNNING
      : HealthDataType.DISTANCE_DELTA,
    HealthDataType.HEART_RATE,
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
  ];

  final _accesList = [
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
  ];


  HealthDataPoint? lastSleepData;

  final String stepTarget = "1000";

  Future<bool> requestNeededPermissions() async {
    return health.requestAuthorization(_dataTypeList, permissions: _accesList);
  }

  Future<bool?> checkPermissionSetting() async =>
    await HealthFactory.hasPermissions(_dataTypeList,
        permissions: _accesList);

  // *Steps portion* //
  Future getGoogleFitDailyData() async {
    dailyActiveEnergy = 0;
    dailyDistance = 0;
    dailyHeartRate = 0;
    dailySteps = 0;

    try {
        final currentDT = DateTime.now();
        final startOfDay = DateTime(
          currentDT.year,
          currentDT.month,
          currentDT.day,
        );

        healthData = await health.getHealthDataFromTypes(
          startOfDay,
          currentDT,
          _dataTypeList,
        );

        if (healthData.isNotEmpty) {
          for (HealthDataPoint _healthData in healthData) {
            log(_healthData.type.name);
            final data = (double.tryParse(_healthData.value.toString()) ?? 0.0);
            if (_healthData.type == HealthDataType.STEPS) {
              dailySteps = dailySteps + data;
            } else if (_healthData.type ==
                    HealthDataType.DISTANCE_WALKING_RUNNING ||
                _healthData.type == HealthDataType.DISTANCE_DELTA) {
              dailyDistance = dailyDistance + data;
            } else if (_healthData.type == HealthDataType.HEART_RATE) {
              dailyHeartRate = dailyHeartRate + data;
            } else if (_healthData.type ==
                HealthDataType.ACTIVE_ENERGY_BURNED) {
              dailyActiveEnergy = dailyActiveEnergy + data;
            }
          }
          update();
        }
      } catch (error, stack) {
        log("#HealthDataFetchError *Daily*", error: error, stackTrace: stack);
      }

  
  }


Future fetchMonthlyData() async {
    final dependingDataType = Platform.isIOS
        ? HealthDataType.DISTANCE_WALKING_RUNNING
        : HealthDataType.DISTANCE_DELTA;

    final types = [
      dependingDataType,
      HealthDataType.HEART_RATE,
      HealthDataType.STEPS,
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ];

    if (await health.requestAuthorization(types)) {
      monthlyActiveEnergy = 0;
      monthlyDistance = 0;
      monthlyHeartRate = 0;
      monthlySteps = 0;

      try {
        final currentDT = DateTime.now();
        final startOfMonth = DateTime(currentDT.year, currentDT.month);
        healthData = await health.getHealthDataFromTypes(
          startOfMonth,
          currentDT,
          types,
        );

        if (healthData.isNotEmpty) {
          for (HealthDataPoint _healthData in healthData) {
            log(_healthData.type.name);
            final data = (double.tryParse(_healthData.value.toString()) ?? 0.0);
            if (_healthData.type == HealthDataType.STEPS) {
              monthlySteps = monthlySteps! + data;
            } else if (_healthData.type ==
                    HealthDataType.DISTANCE_WALKING_RUNNING ||
                _healthData.type == HealthDataType.DISTANCE_DELTA) {
              monthlyDistance = monthlyDistance! + data;
            } else if (_healthData.type == HealthDataType.HEART_RATE) {
              monthlyHeartRate = monthlyHeartRate! + data;
            } else if (_healthData.type ==
                HealthDataType.ACTIVE_ENERGY_BURNED) {
              monthlyActiveEnergy = monthlyActiveEnergy! + data;
            }
          }
          update();
        }
      } catch (error, stack) {
        log("#HealthDataFetchError *MONTHLY*", error: error, stackTrace: stack);
      }
    } else
      print("HealthData Authorization not granted!");
  }

  


  Future getSleepData() async {

    bool access = await health.requestAuthorization([HealthDataType.SLEEP_ASLEEP]);
    if (access) {


      healthData = await health.getHealthDataFromTypes(
        DateTime.now().subtract(const Duration(days: 1)), DateTime.now(),[HealthDataType.SLEEP_ASLEEP],
      );
      lastSleepData = healthData.lastOrNull;
      if (lastSleepData != null) {
        final res = lastSleepData!.value.toJson();
        log(res.toString());
        update();
      }
      update();
    }
  }
}
