import 'dart:convert';
import 'dart:developer' show log;

import 'package:flutter/foundation.dart' show immutable;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wehealth/global/methods/methods.dart';

import '../../http_cleint/api_clients.dart';
import '../../http_cleint/app_config.dart';

@immutable
class AuthRepository {
  AuthRepository({
    required this.prefs,
  })  : _userId = prefs.getInt('user_id') ?? 0,
        _userToken = prefs.getString('user_token') ?? "",
        _userEmail = prefs.getString("email") ?? "",
        _userPassword = prefs.getString("password") ?? "";

  final String baseUrl = AppConfig.baseUrl;
  final SharedPreferences prefs;
  final int _userId;
  final String _userToken;
  final String _userEmail;
  final String _userPassword;

  Future<bool?> postUpdatePassword(
      String oldPass, String newPass, String confirmPass) async {
    String url = "$baseUrl/updateUserPassword";

    final mainData = {
      "oldpassword": oldPass,
      "newpassword": newPass,
      "confirmpassword": confirmPass,
    };

    final data = {
      "userid": _userId,
      "token": _userToken,
      "data": json.encode([mainData]),
    };

    print(data.toString());

    try {
      var response = await ApiClients.postFormUrlEncodedData(data, url);

      if (response['error'] == 0) {
        return true;
      } else {
        log("postUpdatePassword Status => ${response['error']}!");
        showToast(response['error'], Get.context);
        return false;
      }
    } catch (error) {
      log("Error While postUpdatePassword ${error.toString()}");
      return null;
    }
  }

  Future<bool?> postForgetPassword(String email) async {
    String url = "$baseUrl/ForgotPassword";

    final data = {
      "email": email,
    };

    try {
      var response = await ApiClients.postFormUrlEncodedData(data, url);
      if (response['error'] == 0) {
        return true;
      } else {
        log("postForgetPassword Status => ${response['error']}!");
        showToast(response['authResponse'], Get.context);
        return false;
      }
    } catch (error) {
      log("Error While postForgetPassword ${error.toString()}");
      return null;
    }
  }
}
