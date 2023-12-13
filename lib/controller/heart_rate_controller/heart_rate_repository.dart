import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/models/data_model/fetch_heart_rate_model.dart';

import '../../http_cleint/api_clients.dart';
import '../../http_cleint/app_config.dart';

@immutable
class HeartRateRepository {
  const HeartRateRepository({
    required this.storageController,
  });

  final String baseUrl = AppConfig.baseUrl;
  final StorageController storageController;

  String get _userToken => storageController.userToken;
  int get _userId => storageController.userId;

  Future<HeartRateFetchWrapper?> getHeartRateData() async {
    String url = "$baseUrl/getheartrate?token=$_userToken&userid=$_userId";

    try {
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {
        log("Fetch Successful");
        HeartRateFetchWrapper wrapper =
            HeartRateFetchWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getHeartRateData Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getHeartRateData ${error.toString()}");
      return null;
    }
  }

  Future<bool> postHeartRateData(
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
  }

/*   Future<UserMedicineDataWrapper?> getUserMedicineData() async {
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
  } */
}

class HeartRateRequestModel {
  int? heartRateID;
  int? userID;
  int? heartRateQty;
  String? recordDateTime;
  int? deviceStatus;
  int? heartRateType;
  String? deviceuuid;
  String? deviceid;

  HeartRateRequestModel(
      {this.heartRateID,
      this.userID,
      this.heartRateQty,
      this.recordDateTime,
      this.deviceStatus,
      this.heartRateType,
      this.deviceuuid,
      this.deviceid});

  HeartRateRequestModel.fromJson(Map<String, dynamic> json) {
    heartRateID = json['heartRateID'];
    userID = json['userID'];
    heartRateQty = json['heartRateQty'];
    recordDateTime = json['recordDateTime'];
    deviceStatus = json['deviceStatus'];
    heartRateType = json['heartRateType'];
    deviceuuid = json['deviceuuid'];
    deviceid = json['deviceid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['heartRateID'] = heartRateID;
    map['userID'] = userID;
    map['heartRateQty'] = heartRateQty;
    map['recordDateTime'] = recordDateTime;
    map['deviceStatus'] = deviceStatus;
    map['heartRateType'] = heartRateType;
    map['deviceuuid'] = deviceuuid;
    map['deviceid'] = deviceid;
    return map;
  }
}
