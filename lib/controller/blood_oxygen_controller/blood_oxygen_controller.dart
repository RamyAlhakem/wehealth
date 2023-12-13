import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/methods/methods.dart';
import 'package:wehealth/models/data_model/blood_oxygen_data_upload_model.dart';

import '../../models/data_model/blood_oxygen_data_fetch_wrapper.dart';
import 'blood_oxygen_repository.dart';

class BloodOxygenController extends GetxController {
  final BloodOxygenRepository _repository =
      BloodOxygenRepository(storageController: Get.find<StorageController>());

  BloodOxygenWrapper _dataFetchWrapper = BloodOxygenWrapper();

  List<BloodOxygenData> get getTheSortedList {
    if (_dataFetchWrapper.dataList == null) return [];
    if (_dataFetchWrapper.dataList!
        .isSorted((a, b) => a.recordDate.compareTo(b.recordDate))) {
      return _dataFetchWrapper.dataList!;
    }
    _dataFetchWrapper.dataList!.sort(
      (a, b) => a.recordDate.compareTo(b.recordDate),
    );
    return _dataFetchWrapper.dataList!;
  }

  List<BloodOxygenData> getBloodOxygenDataByDay(int dayCount) {
    return getTheSortedList
        .where(
          (value) => value.recordDate.isAfter(
            DateTime.now().subtract(
              Duration(days: dayCount),
            ),
          ),
        )
        .toList();
  }

  Map<DateTime, List<BloodOxygenData>> getTimelineFormat() {
    final data = getTheSortedList.groupListsBy<DateTime>(
      (element) => DateTime(
        element.recordDate.year,
        element.recordDate.month,
        element.recordDate.day,
      ),
    );
    return data;
  }

  // =====> SERVER
  fetchUserBloodOxygenData() async {
    try {
      BloodOxygenWrapper? response = await _repository.getBloodOxygenData();
      if (response != null && response.dataList != null) {
        _dataFetchWrapper = response;
        update();
      }
    } catch (error) {
      log("Error while updating fetchUserBloodOxygenData => $error");
    }
  }

  postUserBloodOxygenData({
    required int oxygenlevel,
    required int pulseRate,
    required DateTime time,
    String? note,
  }) async {
    final dataClass = BloodOxygenDataUploadModel(
      id: 123,
      serverid: 1,
      devicetype: 1,
      deviceid: "manual",
      isUploadedToWeb: 0,
      issectionheader: false,
      notes: note,
      oxygenlevel: oxygenlevel,
      pulse: pulseRate,
      recordDateTime: time.toIso8601String(),
      recordtime: time.toIso8601String(),
      deviceuuid: _repository.storageController.deviceInfo?.fingerprint,
      userID: _repository.storageController.userId,
    );

    try {
      bool response = await _repository.postBloodOxygenData(data: dataClass);
      if (response) {
        Get.back();
        showToast("Blood Oxygen data uploaded!", Get.context);
        fetchUserBloodOxygenData();
        update();
      }
    } catch (error) {
      log("Error while posting postUserBloodOxygenData => $error");
    }
  }
}
