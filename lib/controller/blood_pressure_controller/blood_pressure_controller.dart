// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/blood_pressure_controller/blood_pressure_repository.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/methods/methods.dart';
import 'package:wehealth/models/data_model/user_bp_model.dart';

class BloodPressureController extends GetxController {
  final BloodPressureRepository _repository =
      BloodPressureRepository(storage: StorageController.instance());

/*   FetchBloodPressureDataWrapper _bloodPressureData =
      FetchBloodPressureDataWrapper();
  List<BPData>? get userBloodPressureData => _bloodPressureData.bpData; */

  List<BPData> getBpDataByDay(int dayCount) {
    // if (userBloodPressureData == null) return [];
    // currentSortedList.bpData
    //     ?.take(100)
    //     .toList()
    //     .sort((a, b) => a.recordDate.compareTo(b.recordDate));
    final data = currentSortedList
        .where(
          (element) => element.recordDate.isAfter(
            DateTime.now().subtract(
              Duration(days: dayCount),
            ),
          ),
        )
        .toList();
    return data;
  }

  List<BPData> currentSortedList = [];

/*   Future<void> dateSortBpData() async {
    final value = await compute<List<BPData>, List<BPData>>(
      sortBpDataByDate,
      (currentSortedList),
    );
    currentSortedList = value;
    update();
  } */

  fetchUserBloodPressureHistory() async {
    try {
      FetchBloodPressureDataWrapper? response =
          await _repository.getBloodPressureData();
      if (response != null && response.bpData != null) {
        // _bloodPressureData = response;
        currentSortedList = await compute<List<BPData>, List<BPData>>(
          sortBpDataByDate,
          (response.bpData!),
        );
        update();
      }
    } catch (error) {
      log("Error while updating getUserDevices => $error");
    }
  }

  Future addBpData({
    required BuildContext context,
    required int systolic,
    required int diastolic,
    required int pulse,
    required DateTime recordTime,
    required String notes,
  }) async {
    final UploadBloodPressureClass data = UploadBloodPressureClass(
      bpID: 6934962,
      deviceType: 37,
      deviceid: "manual",
      deviceuuid: _repository.storage.deviceInfo?.id,
      diastolic: diastolic,
      email: _repository.userEmail,
      isSection: false,
      isuploadedtoweb: 0,
      notes: notes,
      pulserate: pulse,
      recordTime: recordTime.toIso8601String(),
      recorddate: recordTime.toIso8601String(),
      serverid: 0,
      systolic: systolic,
      userid: _repository.userId,
    );
    try {
      bool response = await _repository.postBloodPressureData(data);
      if (response) {
        showToast("Blood Pressure data uploaded!", context);
        Get.back();
        fetchUserBloodPressureHistory();
      }
      update();
    } catch (error) {
      log("Error while addBpData => $error");
    }
  }
}

FutureOr<List<BPData>> sortBpDataByDate(List<BPData> list) async {
  list.sort(
    (a, b) => a.recordDate.compareTo(b.recordDate),
  );
  return list;
}
