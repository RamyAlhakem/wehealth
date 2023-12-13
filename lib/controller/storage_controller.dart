// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageController extends GetxController {
  StorageController._();

  static final StorageController _shared = StorageController._();
  factory StorageController.initialize({
    SharedPreferences? pref,
    bool enableLog = false,
    required AndroidDeviceInfo? deviceInfo,
  }) =>
      _shared
        ..prefs = pref!
        .._isInitialized = true
        ..isLog = enableLog
        ..deviceInfo = deviceInfo;
  factory StorageController.instance() {
    assert(
      _shared._isInitialized == true,
      "⚠️ Please initialize the controller first",
    );
    return _shared;
  }

  late SharedPreferences? prefs;
  bool? _isInitialized;
  bool isLog = false;
  late AndroidDeviceInfo? deviceInfo;
  StorageController({
    this.prefs,
    this.deviceInfo,
    bool enableLog = false,
  }) : isLog = enableLog;

  String get email => prefs?.getString("email") ?? "";
  void updateEmail(String email) {
    prefs?.setString("email", email);
    update();
  }

  String get password => prefs?.getString("password") ?? "";
  void updatepassword(String password) {
    prefs?.setString("password", password);
    update();
  }

  bool _rememberMe = true;
  bool get rememberMe => _rememberMe;
  void updateRememberMe(bool rememberMe) {
    _rememberMe = rememberMe;
    prefs?.setBool("rememberMe", rememberMe);
    update();
  }

  bool get permissionsAccepted => prefs?.getBool("permissions") ?? false;
  void updatePermissionStatus(bool permission) {
    prefs?.setBool("permissions", permission);
    update();
  }

  String get userToken => prefs?.getString('user_token') ?? "";

  int get userId => prefs?.getInt('user_id') ?? 0;

  String get profileImgPath => prefs?.getString("profile_img") ?? "";
  setProfileImgPath(String path) {
    prefs?.setString("profile_img", path);
    update();
  }

  // int _waterMl = 0;

  static const waterIntakeKey = "WATER_INTAKE";
  List<SingleWaterWaterIntakeData> get getWaterIntakeHistory =>
      (prefs?.getStringList(waterIntakeKey) ?? [])
          .map((json) => SingleWaterWaterIntakeData.fromJson(json))
          .toList();

  addWaterIntakeHistory(SingleWaterWaterIntakeData history) {
    prefs!.setStringList(
      waterIntakeKey,
      [history.toJson(), ...getWaterIntakeHistory.map((e) => e.toJson())],
    );
    update();
  }

  Map<String, dynamic>? checkAndGetData(String key) {
    if (prefs!.containsKey(key)) {
      final stringData = prefs?.getString(key);
      if (isLog) log('📂 Getting data "#$key" => $stringData');
      return json.decode(stringData!);
    }
    return null;
  }

  Future<bool> save(String key, Map<String, dynamic> data) async {
    if (isLog) log('📂 Saving "#$key" => ${data.toString()}');
    return await prefs!.setString(key, json.encode(data));
  }
}

class SingleWaterWaterIntakeData {
  final DateTime date;
  final double waterLevel;

  const SingleWaterWaterIntakeData({
    required this.date,
    required this.waterLevel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'waterLevel': waterLevel,
    };
  }

  factory SingleWaterWaterIntakeData.fromMap(Map<String, dynamic> map) {
    return SingleWaterWaterIntakeData(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      waterLevel: map['waterLevel'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleWaterWaterIntakeData.fromJson(String source) =>
      SingleWaterWaterIntakeData.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
