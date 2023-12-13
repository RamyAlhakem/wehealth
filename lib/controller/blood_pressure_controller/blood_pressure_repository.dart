import 'dart:convert';
import 'dart:developer' show log;
import 'package:flutter/foundation.dart' show immutable;
// import 'package:get/get.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/http_cleint/api_clients.dart';
import 'package:wehealth/models/data_model/user_bp_model.dart';
import '../../http_cleint/app_config.dart';

@immutable
class BloodPressureRepository {
  const BloodPressureRepository({
    required this.storage,
  });
  final String baseUrl = AppConfig.baseUrl;
  final StorageController storage;
  int get userId => storage.userId;
  String get userToken => storage.userToken;
  String get userEmail => storage.email;
  String get userPassword => storage.password;

  Future<FetchBloodPressureDataWrapper?> getBloodPressureData() async {
    String url =
        "$baseUrl/retrieveBloodPressureData?token=$userToken&userid=$userId";
    try {
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {
        log("getBloodPressureData Fetch Successful");
        FetchBloodPressureDataWrapper wrapper =
            FetchBloodPressureDataWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getBloodPressureData Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getBloodPressureData ${error.toString()}");
      return null;
    }
  }

  Future<bool> postBloodPressureData(UploadBloodPressureClass data) async {
    String url = "$baseUrl/addbp";
    final param = {
      "userid": userId,
      "token": userToken,
      "data": json.encode([data.toJson()]),
    };

    try {
      var response = await ApiClients.postFormUrlEncodedData(param, url);
      log(response.toString());
      if (response['error'] == 0) {
        return true;
      } else {
        log("postBloodPressureData Status => ${response['error']}!");
        return false;
      }
    } catch (error) {
      log("Error While fetching postBloodPressureData ${error.toString()}");
      return false;
    }
  }
}

/* [{"glucose_level":"9.60","id":"13222","meal_type":"BeforeMeal","notes":"Test update testt","record_datetime":"2022-03-09 16:42:07"}] */
