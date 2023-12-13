import 'dart:developer';
import 'package:get/get.dart';
import 'package:wehealth/controller/med_assist_controller/med_assist_repository.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/models/data_model/medicine_data_posting_model.dart';
import 'package:wehealth/models/data_model/medicine_data_wrapper.dart';
import 'package:wehealth/models/data_model/medicine_status_model.dart';
import 'package:wehealth/models/data_model/user_medication_task_wrapper.dart';
import 'package:wehealth/models/data_model/user_medicine_data_wrapper.dart';

class MedAssistController extends GetxController {
  final _repository =
      MedAssistRepository(storage: Get.find<StorageController>());

  MedicineDataWrapper _medicineDataWrapper = MedicineDataWrapper();
  UserMedicineStatusWrapper _medicineStatusWrapper =
      UserMedicineStatusWrapper();
  UserMedicineDataWrapper _userMedicineDataWrapper = UserMedicineDataWrapper();
  UserMedicationTaskWrapper _userMedicationTaskWrapper =
      UserMedicationTaskWrapper();

  List<MedicineData>? get listOfAllMedicine =>
      _medicineDataWrapper.medicineList;
  List<MedicineStatusModel>? get userMedicineStatus =>
      _medicineStatusWrapper.medicineStatusData;
  List<UserMedicineData>? get myMedicineList =>
      _userMedicineDataWrapper.userMedicineList;
  List<UserMedicationTaskModel> get userMedicineTask =>
      _userMedicationTaskWrapper.medicationList ?? [];

  List<UserMedicationTaskModel> userMedicineTaskByDay(String dayCode) =>
      userMedicineTask
          .where(
            (element) =>
                element.days!.split(",").contains(dayCode) &&
                element.formattedEndDate.isAfter(
                  DateTime.now(),
                ),
          )
          .toList();

  fetchMedicineData() async {
    try {
      MedicineDataWrapper? response = await _repository.getAllMedicineData();
      if (response != null && response.medicineList != null) {
        _medicineDataWrapper = response;
        log(_medicineDataWrapper.medicineList![0].toJson().toString());
      }
      update();
    } catch (error) {
      log("Error While fetching fetchMedicineData ${error.toString()}");
    }
  }

  fetchMedicationTaskWrapper() async {
    try {
      UserMedicationTaskWrapper? response =
          await _repository.getUserMedicationTask();
      if (response != null && response.medicationList != null) {
        _userMedicationTaskWrapper = response;
      }
      update();
    } catch (error) {
      log("Error While fetching fetchMedicineData ${error.toString()}");
    }
  }

  List<MedicineData> getMatchedMedicinesNameList(String text) {
    update();
    return listOfAllMedicine!
        .where((element) =>
            element.medicineName
                ?.toLowerCase()
                .isCaseInsensitiveContainsAny(text) ??
            false)
        .toList()
        .map((sortedMedicine) => sortedMedicine)
        .toList();
  }

  fetchMedicineStatusData() async {
    try {
      UserMedicineStatusWrapper? response =
          await _repository.getUserMedicineStatus();
      if (response != null && response.medicineStatusData != null) {
        _medicineStatusWrapper = response;
      }
      update();
    } catch (error) {
      log("Error While fetching fetchMedicineStatusData ${error.toString()}");
    }
  }

  fetchUsersMedicineData() async {
    try {
      UserMedicineDataWrapper? response =
          await _repository.getUserMedicineData();
      if (response != null && response.userMedicineList != null) {
        _userMedicineDataWrapper = response;
      }
      update();
    } catch (error) {
      log("Error While fetching fetchUsersMedicineData ${error.toString()}");
    }
  }

  Future<bool?> uploadUsersMedicineData(MedicineDataPostingModel data) async {
    /*     
    final dateformat = DateFormat('yyyy-MM-d hh:mm:ss');
    data.deviceID = _repository.storage.deviceInfo?.id;
    data.id = 0;
    data.insertDateTime = dateformat.format(DateTime.now());
    data.insertionDate = dateformat.format(DateTime.now());
    data.isUploadedToWeb = 0;
    data.isvibration = false;
    data.reminderType = 1;
    data.serverId = 0;
    data.tune = 'default';
    data.userID = _repository.userId; 
    */
    try {
      bool? response = await _repository.updateMedicineData(data);
      update();
      fetchUsersMedicineData();
      return response;
    } catch (error) {
      log("Error While fetching fetchUsersMedicineData ${error.toString()}");
      return null;
    }
  }

  Future<bool?> updateMedAdhereStatus(MedicineStatusModel data) async {
    data.id = 0;

    data.userID = _repository.userId;
    try {
      bool? response = await _repository.updateMedAdhereStatus(data);
      update();
      fetchUsersMedicineData();
      fetchMedicineStatusData();
      
      return response;
    } catch (error) {
      log("Error While fetching fetchUsersMedicineData ${error.toString()}");
      return null;
    }
  }
}
