import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/models/data_model/lab_report_fetch_wrapper.dart';
import 'package:wehealth/models/data_model/medical_report_fetch_wrapper.dart';

import '../../http_cleint/api_clients.dart';
import '../../http_cleint/app_config.dart';

@immutable
class MedicalReportRepository {
  const MedicalReportRepository({
    required this.storageController,
  });

  final String baseUrl = AppConfig.baseUrl;
  final StorageController storageController;

  String get _userToken => storageController.userToken;
  int get _userId => storageController.userId;

  Future<LabReportFetchWrapper?> getLabReportData() async {
    String url = "$baseUrl/GetLabReport?token=$_userToken&userid=$_userId";

    try {
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {
        log("Fetch Successful");
        LabReportFetchWrapper wrapper =
            LabReportFetchWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getLabReportData Status => ${response['error']}!");
        return null;
      }
    } catch (error, s) {
      log(
        "Error While fetching getLabReportData ${error.toString()}",
        stackTrace: s,
      );
      return null;
    }
  }

  Future<MedicalReportFetchWrapper?> getMedicalReportData() async {
    String url = "$baseUrl/Getmedicalreport?token=$_userToken&userid=$_userId";

    try {
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {
        log("Fetch Successful");
        MedicalReportFetchWrapper wrapper =
            MedicalReportFetchWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getMedicalReportData Status => ${response['error']}!");
        return null;
      }
    } catch (error, s) {
      log(
        "Error While fetching getMedicalReportData ${error.toString()}",
        stackTrace: s,
      );
      return null;
    }
  }

/*   Future<bool> postHeartRateData(
      {required HeartRateRequestModel requestData}) async {
    String url = "$baseUrl/addheartrate";
    final param = {
      'userid': _userId,
      'token': _userToken,
      'data': json.encode([requestData.toJson()]),
    };
    try {
      log(param.toString());
      var response = await ApiClients.postFormUrlEncodedData(param, url);
      if (response['error'] == 0) {
        return true;
      } else {
        log("postHeartRateData Status => ${response['error']}!");
        return false;
      }
    } catch (error) {
      log("Error While fetching postHeartRateData ${error.toString()}");
      return false;
    }
  } */
}
