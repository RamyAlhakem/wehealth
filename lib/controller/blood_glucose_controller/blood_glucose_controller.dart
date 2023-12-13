import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/blood_glucose_controller/blood_glucose_repository.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/methods/methods.dart';
import 'package:wehealth/models/data_model/blood_glucose_data_fetch_wrapper.dart';
import 'package:wehealth/models/data_model/blood_glucose_data_upload_model.dart';
import 'package:wehealth/models/data_model/update_glucode_level_model.dart';

class BloodGlucoseController extends GetxController {
  final BloodGlucoseRepository _repository =
      BloodGlucoseRepository(storageController: Get.find<StorageController>());

  BloodGlucoseDataFetchWrapper _dataFetchWrapper =
      BloodGlucoseDataFetchWrapper();

  List<BloodGlucoseData> getBloodGlucoseDataByType(String type) {
    if (_dataFetchWrapper.dataList == null) return [];
    final filteredList = _dataFetchWrapper.dataList!
        .where((element) => element.mealType == type)
        .toList();
    filteredList.sort(
      (a, b) => a.recordDate.compareTo(b.recordDate),
    );
    return filteredList;
  }

  List<BloodGlucoseData> getBloodGlucoseDataByDay(int dayCount) {
    if (_dataFetchWrapper.dataList == null) return [];
    _dataFetchWrapper.dataList!.sort(
      (a, b) => a.recordDate.compareTo(b.recordDate),
    );

    return _dataFetchWrapper.dataList!
        .where(
          (value) => value.recordDate.isAfter(
            DateTime.now().subtract(
              Duration(days: dayCount),
            ),
          ),
        )
        .toList();
  }

  Map<DateTime, List<BloodGlucoseData>> getTimelineFormat() {
    final data = _dataFetchWrapper.dataList!.groupListsBy<DateTime>(
      (element) => DateTime(
        element.recordDate.year,
        element.recordDate.month,
        element.recordDate.day,
      ),
    );
    return data;
  }



// =====> SERVER
  fetchUserBloodGlucoseData() async {
    try {
      BloodGlucoseDataFetchWrapper? response =
          await _repository.getBloodGlucoseData();
      if (response != null && response.dataList != null) {
        _dataFetchWrapper = response;
      }
      update();
    } catch (error) {
      log("Error while updating fetchUserBloodGlucoseData => $error");
    }
  }

  postUserBloodGlucoseData({
    required double glucoseLevel,
    required String mealType,
    required DateTime time,
    String? note,
  }) async {
  final dateformat = DateFormat("yyyy-MM-d HH:mm:s");
    final dataClass = BloodGlucoseDataUploadModel(
      id: 0,
      glucoseLevel: glucoseLevel,
      mealType: mealType,
      recordtime: dateformat.format(time),
      recordDatetime: dateformat.format(time),
      notes: note ?? "",
      deviceid: "manual",
      isSection: false,
      isUploadedToWeb: 0,
      serverid: 0,
      devicetype: 0,
      deviceuuid: _repository.storageController.deviceInfo?.fingerprint,
      userid: _repository.storageController.userId,
    );
    try {
      bool response = await _repository.postBloodGlucoseData(data: dataClass);

      if (response) {
        Get.back();
        showToast("Blood Glucose data uploaded!", Get.context);
        fetchUserBloodGlucoseData();
      }

      update();
    } catch (error) {
      log("Error while updating postUserBloodGlucoseData => $error");
    }
  }


  updateUserBloodGlucoseData({
    required String id,
    required String glucoseLevel,
    required String mealType,
    String? note,
  }) async {
  final dateformat = DateFormat("yyyy-MM-d HH:mm:s");
    final dataClass = UpdateGlucoseLevel(
      //id: _repository.storageController.userId,
      id: id,
      glucoseLevel: glucoseLevel,
      mealType: mealType,
      recordDatetime: dateformat.format(DateTime.now()),
      notes: note ?? "",
     
    );
    try {
      bool response = await _repository.updateBloodGlucoseData(data: dataClass);

      if (response) {
        Get.back();
        showToast("Blood Glucose data uploaded!", Get.context);
        fetchUserBloodGlucoseData();
      }

      update();
    } catch (error) {
      log("Error while updating updateUserBloodGlucoseData => $error");
    }
  }

  deleteUserBloodGlucoseData({
    required BloodGlucoseData data,
  }) async {
    try {
      bool response = await _repository.deleteBloodGlucoseData(data: data);

      if (response) {
        Get.back();
        showToast("Blood Glucose data Deleted!", Get.context);
        fetchUserBloodGlucoseData();
      }

      update();
    } catch (error) {
      log("Error while updating deleteUserBloodGlucoseData => $error");
    }
  }
}

