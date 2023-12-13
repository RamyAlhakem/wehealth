import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/models/data_model/waist_circumference_wrapper.dart';
import '../../global/methods/methods.dart';
import '../../models/body_measurement/body_water_wrapper.dart';
import '../../models/body_measurement/body_weight_wrapper.dart';
import '../../models/body_measurement/bone_mass_wrapper.dart';
import '../../models/body_measurement/metabolic_age_wrapper.dart';
import '../../models/body_measurement/muscular_mass_wrapper.dart';
import '../../models/body_measurement/visceral_fat_wrapper.dart';
import '../../models/body_measurement/waist_hip_ratio_wrapper.dart';
import '../../models/data_model/user_body_bmr_model.dart';
import '../../models/data_model/user_body_fat_model.dart';
import 'body_measurement_repository.dart';

class BodyMeasurementController extends GetxController {
  final BodyMeasurementRepository _repository = BodyMeasurementRepository(
      storageController: Get.find<StorageController>());

  final WaistCircumferenceResponseWrapper _waistCircumferenceData =
      WaistCircumferenceResponseWrapper();

  UserBodyBMR _bodyBmrData = UserBodyBMR();
  List<BmrData>? get userbodyBmrData => _bodyBmrData.bmrDataList;
  
  UserBodyFat _bodyFatData = UserBodyFat();
  List<BodyFatData>? get userbodyFatData => _bodyFatData.bodyFatDataList;

  MetabolicAgeModel _metabolicAgeData = MetabolicAgeModel();
  List<MetabolicAgeData>? get userMetabolicAgeData => _metabolicAgeData.metabolicAgedataList;
  
  MuscularMassModel _muscularMassData = MuscularMassModel();
  List<MuscularMassData>? get userMuscularMassData => _muscularMassData.muscularMassDataList;
  
  VisceralarFatModel _visceralFatData = VisceralarFatModel();
  List<ViscelarFatdata>? get userViscelarFatdata => _visceralFatData.viscelarFatDataList;
  
  BodyWaterModel _bodyWaterData = BodyWaterModel();
  List<BodyWaterData>? get userBodyWaterData => _bodyWaterData.bodyWaterDataList;
  
  WaistHipRatioModel _waistHipRatioData = WaistHipRatioModel();
  List<WaistHipRatioData>? get userWaistHipRatioData => _waistHipRatioData.waistHipRatioDataList;
  
  BoneMassModel _boneMassData = BoneMassModel();
  List<BoneMassData>? get userBoneMassoData => _boneMassData.boneMassDataList;

  BodyWeightDataResponseWrapper _bodyWeightData = BodyWeightDataResponseWrapper();
  List<BodyWeightData>? get userBodyWeightData => _bodyWeightData.dataList;

  late SharedPreferences prefs;

  // |=====> hUserBodyWeightData from SERVER
  fetchUserBodyWeightData() async {
    try {
      BodyWeightDataResponseWrapper? response =
          await _repository.getBodyWeightData();
      if (response != null && response.dataList != null) {
        _bodyWeightData = response;
        update();
      }
    } catch (error) {
      log("Error while updating fetchUserBodyWeightData => $error");
    }
  }

