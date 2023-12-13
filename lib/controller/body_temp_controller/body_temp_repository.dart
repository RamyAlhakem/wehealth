import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/models/data_model/body_temp_fetch_wrapper.dart';

import '../../http_cleint/api_clients.dart';
import '../../http_cleint/app_config.dart';

@immutable
class BodyTemperatureRepository {
  const BodyTemperatureRepository({
    required this.storageController,
  });

  final String baseUrl = AppConfig.baseUrl;
  final StorageController storageController;

  String get _userToken => storageController.userToken;
  int get _userId => storageController.userId;

  Future<BodyTempFetchWrapper?> getBodyTempData() async {
    String url = "$baseUrl/gettemprature?token=$_userToken&userid=$_userId";
    try {
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {
        BodyTempFetchWrapper wrapper = BodyTempFetchWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getBodyTempData Status => ${response['error']}!");
        return null;
      }
    } catch (error, s) {
      log(
        "Error While fetching getBodyTempData ${error.toString()}",
        stackTrace: s,
      );
      return null;
    }
  }

  Future<bool> postBodyTempData({required BodyTempUploadModel data}) async {
    String url = "$baseUrl/addtemprature";
    final param = {
      "userid": _userId,
      "token": _userToken,
      "data": json.encode([data.toJson()]),
    };
    try {
      var response = await ApiClients.postFormUrlEncodedData(param, url);
      return response['error'] == 0;
    } catch (error, s) {
      log(
        "Error While fetching getBloodGlucoseData ${error.toString()}",
        stackTrace: s,
      );
      return false;
    }
  }

/*
  Future<bool> deleteBloodGlucoseData({required data}) async {
    String url = "$baseUrl/DeleteGlucoseLevel";
    final param = {
      "userid": _userId,
      "token": _userToken,
      "data": json.encode([data.toJson()]),
    };
    try {
      var response = await ApiClients.postFormUrlEncodedData(param, url);
      log("Post Successful");
      return response['error'] == 0;
    } catch (error, s) {
      log("Error While fetching getBloodGlucoseData ${error.toString()}",
          stackTrace: s);
      return false;
    }
  } */
}
