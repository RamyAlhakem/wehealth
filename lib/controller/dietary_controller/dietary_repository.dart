import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:wehealth/http_cleint/api_clients.dart';

import '../../http_cleint/app_config.dart';
import '../storage_controller.dart';
import 'model/food_suggestion_model.dart';
import 'model/water_inatake_model.dart';

class DietaryRepository extends GetxController implements GetxService {
  final StorageController storage;
  DietaryRepository({required this.storage});

  final String baseUrl = AppConfig.baseUrl;
  int get _userId => storage.userId;
  String get _userToken => storage.userToken;
  String get userEmail => storage.email;
  String get userPassword => storage.password;

  Future<FoodSuggestionResponse?> getFoodSuggestion(String name) async {
    String url =
        "$baseUrl/foodnameSuggestion?token=${storage.userToken}&userid=${storage.userId}&name=$name";
    try {
      var response = await ApiClients.getJson(url);

      if (response['error'] == 0) {
        FoodSuggestionResponse wrapper =
            FoodSuggestionResponse.fromJson(response);
        return wrapper;
      } else {
        log("getFoodSuggestion Status => ${response['error']}!");
        return null;
      }
    } catch (e, s) {
      log(
        "Error While fetching getFoodSuggestion ${e.toString()}",
        error: e,
        stackTrace: s,
      );
      return null;
    }
  }
 
  Future postWaterIntake({required WaterIntakeData data}) async {
    String url =
        "${AppConfig.waterIntakeBaseUrl}${AppConfig.addWaterIntake}";
        final param = {
          'userid': _userId,
          'token': _userToken,
          'data': json.encode([data.toJson()]),
        };
    try {
      log(url.toString());
      log(param.toString());
      var response = await ApiClients.postFormUrlEncodedData(param, url);
      log("water intake respose @==> $response");

      if (response['error'] == 0) {
        return response;
      } else {
        log("getFoodSuggestion Status => ${response['authResponse']}!");
        return null;
      }
    } catch (e, s) {
      log(
        "Error While fetching getFoodSuggestion ${e.toString()}",
        error: e,
        stackTrace: s,
      );
      return null;
    }
  }

  Future getUserWaterIntake() async {
    try {
      String url = "${AppConfig.waterIntakeBaseUrl}/${AppConfig.getWaterIntake}?token=$_userToken&userid=$_userId";
      var response = await ApiClients.getJson(url);
      log("repo url @==> $url");
      log("response in repo @==> $response");

      if(response['error'] == 0){
        GetWaterIntakeModel userWaterIntake = GetWaterIntakeModel.fromJson(response);
        return userWaterIntake;
      }else{
        print("userWaterIntake.waterIntakeData @==> ${response['authResponse']}");
        return null;
      }
      
    } catch (e) {
      return null;
      
    }
  
  }
}
