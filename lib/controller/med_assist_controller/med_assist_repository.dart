import 'dart:convert';
import 'dart:developer' show log;
import 'package:flutter/foundation.dart' show immutable;
import 'package:get/get.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/methods/methods.dart';
import 'package:wehealth/http_cleint/api_clients.dart';
import 'package:wehealth/models/data_model/medicine_data_posting_model.dart';
import 'package:wehealth/models/data_model/medicine_data_wrapper.dart';
import 'package:wehealth/models/data_model/medicine_status_model.dart';
import 'package:wehealth/models/data_model/user_medication_task_wrapper.dart';
import 'package:wehealth/models/data_model/user_medicine_data_wrapper.dart';

import '../../http_cleint/app_config.dart';

@immutable
class MedAssistRepository {
  const MedAssistRepository({
    required this.storage,
  });
  final String baseUrl = AppConfig.baseUrl;
  int get userId => storage.userId;
  String get userToken => storage.userToken;
  String get userEmail => storage.email;
  String get userPassword => storage.password;
  final StorageController storage;

  Future<MedicineDataWrapper?> getAllMedicineData() async {
    String url = "$baseUrl/GetMedicine?token=$userToken&userid=$userId";
    try {
      var response = await ApiClients.getJson(url);

      if (response['error'] == 0) {
        MedicineDataWrapper wrapper = MedicineDataWrapper.fromJson(response);
        return wrapper;
      } else {
        showToast((response['authResponse']).toString(), Get.context);
        log("getAllMedicineData Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getAllMedicineData ${error.toString()}");
      return null;
    }
  }

  Future<UserMedicineStatusWrapper?> getUserMedicineStatus() async {
    String url = "$baseUrl/GetMedicineStatus?token=$userToken&userid=$userId";
    try {
      var response = await ApiClients.getJson(url);

      if (response['error'] == 0) {
        UserMedicineStatusWrapper wrapper =
            UserMedicineStatusWrapper.fromJson(response);
        return wrapper;
      } else {
        showToast((response['authResponse']).toString(), Get.context);
        log("getUserMedicineStatus Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getUserMedicineStatus ${error.toString()}");
      return null;
    }
  }

  Future<UserMedicineDataWrapper?> getUserMedicineData() async {
    String url = "$baseUrl/GetMyMedicine?token=$userToken&userid=$userId";
    try {
      var response = await ApiClients.getJson(url);

      if (response['error'] == 0) {
        UserMedicineDataWrapper wrapper =
            UserMedicineDataWrapper.fromJson(response);
        return wrapper;
      } else {
        showToast((response['authResponse']).toString(), Get.context);
        log("getUserMedicineData Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getUserMedicineData ${error.toString()}");
      return null;
    }
  }

  Future<UserMedicationTaskWrapper?> getUserMedicationTask() async {
    String url = "$baseUrl/getTasksMedication?token=$userToken&userid=$userId";
    try {
      var response = await ApiClients.getJson(url);

      if (response['error'] == 0) {
        UserMedicationTaskWrapper wrapper =
            UserMedicationTaskWrapper.fromJson(response);
        return wrapper;
      } else {
        showToast((response['authResponse']).toString(), Get.context);
        log("getUserMedicineData Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getUserMedicineData ${error.toString()}");
      return null;
    }
  }

  Future<bool?> postMedicineData(MedicineDataPostingModel data) async {
    String url = "$baseUrl/addMyMedicine";
    final formData = {
      "userid": userId,
      "token": userToken,
      "data": json.encode([data.toJson()]),
    };
    log(formData.toString());
    try {
      var response = await ApiClients.postFormUrlEncodedData(formData, url);
      log("post MedicineData res => ${response.toString()}");
      if (response['error'] == 0) {
        showToast("Medicine Added Successfully", Get.context);
        return true;
      } else {
        log("postMedicineData Status => ${response['error']}!");
        return false;
      }
    } catch (error) {
      log("Error While fetching postMedicineData ${error.toString()}");
      return null;
    }
  }

  Future<bool?> updateMedicineData(MedicineDataPostingModel data) async {
    String url = "$baseUrl/UpdateMyMedicine";
    final formData = {
      "userid": userId,
      "token": userToken,
      "data": json.encode([data.toJson()]),
    };
    log(formData.toString());
    try {
      var response = await ApiClients.postFormUrlEncodedData(formData, url);
      log("post MedicineData res => ${response.toString()}");
      if (response['error'] == 0) {
        showToast("Medicine Updated Successfully", Get.context);
        return true;
      } else {
        log("postMedicineData Status => ${response['error']}!");
        return false;
      }
    } catch (error) {
      log("Error While fetching postMedicineData ${error.toString()}");
      return null;
    }
  }

  Future<bool?> updateMedAdhereStatus(MedicineStatusModel data) async {
    String url = "$baseUrl/${AppConfig.updateMedAdhereStatus}";
    final formData = {
      "userid": userId,
      "token": userToken,
      "data": json.encode([data.toJson()]),
    };
    log(formData.toString());
    try {
      var response = await ApiClients.postFormUrlEncodedData(formData, url);
      log("post updateMedAdhereStatus res => ${response.toString()}");
      if (response['error'] == 0) {
        showToast("Medicine Status Updated Successfully", Get.context);
        return true;
      } else {
        log("postupdateMedAdhereStatus Status => ${response['error']}!");
        return false;
      }
    } catch (error) {
      log("Error While fetching updateMedAdhereStatus ${error.toString()}");
      return null;
    }
  }
}
