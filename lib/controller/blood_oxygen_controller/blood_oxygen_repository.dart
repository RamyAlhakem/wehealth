import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/models/data_model/blood_oxygen_data_fetch_wrapper.dart';

import '../../http_cleint/api_clients.dart';
import '../../http_cleint/app_config.dart';
import '../../models/data_model/blood_oxygen_data_upload_model.dart';

@immutable
class BloodOxygenRepository {
  const BloodOxygenRepository({
    required this.storageController,
  });

  final String baseUrl = AppConfig.baseUrl;
  final String seconderyBaseUrl = AppConfig.seconderyBaseUrl;
  final StorageController storageController;

  String get _userToken => storageController.userToken;
  int get _userId => storageController.userId;

  Future<BloodOxygenWrapper?> getBloodOxygenData() async {
    String url =
        "$baseUrl/retrieveBloodOxygenData?token=$_userToken&userid=$_userId";
    try {
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {
        log("Fetch Successful");
        BloodOxygenWrapper wrapper = BloodOxygenWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getBloodOxygenData Status => ${response['error']}!");
        return null;
      }
    } catch (error, s) {
      log(
        "Error While fetching getBloodOxygenData ${error.toString()}",
        stackTrace: s,
      );
      return null;
    }
  }

  Future<bool> postBloodOxygenData(
      {required BloodOxygenDataUploadModel data}) async {
    String url = "$baseUrl/insertBloodGlucoseLevel";
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
      log(
        "Error While fetching getBloodOxygenData ${error.toString()}",
        stackTrace: s,
      );
      return false;
    }
  }
}
