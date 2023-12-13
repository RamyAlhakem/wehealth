import 'dart:developer';

import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/http_cleint/api_clients.dart';

import '../../http_cleint/app_config.dart';

class MyHealthRepository {
  MyHealthRepository({required this.storage});

  final StorageController storage;
  final String baseUrl = AppConfig.baseUrl;
  final String seconderyBaseUrl = AppConfig.seconderyBaseUrl;
  final String hosipitalVarificationUrl = "http://my5.ummc.edu.my";

  int get userId => storage.userId;
  String get email => storage.email;
  String get password => storage.password;
  String get userToken => storage.userToken;

  Future varifyUserUMMC(
      {required String icNumber,
      required String phone,
      required String mrn}) async {
    try {
      String url = "$hosipitalVarificationUrl/api/selfcheckin_mobile/verifyuser.php";
      String varificationEmail = 'ummc@umchtech.com';
      String varificationPassword = 'WeHealth123';

      final data = {
        'verify_email': varificationEmail,
        'verify_password': varificationPassword,
        'icno': icNumber,
        'mobile': phone,
        'MRN': mrn,
        'loginid': email,
        'password': password,
      };
      log(data.toString());
      var response = await ApiClients.postFormMap(data, url);
      if (response['error'] == 0) {
        log(response.toString());
        // UserProfileWrapper model = UserProfileWrapper.fromJson(response);
        // return model;
      } else {
        log("Response error!");
        log(response.toString());
        return null;
      }
    } catch (error) {
      log("Error While varifyUserUMMC ${error.toString()}");
      return null;
    }
  }
}
