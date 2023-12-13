import 'dart:developer';
import 'package:get/get.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/models/data_model/lab_report_fetch_wrapper.dart';
import 'package:wehealth/models/data_model/medical_report_fetch_wrapper.dart';

import 'medical_report_repository.dart';

class MedicalReportController extends GetxController {
  final MedicalReportRepository _repository =
      MedicalReportRepository(storageController: Get.find<StorageController>());
  LabReportFetchWrapper _labReportWrapper = LabReportFetchWrapper();
  MedicalReportFetchWrapper _medicalReportWrapper = MedicalReportFetchWrapper();
  List<LabReportData> get labReports => _labReportWrapper.reportList ?? [];
  List<MedicalReportData> get medicalReports =>  _medicalReportWrapper.reportList ?? [];

  fetchLabReports() async {
    try {
      LabReportFetchWrapper? response = await _repository.getLabReportData();
      if (response != null && response.reportList != null) {
        _labReportWrapper = response;
      }
      update();
    } catch (error) {
      log("Error while updating fetchLabReports => $error");
    }
  }

  fetchMedicalReports() async {
    try {
      MedicalReportFetchWrapper? response =
          await _repository.getMedicalReportData();
      if (response != null && response.reportList != null) {
        _medicalReportWrapper = response;
      }
      update();
    } catch (error) {
      log("Error while updating fetchMedicalReports => $error");
    }
  }

/*   addUserHeartRate(int? data, int heartRateType, String time) async {
    if (data == null) {
      showToast("Invalid Heart Rate Value!", Get.context);
      return;
    }
    final dataClass = HeartRateRequestModel(
      heartRateQty: data,
      recordDateTime: time,
      deviceStatus: 0,
      heartRateType: heartRateType,
      deviceuuid: "manual",
      deviceid: "manual",
      heartRateID: 5326187,
      userID: _repository.storageController.userId,
    );
    try {
      bool response =
          await _repository.postHeartRateData(requestData: dataClass);
      if (response) {
        showToast("Heart Rate Data added!", Get.context);
        Get.back();
        fetchUserHeartRate();
      } else {
        showToast("ERROR!", Get.context);
      }
    } catch (error) {
      log("Error while updating fetchUserHeartRate => $error");
    }
  } */
}
