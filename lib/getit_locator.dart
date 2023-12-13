import 'package:device_info_plus/device_info_plus.dart';
import 'package:wehealth/controller/appt_controller/appt_controller.dart';
import 'package:wehealth/controller/auth_controller/auth_controller.dart';
import 'package:wehealth/controller/blood_glucose_controller/blood_glucose_controller.dart';
import 'package:wehealth/controller/blood_oxygen_controller/blood_oxygen_controller.dart';
import 'package:wehealth/controller/blood_pressure_controller/blood_pressure_controller.dart';
import 'package:wehealth/controller/body_measurement_controller/body_measurement_controller.dart';
import 'package:wehealth/controller/body_temp_controller/body_temp_controller.dart';
import 'package:wehealth/controller/dietary_controller/dietary_controller.dart';
import 'package:wehealth/controller/doctor_controller/doctor_controller.dart';
import 'package:wehealth/controller/medical_report_controller/medical_report_controller.dart';
import 'package:wehealth/controller/user_devices_controller/user_devices_controller.dart';
import 'package:wehealth/controller/home_tiles_controller/home_tiles_controller.dart';
import 'package:wehealth/controller/language_controller.dart';
import 'package:wehealth/controller/med_assist_controller/med_assist_controller.dart';
import 'package:wehealth/controller/msg_notification_controller/msg_notification_controller.dart';
import 'package:wehealth/controller/profile_controller/profile_controller.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/http_cleint/api_clients.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/heart_rate_controller/heart_rate_controller.dart';
import 'controller/localization_controller.dart';
import 'controller/notification_controller.dart';
import 'controller/theme_controller.dart';
import 'helper/translator_helper.dart';

Future init(SharedPreferences prefs, AndroidDeviceInfo? deviceInfo) async {
  await languageinit();
  Get.put(AuthController(prefs: prefs));  
  StorageController.initialize(pref: prefs, enableLog: true, deviceInfo: deviceInfo);
  ApiClients.updateHeader(prefs: prefs);
  Get.put(NotificationController(prefs: prefs));
    NotificationController(prefs: prefs);

  Get.lazyPut(() => ThemeController());
  Get.lazyPut(() => LocalizationController(prefs: prefs));
  Get.lazyPut(() => LanguageController(prefs: prefs));
  Get.lazyPut(() => StorageController(prefs: prefs, deviceInfo: deviceInfo, enableLog: true));
  Get.put<UserDevicesController>(UserDevicesController(), permanent: true);
  Get.put<MedAssistController>(MedAssistController(), permanent: true);
  Get.put<DoctorController>(DoctorController(), permanent: true);
  Get.put<BloodGlucoseController>(BloodGlucoseController(), permanent: true);
  Get.put<BloodPressureController>(BloodPressureController(), permanent: true);
  Get.put<HeartRateController>(HeartRateController(), permanent: true);
  Get.put<BodyTemperatureController>(BodyTemperatureController(),
      permanent: true);
  Get.put<BloodOxygenController>(BloodOxygenController(), permanent: true);
  Get.put<MedicalReportController>(MedicalReportController(), permanent: true);
  Get.put<BodyMeasurementController>(BodyMeasurementController(), permanent: true);
  Get.put<DietaryController>(DietaryController(), permanent: true);


  // Controllers
  // Get.put(ThemeController(prefs: prefs));
  final apptController = Get.put(ApptController());
  final authController = Get.put(AuthController(prefs: prefs));
  final profileController = Get.put(ProfileController(prefs: prefs));
  final bodyMeasureController = Get.put(BodyMeasurementController());

  final msgNotificationController = Get.put<MessageNotificationController>(
      MessageNotificationController(),
      permanent: true);
  //Initialize if user is logged in!
  if ((prefs.containsKey('user_token'))) {
    final tileController = Get.put(HomeTileController());
    // await authController.fetchGoogleUser();
    await profileController.getUserProfile();
    await msgNotificationController.fetchNotificationMessages();
    await tileController.getAndSetTilesData();

    await bodyMeasureController.fetchUserBodyWeightData();
    await bodyMeasureController.fetchUserBodyBmrData();
    await bodyMeasureController.fetchUserBodyFatData();
    await bodyMeasureController.fetchUserWaistHipRatioData();

    // await apptController.fetchApptSummary();
    // await apptController.fetchHospitalApptList();
    // await apptController.fetchUserApptList();
  }
}
