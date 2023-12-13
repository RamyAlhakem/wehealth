import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/models/data_model/blood_glucose_data_fetch_wrapper.dart';
import 'package:wehealth/models/data_model/blood_glucose_data_upload_model.dart';
import 'package:wehealth/models/data_model/update_glucode_level_model.dart';
import '../../http_cleint/api_clients.dart';
import '../../http_cleint/app_config.dart';

@immutable
class BloodGlucoseRepository {
  const BloodGlucoseRepository({
    required this.storageController,
  });

  final String baseUrl = AppConfig.baseUrl;
  final StorageController storageController;

  String get _userToken => storageController.userToken;
  int get _userId => storageController.userId;

  Future<BloodGlucoseDataFetchWrapper?> getBloodGlucoseData() async {
    String url = "$baseUrl/retrieveBloodGlucoseLevel?token=$_userToken&userid=$_userId";
    try {
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {
        log("Fetch Successful");
        BloodGlucoseDataFetchWrapper wrapper =
            BloodGlucoseDataFetchWrapper.fromJson(response);
        log("length => ${wrapper.dataList?.length}");
        return wrapper;
      } else {
        log("getBloodGlucoseData Status => ${response['error']}!");
        return null;
      }
    } catch (error, s) {
      log("Error While fetching getBloodGlucoseData ${error.toString()}",
          stackTrace: s);
      return null;
    }
  }

  Future<bool> postBloodGlucoseData(
      {required BloodGlucoseDataUploadModel data}) async {
    String url = "$baseUrl/insertBloodGlucoseLevel";
    final param = {
      "userid": _userId,
      "token": _userToken,
      "data": json.encode([data.toJson()]),
    };
    try {
      // var response = await ApiClients.postFormUrlEncodedData(param, url);
      log("Post $param");
      // return response['error'] == 0;
      return false;
    } catch (error, s) {
      log("Error While fetching getBloodGlucoseData ${error.toString()}",
          stackTrace: s);
      return false;
    }
  }

  Future<bool> updateBloodGlucoseData(
      {required UpdateGlucoseLevel data}) async {
    String url = "$baseUrl/UpdateGlucoseLevel";
    final param = {
      "userid": _userId,
      "token": _userToken,
      "data": json.encode([data.toJson()]),
    };
    try {
      var response = await ApiClients.putJson(param, url);
      log("Post Successful");
      return response['error'] == 0;
    } catch (error, s) {
      log("Error While Updating updateBloodGlucoseData ${error.toString()}",
          stackTrace: s);
      return false;
    }
  }

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
  }

  /*
    Future<UserMedicineDataWrapper?> getUserMedicineData() async {
      String url = "$baseUrl/GetMyMedicine?token=$_userToken&userid=$_userId";

      try {
        var response = await ApiClients.getJson(url);
        if (response['error'] == 0) {
          log("Fetch Successful");
          UserMedicineDataWrapper wrapper =
              UserMedicineDataWrapper.fromJson(response);
          return wrapper;
        } else {
          log("GetUserMedicineData Status => ${response['error']}!");
          return null;
        }
      } catch (error) {
        log("Error While fetching GetUserMedicineData ${error.toString()}");
        return null;
      }
    }

    Future<UserMedicineStatusWrapper?> getUserMedicineStatusData() async {
      String url = "$baseUrl/GetMedicineStatus?token=$_userToken&userid=$_userId";

      try {
        var response = await ApiClients.getJson(url);
        if (response['error'] == 0) {
          log("Fetch Successful");
          UserMedicineStatusWrapper wrapper =
              UserMedicineStatusWrapper.fromJson(response);
          return wrapper;
        } else {
          log("GetUserMedicineStatusData Status => ${response['error']}!");
          return null;
        }
      } catch (error) {
        log("Error While fetching GetUserMedicineStatusData ${error.toString()}");
        return null;
      }
    }

    getBookedAppts({DateTime? d, int? professionalId}) async {
      String url = "$baseUrl/getBookedAppointment?token=$_userToken";
      if (d != null) {
        String stringDate = DateFormat("yyyy-M-dd").format(d);
        String inputData = "&appointmentDate=$stringDate";
        url += inputData;
      }
      if (professionalId != null) {
        String inputData = "&professionalID=$professionalId";
        url += inputData;
      }

      try {
        var response = await ApiClients.getJson(url);
        if (response['error'] == 0) {
          log("Fetch Successful");
        } else {
          log("BookedAppt Status => ${response['error']}!");
        }
      } catch (error) {
        log("Error While fetching BookedAppt ${error.toString()}");
      }
    }
  */
}
