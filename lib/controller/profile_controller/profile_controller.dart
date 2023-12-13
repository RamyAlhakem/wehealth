import 'dart:developer';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wehealth/controller/profile_controller/profile_repository.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/methods/methods.dart';
import 'package:wehealth/helper/functions/health_functions.dart';
import 'package:wehealth/models/data_model/update_profile_model.dart';
import 'package:wehealth/models/data_model/user_health_score_model.dart';
import 'package:wehealth/models/data_model/user_hospital_list_model.dart';
import 'package:wehealth/models/data_model/user_hospital_relation.dart';
import '../../http_cleint/api_clients.dart';
import '../../http_cleint/app_config.dart';
import '../../models/data_model/profile_model.dart';

class ProfileController extends GetxController {
  SharedPreferences prefs;
  ProfileController({
    required this.prefs,
  });

  final ProfileRepository _repository =
      ProfileRepository(storage: Get.find<StorageController>());

  UserProfile userProfile = UserProfile();
  UserHealthScoreWrapper _healthScoreWrapper = UserHealthScoreWrapper();
  ProfileHospitalListWrapper _hospitalListWrapper =
      ProfileHospitalListWrapper();
  UserHospitalRelationWrapper _hospitalRelationWrapper =
      UserHospitalRelationWrapper();

  bool get isProfileComplete {
    return userProfile.birthDate != null &&
        userProfile.gender != null &&
        userProfile.firstName != null &&
        userProfile.firstName != "" &&
        userProfile.firstName!.isNotEmpty;
        //&& userProfile.age != null;
        //&& userProfile.phone != null;
  }

  HealthScoreData? get healthScoreData => _healthScoreWrapper.healthScoreData;

  List<ProfileHospitalModel>? get profileHospitals =>
      _hospitalListWrapper.hospitalList;

  UserHospitalRelation? get userHospitalRelation {
    if (_hospitalRelationWrapper.relationData == null ||
        _hospitalRelationWrapper.relationData!.isEmpty) return null;
    return _hospitalRelationWrapper.relationData?[0];
  }

  ProfileHospitalModel? get getSelectedHospital {
    final hospitalId = int.tryParse(userProfile.loginType ?? "0");
    return profileHospitals
        ?.firstWhereOrNull((element) => element.id == hospitalId);
  }

  double get userCurrentBodyWater {
    if (userProfile.gender == null ||
        userProfile.age == null ||
        double.tryParse(userProfile.height ?? '') == null ||
        double.tryParse(userProfile.weight ?? '') == null) {
      return 0;
    } else {
      return calculateBodyWater(
        gender: userProfile.gender!,
        age: userProfile.age!,
        height: double.tryParse(userProfile.height!)!,
        weight: double.tryParse(userProfile.weight!)!,
      );
    }
  }

  fetchProfileHospitalList() async {
    DateTime x = DateTime.now();
    x.copyWith(
      month: x.month + 2,
    );
    // x.
    try {
      ProfileHospitalListWrapper? response =
          await _repository.getProfileHospitalList();
      if (response != null && response.hospitalList != null) {
        _hospitalListWrapper = response;
      }
      update();
    } catch (error) {
      log("Error While fetching fetchProfileHospitalList ${error.toString()}");
    }
  }

  Future updateProfilePicture(XFile image) async {
    bool result =
        await _repository.updateProfilePicture(image.path, image.path);
    if (result) {
      await getUserProfile();
      showToast("Profile Picture Updated!", Get.context);
    } else {
      showToast("Error!", Get.context);
    }
    log(result.toString());
  }

  fetchUserHospitalRelation() async {
    try {
      UserHospitalRelationWrapper? response =
          await _repository.getUserHospitalRelation();
      if (response != null && response.relationData != null) {
        _hospitalRelationWrapper = response;
      }
      log("fetchUserHospitalRelation fetched!");
      update();
    } catch (error) {
      log("Error While fetching fetchProfileHospitalList ${error.toString()}");
    }
  }

  getUserProfile({bool ignoreLocal = false}) async {
    try {
      UserProfile? response =
          await _repository.fetchUserProfile(ignoreLocal: ignoreLocal);
      if (response != null) {
        userProfile = response;
        fetchProfileHospitalList();
        if (userProfile.loginType != "0" && userProfile.loginType != "") {
          fetchUserHospitalRelation();
        }
      }
      log("getUserProfile fetched!");
      update();
    } catch (error) {
      log("Error While fetching getUserProfile ${error.toString()}");
    }
  }

