import 'dart:convert';
import 'dart:developer' show log;
import 'package:flutter/foundation.dart' show immutable;
import 'package:wehealth/controller/home_tiles_controller/home_tiles_controller.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/http_cleint/api_clients.dart';

import '../../http_cleint/app_config.dart';

@immutable
class HomeTilesRepository {
  const HomeTilesRepository({
    required this.storage,
  });

  final String baseUrl = AppConfig.baseUrl;
  final StorageController storage;
  int get userId => storage.userId;
  String get userToken => storage.userToken;
  String get email => storage.email;

  static const String userProfileKey = "USER_PROFILE";

  Future<UserCardsWrapper?> getHomeTiles() async {
    String url =
        "$baseUrl/getUser_CardManagement?userid=$userId&token=$userToken";
    try {
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {
        log("Fetch Successful");
        UserCardsWrapper wrapper = UserCardsWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getUser_CardManagement Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getUser_CardManagement ${error.toString()}");
      return null;
    }
  }

  postHomeTiles(List<Map<String, dynamic>> data) async {
    String url = "$baseUrl/addAppCardManagment";
    final formData = {
      "userid": userId,
      "token": userToken,
      "data": json.encode(data),
    };
    log(formData.toString());
    try {
      var response = await ApiClients.postFormUrlEncodedData(formData, url);
      log("post cardData res => ${response.toString()}");
      if (response['error'] == 0) {
        log("SUCCESSFUL!");
        
      } else {
        log("getUser_CardManagement Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getUser_CardManagement ${error.toString()}");
      return null;
    }
  }
}
