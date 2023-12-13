import 'dart:convert';
import 'dart:developer' show log;
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/constants/app_constants.dart';
import 'package:wehealth/http_cleint/api_clients.dart';
import 'package:wehealth/http_cleint/app_config.dart';
import 'package:wehealth/models/data_model/profile_model.dart';
import 'package:wehealth/models/data_model/update_profile_model.dart';
import 'package:wehealth/models/data_model/user_hospital_list_model.dart';
import 'package:wehealth/models/data_model/user_hospital_relation.dart';

@immutable
class ProfileRepository {
  const ProfileRepository({
    required this.storage,
  });

  final String baseUrl = AppConfig.baseUrl;
  final String seconderyBaseUrl = AppConfig.seconderyBaseUrl;
  final StorageController storage;
  int get userId => storage.userId;
  String get userToken => storage.userToken;
  String get email => storage.email;
  String get password => storage.password;

  static const String userProfileKey = "USER_PROFILE";

  Future<bool?> updateUserProfile(UpdateProfileModel profile) async {
    String url = baseUrl + AppConfig.updateUser;
    final data = profile.toJson();
    data.remove('profilepic');
    log("CardName: ${data['cardname']}");
    data.addAll({
      "token": userToken,
      "userID": userId,
      "password": password,
      "version":
          "${storage.deviceInfo?.model} - ${storage.deviceInfo?.version.sdkInt} - ${storage.deviceInfo?.version.release}",
    });

    try {
      var response = await ApiClients.putJson(data, url);
      log("json data is===>>> ${data.toString()}");
      if (response['error'] == 0) {
        return true;
      } else {
        log("Update User profile => ${response['authResponse']}");
        return false;
      }
    } catch (error) {
      log("Error While fetching fetchUserProfile ${error.toString()}");
      return false;
    }
  }

  UserProfile? fetchUserProfileOffline() {
    final data = storage.checkAndGetData(userProfileKey);
    if (data != null) {
      UserProfile model = UserProfile.fromJson(data);
      return model;
    }
    return null;
  }

  Future<UserProfile?> fetchUserProfile({bool ignoreLocal = false}) async {
    if (!ignoreLocal) {
      final data = storage.checkAndGetData(userProfileKey);
      if (data != null) return UserProfile.fromJson(data);
    }

    try {
      String url = "$baseUrl/GetUserData?userid=$userId&token=$userToken";
      var response = await ApiClients.getJson(url);
      log("UserProfileResponse: $response");
      if (response['error'] == 0) {
        log(response.toString());
        UserProfileWrapper model = UserProfileWrapper.fromJson(response);
        UserProfile? profile = model.data?.firstOrNull;
        if (profile != null) {
          storage.save(userProfileKey, profile.toJson());
          log("User Profile isn't null!");
        }
        return model.data?.firstOrNull;
      } else {
        log("fetchUserProfile Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching fetchUserProfile ${error.toString()}");
      return null;
    }
  }

  Future<bool> updateProfilePicture(String imagePath, String imageName) async {
    String url = "$seconderyBaseUrl/api/upload-profile-picture.php";
    String key = "35DFAB3DB5179837354A4C2C12743";

    MultipartFile imageFile =
        await MultipartFile.fromFile(imagePath, filename: imageName);
    Options headerOption =
        Options(headers: {'Content-Type': 'multipart/form-data'});

    var formData = {
      'secert_key': key,
      'user_id': storage.userId,
      'profile_picture': imageFile,
    };

    try {
      var res = await ApiClients.postFormMap(formData, url, headerOption);
      var response = json.decode(res);

      if (response['error'] == 0) {
        return true;
      } else {
        log("updateProfilePicture Status => ${response['error']}!");
        return false;
      }
    } catch (error, trace) {
      log(error.toString(), stackTrace: trace);
      return false;
    }
  }

  Future<ProfileHospitalListWrapper?> getProfileHospitalList() async {
    String url =
        "$baseUrl/getcomphospital?token=${storage.userToken}&userid=${storage.userId}";
    try {
      var response = await ApiClients.getJson(url);

      if (response['error'] == 0) {
        ProfileHospitalListWrapper wrapper =
            ProfileHospitalListWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getProfileHospitalList Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getProfileHospitalList ${error.toString()}");
      return null;
    }
  }

  Future<UserHospitalRelationWrapper?> getUserHospitalRelation() async {
    String url =
        "$baseUrl/getcomphospitaluserrelation?token=${storage.userToken}&userid=${storage.userId}";
    try {
      var response = await ApiClients.getJson(url);

      if (response['error'] == 0) {
        UserHospitalRelationWrapper wrapper =
            UserHospitalRelationWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getUserHospitalRelation Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getUserHospitalRelation ${error.toString()}");
      return null;
    }
  }
}

/* {
  age: 24,
 birthDate: 1998-06-07,
 cardname: Be More Active,
 education: No formal schooling,
 email: wehealth.my@gmail.com,
 firstName: My,
 gender: Male,
 height: 63.0,
 ic_number: 1234,
 imagePath: 12856/639c6d89044cb_1671196041_images cut 2.jpeg,
 isActive: 1,
 isMonash: 0,
 lastName: WeHealth,
 lifestyle: Moderate Active,
 loginType: 9,
 marital: Married,
 password: null,
 phone: 01824262003,
 questionnaire: 0,
 race: Other,
 smoking: No,
 stride: ,
 token: 94ca49753c9d41f3d4a8ba10d98540cd,
 address: ,
 town: ,
 country: Select,
 userID: null,
 state: Selangor,
 postCode: ,
 username: wehealth.my@gmail.com,
 usertype: 1,
 version: null,
 weight: 70.3
} */

/* 
{error: 0,
 authResponse: Action Successful,
 Data: [{userID: 12856,
 ic_number: 1234,
 loginType: 9,
 username: wehealth.my@gmail.com,
 realmpwd: 6P2BETW88E1XOt39vuLEgroWLhmNSULd,
 email: wehealth.my@gmail.com,
 phone: 01824262003,
 questionnaire: 0,
 firstName: My,
 lastName: WeHealth,
 gender: Female,
 birthDate: 1998-06-07T00:00:00.000Z,
 height: 63.0,
 height_unit: cm,
 weight: 70.3,
 profilepic: 12856/639c6d89044cb_1671196041_images cut 2.jpeg,
 address: Unknown Street,
 Malaya.,
 town: Siri Gading,
 state: Perak,
 country: Bahamas,
 postCode: 5000,
 mobileNumber: 01824262003,
 version: Android SDK built for x86 - 29 - 10,
 age: 24,
 marital: Divorced,
 smoking: Yes,
 race: Chinese,
 Eduction: Less than primary school}]
 } 
 */
