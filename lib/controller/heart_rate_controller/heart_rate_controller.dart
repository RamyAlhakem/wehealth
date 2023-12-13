import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/methods/methods.dart';
import 'package:wehealth/models/data_model/fetch_heart_rate_model.dart';

import 'heart_rate_repository.dart';

class HeartRateController extends GetxController {
  final HeartRateRepository _repository =
      HeartRateRepository(storageController: Get.find<StorageController>());

/*   HeartRateFetchWrapper _heartRateFetchWrapper = HeartRateFetchWrapper();
  List<HeartRateFetchModel>? get heartRateData =>
      _heartRateFetchWrapper.heartRateData; */

  Map<int, List<HeartRateFetchModel>> dayTableDataCache = {};
  List<HeartRateFetchModel> getBpDataByDay(
    int dayCount, [
    bool force = false,
  ]) {
    /* if (heartRateData == null) return [];
    _heartRateFetchWrapper.heartRateData
        ?.sort((a, b) => a.recordDate.compareTo(b.recordDate));
    final data = heartRateData !*/
    if (dayTableDataCache.containsKey(dayCount) && !force) {
      return dayTableDataCache[dayCount] ?? [];
    } else {
      final sortedList = sortedDataList
          .where(
            (element) => element.recordDate.isAfter(
              DateTime.now().subtract(
                Duration(days: dayCount),
              ),
            ),
          )
          .toList();

      dayTableDataCache.assign(dayCount, sortedList);
      update();
      return dayTableDataCache[dayCount] ?? [];
    }
    // return data;
  }

  Map<int, List<HeartRateFetchModel>> typeCacheMap = {};
  getHeartRateDataByType(
    int type, [
    bool force = false,
  ]) {
    // if (_heartRateFetchWrapper.heartRateData == null) return [];
    if (typeCacheMap.containsKey(type) && !force) {
      return typeCacheMap[type] ?? [];
    } else {
      final dataList = sortedDataList
          .where((element) => element.heartRateType == type)
          .toList();
      typeCacheMap.assign(type, dataList);
      update();
    }
  }

//TODO: This function is too heavy and bad for apps health.
  Future<List<MapEntry<DateTime, List<HeartRateFetchModel>>>>
      heartRateTimelineFormat() async {
    /*  if (_heartRateFetchWrapper.heartRateData == null ||
        _heartRateFetchWrapper.heartRateData!.isEmpty) return [];
    final unFormattedList = _heartRateFetchWrapper.heartRateData! */
    return await compute(sortHeartRateTimeline, sortedDataList);
    /* unFormattedList.sort(
      (a, b) => a.key.compareTo(b.key),
    ); */
    // return unFormattedList;
  }

//TODO: To sort and resolve everything, call this function in a different thread and sort the data list.
/*   List<MapEntry<DateTime, List<HeartRateFetchModel>>> _formatSortingFunction(
      List<HeartRateFetchModel> unformattedList) {
    unformattedList.sort(
      (a, b) => a.recordDate.compareTo(b.recordDate),
    );
    return unformattedList
        .groupListsBy((element) => DateTime(element.recordDate.year,
            element.recordDate.month, element.recordDate.day))
        .entries
        .toList();
  } */

/*  */

  List<HeartRateFetchModel> sortedDataList = [];

/*  */
  fetchUserHeartRate() async {
    try {
      HeartRateFetchWrapper? response = await _repository.getHeartRateData();
      if (response != null && response.heartRateData != null) {
        // _heartRateFetchWrapper = response;
        sortedDataList =
            await compute<List<HeartRateFetchModel>, List<HeartRateFetchModel>>(
          sortHeartRateDataByDate,
          response.heartRateData!,
        );
        getHeartRateDataByType(1, true);
        getHeartRateDataByType(0, true);
      }
      update();
      print("## HEART_RATE_FETCH_COMPLETE!");
    } catch (error) {
      log("Error while updating fetchUserHeartRate => $error");
    }
  }

  addUserHeartRate(int? data, int heartRateType, DateTime time) async {
    if (data == null) {
      showToast("Invalid Heart Rate Value!", Get.context);
      return;
    }
    final dataClass = HeartRateRequestModel(
      heartRateQty: data,
      recordDateTime: time.toIso8601String(),
      deviceStatus: 0,
      heartRateType: heartRateType,
      deviceuuid: "manual",
      deviceid: "manual",
      heartRateID: 0,
      userID: _repository.storageController.userId,
    );
    try {
      bool response =
          await _repository.postHeartRateData(requestData: dataClass);
      if (response) {
        await fetchUserHeartRate();
        showToast("Heart Rate Data added!", Get.context);
        Get.back();
      } else {
        showToast("ERROR!", Get.context);
      }
    } catch (error) {
      log("Error while updating fetchUserHeartRate => $error");
    }
  }
}

FutureOr<List<HeartRateFetchModel>> sortHeartRateDataByDate(
    List<HeartRateFetchModel> list) async {
  list.sort((a, b) => a.recordDate.compareTo(b.recordDate));
  return list;
}

FutureOr<List<MapEntry<DateTime, List<HeartRateFetchModel>>>>
    sortHeartRateTimeline(List<HeartRateFetchModel> list) async {
  return list.reversed
      .groupListsBy((element) => DateTime(element.recordDate.year,
          element.recordDate.month, element.recordDate.day))
      .entries
      .toList();
}
