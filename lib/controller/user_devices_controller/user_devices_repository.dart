import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/models/data_model/add_user_device_data_model.dart';
import 'package:wehealth/models/data_model/user_devices_model.dart';

import '../../http_cleint/api_clients.dart';
import '../../http_cleint/app_config.dart';

@immutable
class UserDevicesRepository {
  const UserDevicesRepository({
    required this.storageController,
  });

  final String baseUrl = AppConfig.baseUrl;
  final String seconderyBaseUrl = AppConfig.seconderyBaseUrl;
  final StorageController storageController;

  int get _userId => storageController.userId;
  String get _userToken => storageController.userToken;
  String get email => storageController.email;
  String get password => storageController.password;

  Future<UserDevicesWrapper?> getUserDevices() async {
    String url =
        "$baseUrl/getUserDeviceParameters?token=$_userToken&userid=$_userId";
    try {
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {
        log("Fetch Successful");
        UserDevicesWrapper wrapper = UserDevicesWrapper.fromJson(response);
        return wrapper;
      } else {
        log("GetUserDevices Status => ${response['error']}!");
        return null;
      }
    } catch (error, s) {
      log(
        "Error While fetching GetUserDevices ${error.toString()}",
        stackTrace: s,
      );
      return null;
    }
  }

  Future<bool?> deleteUserDevice(UserDeviceModel device) async {
    String url = "$baseUrl/deleteUserDeviceParameters";
    final data = {
      "userid": _userId,
      "token": _userToken,
      "data": json.encode([device.toJson()]),
    };

    try {
      var response = await ApiClients.postFormUrlEncodedData(data, url);
      log(response.toString());
      if (response['error'] == 0) {
        log("Post Successful");
        return true;
      } else {
        log("deleteUserDevice Status => ${response['error']}!");
        return null;
      }
    } catch (error, s) {
      log(
        "Error While fetching deleteUserDevice ${error.toString()}",
        stackTrace: s,
      );
      return null;
    }
  }

  Future<bool?> addUserDevice(AddUserDeviceDataModel device) async {
    String url = "$baseUrl/addUserDeviceParameters";
    final data = {
      "userid": _userId,
      "token": _userToken,
      "data": json.encode([device.toJson()]),
    };

    try {
      var response = await ApiClients.postFormUrlEncodedData(data, url);
      log(response.toString());
      if (response['error'] == 0) {
        log("Post Successful");
        return true;
      } else {
        log("addUserDevice Status => ${response['error']}!");
        return null;
      }
    } catch (error, s) {
      log(
        "Error While fetching addUserDevice ${error.toString()}",
        stackTrace: s,
      );
      return null;
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
