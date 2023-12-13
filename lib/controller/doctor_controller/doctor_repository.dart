import 'dart:developer';

import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/http_cleint/api_clients.dart';
import 'package:wehealth/models/data_model/user_doctors_list_model.dart';

import '../../http_cleint/app_config.dart';

class DoctorRepository {
  const DoctorRepository({
    required this.storage,
  });

  final String baseUrl = AppConfig.baseUrl;
  final StorageController storage;
  int get userId => storage.userId;
  String get userToken => storage.userToken;
  String get email => storage.email;

  Future<DoctorListWrapper?> getUserDoctorList() async {
    String url =
        "$baseUrl/getListOfDoctorByUserID?token=${storage.userToken}&userid=${storage.userId}";
    try {
      var response = await ApiClients.getJson(url);

      if (response['error'] == 0) {
        DoctorListWrapper wrapper = DoctorListWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getUserDoctorList Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getUserDoctorList ${error.toString()}");
      return null;
    }
  }

  Future<ResponseWrapper?> getAuthenticationResponse(
      String name, String code) async {
    String url =
        "$baseUrl/ValidateCode?username=$name&token=$userToken&Code=$code";
    log(url);
    try {
      var response = await ApiClients.getJson(url);
      log(response.toString());
      ResponseWrapper wrapper = ResponseWrapper.fromJson(response);
      return wrapper;
    } catch (error) {
      log("Error While fetching getAuthenticationResponse ${error.toString()}");
      return null;
    }
  }
}

class ResponseWrapper {
  int? error;
  String? authResponse;
  String? data;

  ResponseWrapper({this.error, this.authResponse, this.data});

  ResponseWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    data = json['Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    jsonData['Data'] = data;
    return jsonData;
  }
}