  List<BodyWeightData> getBodyWeightDataByDay(int dayCount) {
    if (userBodyWeightData == null) return [];
    _bodyWeightData.dataList
        ?.sort((a, b) => a.recordDate.compareTo(b.recordDate));
    final data = userBodyWeightData!
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

  List<BodyWeightData> getDateSortedBodyWeightData() {

    if (_bodyWeightData.dataList == null) return [];
    _bodyWeightData.dataList!.sort(
      (a, b) => a.recordDate.compareTo(b.recordDate),
    );
    log("mukta @ ${_bodyWeightData.dataList!.lastOrNull!.scaleDate}");
    log("mukta @ ${_bodyWeightData.dataList!.lastOrNull!.qty}");
    return _bodyWeightData.dataList!;
  }

  /*   
    fetchWaistCircumData() async {
    try {
      WaistCircumferenceResponseWrapper? response =
          await _repository.getWaistCircumData();
      if (response != null && response.dataList != null) {
        _waistCircumferenceData = response;
      }
      update();
    } catch (error) {
      log("Error while updating fetchUserHeartRate => $error");
    }
  } 
  */

  addUserBodyWeight({
    required double weightQty,
    required double height,
    required DateTime time,
    String? note,
  }) async {
    final dataClass = BodyWeightData(
      weightID: 0,
      scaleDate: time.toIso8601String(),
      qty: weightQty.toDouble(),
      height: height,
      deviceStatus: 0,
      unit: "kg",
      notes: note ?? "",
      deviceuuid: "manual",
      deviceid: "manual",
    );

    try {
      bool response =  await _repository.postBodyWeightData(requestData: dataClass);
      if (response) {
        showToast("Body weight data added!", Get.context);
        Get.back();
        fetchUserBodyWeightData();
      } else {
        showToast("ERROR!", Get.context);
      }
    } catch (error) {
      log("Error while updating fetchUserHeartRate => $error");
    }

  }
  //

  //TODO: This function is too heavy and bad for apps health.
  List<MapEntry<DateTime, List<BodyWeightData>>> get bodyWeightTimelineFormat {
    if (_bodyWeightData.dataList == null || _bodyWeightData.dataList!.isEmpty)
      return [];
    final unFormattedList = _bodyWeightData.dataList!
        .groupListsBy((element) => DateTime(element.recordDate.year,
            element.recordDate.month, element.recordDate.day))
        .entries
        .toList();
    unFormattedList.sort(
      (a, b) => b.key.compareTo(a.key),
    );
    return unFormattedList;
  }


  //
  fetchUserBodyBmrData() async {
    try {
      UserBodyBMR? response =
          await _repository.getUserBMR();

      if (response != null && response.bmrDataList != null) {
        _bodyBmrData = response;

        if (_bodyBmrData.bmrDataList == null) {
          return [];
        }else{
          _bodyBmrData.bmrDataList!.sort(
            (a, b) => b.scaleDate!.compareTo(a.scaleDate!),
          );
          _bodyBmrData.bmrDataList =  _bodyBmrData.bmrDataList!;
        }
        update();
      }
    } catch (error) {
      log("Error while updating fetchUserBodyWeightData => $error");
    }
  }

    fetchUserBodyFatData() async {
    try {
      UserBodyFat? response =  await _repository.getUserBodyFat();

      if (response != null && response.bodyFatDataList != null) {
        _bodyFatData = response;

        if (_bodyFatData.bodyFatDataList == null) {
          return [];
        }else{
          _bodyFatData.bodyFatDataList!.sort(
            (a, b) => b.scaleDate!.compareTo(a.scaleDate!),
          );
          _bodyFatData.bodyFatDataList =  _bodyFatData.bodyFatDataList!;
        }
        update();
      }
    } catch (error) {
      log("Error while updating fetchUserBodyWeightData => $error");
    }
  }

  fetchUserMetabolicAgeData() async {
    try {
      MetabolicAgeModel? response =  await _repository.getUserMetabolicAge();

      if (response != null && response.metabolicAgedataList != null) {
        _metabolicAgeData = response;

        if (_metabolicAgeData.metabolicAgedataList == null) {
          return [];
        }else{
          _metabolicAgeData.metabolicAgedataList!.sort(
            (a, b) => b.scaleDate!.compareTo(a.scaleDate!),
          );
          _metabolicAgeData.metabolicAgedataList =  _metabolicAgeData.metabolicAgedataList!;
        }
        update();
      }
    } catch (error) {
      log("Error while updating fetchUserBodyWeightData => $error");
    }
  }
  fetchUserMuscularMassData() async {
    try {
      MuscularMassModel? response =  await _repository.getUserMuscularMass();

      if (response != null && response.muscularMassDataList != null) {
        _muscularMassData = response;

        if (_metabolicAgeData.metabolicAgedataList == null) {
          return [];
        }else{
          _muscularMassData.muscularMassDataList!.sort(
            (a, b) => b.scaleDate!.compareTo(a.scaleDate!),
          );
          _muscularMassData.muscularMassDataList =  _muscularMassData.muscularMassDataList!;
        }

        // log(" mukta @> ========");
        // log(_muscularMassData.muscularMassDataList![0].qty.toString());
        // log(_muscularMassData.muscularMassDataList![0].scaleDate.toString());
        // log("==================");

        update();
      }
    } catch (error) {
      log("Error while updating fetchUserBodyWeightData => $error");
    }
  }

  fetchUserVisceralarFatData() async {
    try {
      VisceralarFatModel? response =  await _repository.getVisceralarFat();

      if (response != null && response.viscelarFatDataList != null) {
        _visceralFatData = response;

        if (_metabolicAgeData.metabolicAgedataList == null) {
          return [];
        }else{
          _visceralFatData.viscelarFatDataList!.sort(
            (a, b) => b.scaleDate!.compareTo(a.scaleDate!),
          );
          _visceralFatData.viscelarFatDataList =  _visceralFatData.viscelarFatDataList!;
        }

        /* log("_muscularMassData.muscularMassDataList![0].qty.toString()");
        log(_visceralFatData.viscelarFatDataList![0].qty.toString());
        log(_visceralFatData.viscelarFatDataList![0].scaleDate.toString());
 */
        update();
      }
    } catch (error) {
      log("Error while updating fetchUserBodyWeightData => $error");
    }
  }

  fetchUserBodyWaterData() async {
    try {
      BodyWaterModel? response =  await _repository.getBodyWaterData();

      if (response != null && response.bodyWaterDataList != null) {
        _bodyWaterData = response;

        if (_bodyWaterData.bodyWaterDataList == null) {
          return [];
        }else{
          _bodyWaterData.bodyWaterDataList!.sort(
            (a, b) => b.scaleDate!.compareTo(a.scaleDate!),
          );
          _bodyWaterData.bodyWaterDataList =  _bodyWaterData.bodyWaterDataList!;
        }

        /* log("mukta @ body water");
        log(_bodyWaterData.bodyWaterDataList![0].qty.toString());
        log(_bodyWaterData.bodyWaterDataList![0].scaleDate.toString()); */

        update();
      }
    } catch (error) {
      log("mukta @ body water error");
      log("Error while updating fetchUserBodyWaterData => $error");
    }
  }

  fetchUserBoneMassoData() async {
    try {
      BoneMassModel? response =  await _repository.getBoneDensity();

      if (response != null && response.boneMassDataList != null) {
        _boneMassData = response;

        if (_boneMassData.boneMassDataList == null) {
          return [];
        }else{
          _boneMassData.boneMassDataList!.sort(
            (a, b) => b.scaleDate!.compareTo(a.scaleDate!),
          );
          _boneMassData.boneMassDataList =  _boneMassData.boneMassDataList;
        }

        log(" mukta =>@ getBoneDensity ");
        log(_boneMassData.boneMassDataList![0].qty.toString());

        update();
      }
    } catch (error) {
      log("Error while updating fetchUserWaistHipRatioData => $error");
    }
  }  

  fetchUserWaistHipRatioData() async {
    try {
      WaistHipRatioModel? response =  await _repository.getWaistHipRatioData();

      if (response != null && response.waistHipRatioDataList != null) {
        _waistHipRatioData = response;

        if (_waistHipRatioData.waistHipRatioDataList == null) {
          return [];
        }else{
          _waistHipRatioData.waistHipRatioDataList!.sort(
            (a, b) => b.insertiontime!.compareTo(a.insertiontime!),
          );
          _waistHipRatioData.waistHipRatioDataList =  _waistHipRatioData.waistHipRatioDataList;
        }

        //log(" mukta =>@ waisttohipratio ");
        //log(_waistHipRatioData.waistHipRatioDataList![0].waisttohipratio.toString());

        update();
      }
    } catch (error) {
      log("Error while updating fetchUserWaistHipRatioData => $error");
    }
  }


}
