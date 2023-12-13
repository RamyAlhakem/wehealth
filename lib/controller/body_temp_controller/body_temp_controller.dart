import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/body_temp_controller/body_temp_repository.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/methods/methods.dart';
import 'package:wehealth/models/data_model/body_temp_fetch_wrapper.dart';

class BodyTemperatureController extends GetxController {
  final BodyTemperatureRepository _repository = BodyTemperatureRepository(
      storageController: Get.find<StorageController>());

  BodyTempFetchWrapper _bodyTempFetchWrapper = BodyTempFetchWrapper();

  List<BodyTempData> get tempDataSortedByDate {
    if (_bodyTempFetchWrapper.dataList == null) return [];
    _bodyTempFetchWrapper.dataList!.sort(
      (a, b) => a.recordDate.compareTo(b.recordDate),
    );
    return _bodyTempFetchWrapper.dataList!;
  }

  List<BodyTempData> tempDataByDay(int dayCount) {
    final data = tempDataSortedByDate
        .where(
          (element) => element.recordDate.isAfter(
            DateTime.now().subtract(Duration(days: dayCount)),
          ),
        )
        .toList();
    return data;
  }

  List<MapEntry<DateTime, List<BodyTempData>>> get timelineFormat {
    return tempDataSortedByDate.groupListsBy(
      (element) => DateTime(element.recordDate.year, element.recordDate.month,
          element.recordDate.day),
    ).entries.toList();
  }

  // =====> SERVER
  fetchBodyTempData() async {
    try {
      BodyTempFetchWrapper? response = await _repository.getBodyTempData();
      if (response != null && response.dataList != null) {
        _bodyTempFetchWrapper = response;
      }
      update();
    } catch (error) {
      log("Error while updating fetchBodyTempData=> $error");
    }
  }

  postBodyTempData({
    required double tempLevel,
    required String tempType,
    required DateTime time,
    String? note,
  }) async {
    final dataClass = BodyTempUploadModel(
      temperaturelevel: tempLevel,
      unit: tempType,
      usernotes: note,
      recordtime: time.toIso8601String(),
      recordDateTime: time.toIso8601String(),
      userid: _repository.storageController.userId,
      serverid: 0,
      isUploadedToWeb: 0,
    );
    try {
      bool response = await _repository.postBodyTempData(data: dataClass);
      if (response) {
        Get.back();
        showToast("Body Temperature data uploaded!", Get.context);
        fetchBodyTempData();
      }
      update();
    } catch (error) {
      log("Error while updating postBodyTempData => $error");
    }
  }
}
