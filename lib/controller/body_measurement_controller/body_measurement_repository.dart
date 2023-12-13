import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:wehealth/controller/storage_controller.dart';

import '../../http_cleint/api_clients.dart';
import '../../http_cleint/app_config.dart';
import '../../models/body_measurement/body_water_wrapper.dart';
import '../../models/body_measurement/body_weight_wrapper.dart';
import '../../models/body_measurement/bone_mass_wrapper.dart';
import '../../models/body_measurement/metabolic_age_wrapper.dart';
import '../../models/body_measurement/muscular_mass_wrapper.dart';
import '../../models/body_measurement/visceral_fat_wrapper.dart';
import '../../models/body_measurement/waist_hip_ratio_wrapper.dart';
import '../../models/data_model/user_body_bmr_model.dart';
import '../../models/data_model/user_body_fat_model.dart';

@immutable
class BodyMeasurementRepository {
  const BodyMeasurementRepository({
    required this.storageController,
  });
  
  final String baseUrl = AppConfig.baseUrl;
  final StorageController storageController;

  String get _userToken => storageController.userToken;
  int get _userId => storageController.userId;

  
  //* Body Weight Data */
  Future<BodyWeightDataResponseWrapper?> getBodyWeightData() async {
    String url = "$baseUrl/${AppConfig.bodyWeightDataUri}?token=$_userToken&userid=$_userId";
    print("bodyweight url = > $url");

    try {
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {
        log("Fetch Successful");
        BodyWeightDataResponseWrapper wrapper =
            BodyWeightDataResponseWrapper.fromJson(response);
        log("pesponse => $response");
        log("=====\n pesponse => $wrapper");
        return wrapper;
      } else {
        log("getBodyWeightData Status => ${response['error']}!");
        return null;
      } 
    } catch (error, s) {
      log("Error While fetching getBodyWeightData ${error.toString()}", stackTrace: s);
      return null;
    }
  }
  //

  Future<bool> postBodyWeightData(
      {required BodyWeightData requestData}) async {
    String url = "$baseUrl/AddWeight";
    final param = {
      'userid': _userId,
      'token': _userToken,
      'data': json.encode([requestData.toJson()]),
    };
    try {
      log(param.toString());
      var response = await ApiClients.postFormUrlEncodedData(param, url);
      if (response['error'] == 0) {
        await getBodyWeightData();
        return true;
      } else {
        log("postBodyWeightData Status => ${response['error']}!");
        return false;
      }
    } catch (error) {
      log("Error While fetching postBodyWeightData ${error.toString()}");
      return false;
    }
  }
  
  //

  Future<bool?> postWaistCircumferenceData() async {
     String url = "$baseUrl/";
    final param = {
      'userid': _userId,
      'token': _userToken,
      'data': json.encode([]),
    };
    try {
      log(param.toString());
      /* var response = await ApiClients.postFormUrlEncodedData(param, url);
      if (response['error'] == 0) {
        return true;
      } else {
        log("postHeartRateData Status => ${response['error']}!");
        return false;
      } */
    } catch (error) {
      log("Error While fetching postHeartRateData ${error.toString()}");
      return false;
    }
    return null;
  }

  Future<UserBodyBMR?> getUserBMR() async {
    String url = "$baseUrl/GetBMR?token=$_userToken&userid=$_userId";

    try {
      //log(url.toString());
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {

        UserBodyBMR bodyBMR = UserBodyBMR.fromJson(response);
        //log("${bodyBMR.bmrDataList![0].qty}");

        return bodyBMR;
      } else {
        //log("postHeartRateData Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      //log("Error While fetching postHeartRateData ${error.toString()}");
      return null;
    }

  }
  Future<UserBodyFat?> getUserBodyFat() async {
     String url = "$baseUrl/GetBodyFat?token=$_userToken&userid=$_userId";

    try {
      //log(url.toString());
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {

        UserBodyFat bodyFat = UserBodyFat.fromJson(response);
        //log("${bodyFat.bodyFatDataList![0].qty}");

        return bodyFat;
      } else {
        //log("postHeartRateData Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      //log("Error While fetching postHeartRateData ${error.toString()}");
      return null;
    }

  }
  Future<MetabolicAgeModel?> getUserMetabolicAge() async {
     String url = "$baseUrl/GetmetabolicAge?token=$_userToken&userid=$_userId";

    try {
      //log(url.toString());
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {

        MetabolicAgeModel bodyAge = MetabolicAgeModel.fromJson(response);
        //log("${bodyAge.metabolicAgedataList![0].metabolicage}");

        return bodyAge;
      } else {
        //log("postHeartRateData Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      //log("Error While fetching postHeartRateData ${error.toString()}");
      return null;
    }

  }
  Future<MuscularMassModel?> getUserMuscularMass() async {
     String url = "$baseUrl/GetMuscleMass?token=$_userToken&userid=$_userId";

    try {
      log(url.toString());
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {

        MuscularMassModel muscleralMass = MuscularMassModel.fromJson(response);
        //log("${muscleralMass.muscularMassDataList![0].qty}");

        return muscleralMass;
      } else {
        log("postHeartRateData Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching postHeartRateData ${error.toString()}");
      return null;
    }

  }

  Future<VisceralarFatModel?> getVisceralarFat() async {
     String url = "$baseUrl/GetVisceralFat?token=$_userToken&userid=$_userId";

    try {
      //log(url.toString());
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {

        VisceralarFatModel massModel = VisceralarFatModel.fromJson(response);
        //log("${massModel.viscelarFatDataList![0].qty}");

        return massModel;
      } else {
        //log("postHeartRateData Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      //log("Error While fetching postHeartRateData ${error.toString()}");
      return null;
    }

  }
  
  Future<BodyWaterModel?> getBodyWaterData() async {
     String url = "$baseUrl/retrieveWaterDensityData?token=$_userToken&userid=$_userId";

    try {
      log(url.toString());
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {

        BodyWaterModel bodyWaterData = BodyWaterModel.fromJson(response);
        //log("${bodyWaterData.bodyWaterDataList![0].qty}");

        return bodyWaterData;
      } else {
        //log("getBodyWaterData Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      //log("Error While fetching BodyWaterData ${error.toString()}");
      return null;
    }

  }

  Future<BoneMassModel?> getBoneDensity() async {
     String url = "$baseUrl/GetBoneDensity?token=$_userToken&userid=$_userId";

    try {
      //log(url.toString());
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {

        BoneMassModel boneMassData = BoneMassModel.fromJson(response);
        //log("${boneMassData.metabolicAgedataList![0].metabolicage}");

        return boneMassData;
      } else {
        //log("postHeartRateData Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      //log("Error While fetching postHeartRateData ${error.toString()}");
      return null;
    }

  }

  
  Future<WaistHipRatioModel?> getWaistHipRatioData() async {
     String url = "$baseUrl/getwaistcircumference?token=$_userToken&userid=$_userId";

    try {
      //log(url.toString());
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {

        WaistHipRatioModel waistData = WaistHipRatioModel.fromJson(response);
        //log("${waistData.viscelarFatDataList![0].qty}");

        return waistData;
      } else {
        //log("postHeartRateData Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      //log("Error While fetching postHeartRateData ${error.toString()}");
      return null;
    }

  }

}