  Future updateUserData(UpdateProfileModel newProfile) async {
    try {
      bool? response = await _repository.updateUserProfile(newProfile);
      if (response != null && response) {
        await getUserProfile(ignoreLocal: true);
        showToast("Profile Updated!", Get.context);
      } else {
        showToast("Couldn't update user profile!", Get.context);
      }
      update();
    } catch (error) {
      log("Error While fetching updateUserData ${error.toString()}");
    }
  }

// Need to update with repository pattern.
  // ============== |> User Data <| ============== //

/* 
  Future insertNotification(String subject, String details, String to) async {
    Map<String, dynamic> params = {};
    params['token'] = prefs.getString('user_token') ?? "token_error";
    params['userid'] = prefs.getInt('user_id') ?? 0;
    params['from'] = prefs.getInt('user_id') ?? 0;
    params['to'] = to;
    params['subject'] = subject;
    params['details'] = details;

    String url = AppConstants.baseUrl + AppConstants.insertNotification;
    var response = await ApiClients.postJson(params, url);
    if (response['error'] == 0) {
      log("##insertNotificationRes ==> ${response['authResponse']}");
    } else {
      log("InsertNotificationError ==> ${response['authResponse']}");
    }
  }

  Future insertFirebaseMsg(String title, String body, String to) async {
    Map<String, dynamic> params = {};
    params['token'] = prefs.getString('user_token') ?? "token_error";
    params['userid'] = prefs.getInt('user_id') ?? 0;
    params['to'] = to;
    params['title'] = title;
    params['body'] = body;

    String url = AppConstants.baseUrl + AppConstants.sendFirebaseMsg;
    var response = await ApiClients.postJson(params, url);
    if (response['error'] == 0) {
      log("##insertNotificationRes ==> ${response['authResponse']}");
    } else {
      log("InsertNotificationError ==> ${response['authResponse']}");
    }
  }
 */
  Future fetchHealthScore() async {
    try {
      String url =
          "${AppConfig.baseUrl}/getHealtScore?userid=${prefs.getInt('user_id')}&token=${prefs.getString('user_token')}";

      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {
        UserHealthScoreWrapper model =
            UserHealthScoreWrapper.fromJson(response);
        if (model.healthScoreData != null) _healthScoreWrapper = model;
        update();
      } else {
        log("No HealthScore data found!");
      }
    } catch (error) {
      log("Error While fetching user HealthScore ${error.toString()}");
    }
  }

  /* Calculating BMI */
  double _bmi = 0.0;
  double get bmi  => _bmi;
  
  double _bodyFat = 0.0;
  double get bodyFat  => _bodyFat;

  double _metabolicAge = 0.0;
  double get metabolicAge  => _metabolicAge;

  void calculateBMI() async {

    double weight = double.parse(userProfile.weight!);
    double height = double.parse(userProfile.height!);
    double age = userProfile.age!.toDouble();
    int male = 1;
    int female = 0;

    try {
      /* BMI */
      if(userProfile.weight == null){
        _bmi = double.parse("-");
      } else {
        log("user weight ${userProfile.weight}");
        
        _bmi = ( (double.parse("${userProfile.weight}")) / ((double.parse("${userProfile.height}")/100) * (double.parse("${userProfile.height}")/100) ));
        log("user BMI @ ${bmi.toStringAsFixed(0)}");
      }

      /* Metabolic Age */
      if(userProfile.gender == "Male"){
        //Male: 66.5 + (13.75 x kg) + (5.003 x cm) – (6.775 x age)
        _metabolicAge = (66.5 + (13.75 * weight) + (5.003 * height) - (6.775 * age));

      }else if(userProfile.gender == "Female"){
        //Female: 655.1 + (9.563 x kg) + (1.850 x cm) – (4.676 x age)
        _metabolicAge = (655.1 + (9.563 * weight) + (1.850 * height) - (4.676 * age));
      
      }else{
        _metabolicAge = (66.5 + (13.75 * weight) + (5.003 * height) - (6.775 * age));
      
      }

      /* Body Fat */
      if(userProfile.age == null){
       _bodyFat = double.parse("-");
      } else {
        log("user gender ${userProfile.gender}");
        if(userProfile.gender == "Male"){
          //male = 1
          if(userProfile.age! <= 15){
            _bodyFat = ((1.51 * bmi) - (0.70 * 1) - (3.6 * 1) + 1.4);
            log("user bodyFat 1 @ ${bodyFat.toStringAsFixed(0)}");
          }else if (userProfile.age! > 15){
            _bodyFat = (1.20 * bmi) + (0.20 * 1) - (10.8 * 1) - 5.4;

            log("user bodyFat 2 @ ${bodyFat.toStringAsFixed(0)}");
          }

        } else if (userProfile.gender == "Female"){
          //female = 0
          if(userProfile.age! <= 15){
            _bodyFat = ((1.51 * bmi) - (0.70 * 0) - (3.6 * 0) + 1.4);
            log("user bodyFat 3 @ ${bodyFat.toStringAsFixed(0)}");
          }else if(userProfile.age! > 15){
            _bodyFat = ((1.20 * bmi) + (0.23 * 0) - (10.8 * 0) + 5.4);
            log("user bodyFat 4 @ ${bodyFat.toStringAsFixed(0)}");
          }
          
        } else {
          _bodyFat = ((1.51 * bmi) - (0.70 * 1) - (3.6 * 1) + 1.4);    
          log("user gender other ${userProfile.gender}");   
        }
        
      }

    } catch (e) {
      log("error $e");
    }
  }


}
