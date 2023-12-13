import 'dart:developer';

import 'package:get/get.dart';
import 'package:wehealth/controller/doctor_controller/doctor_repository.dart';
import 'package:wehealth/controller/profile_controller/profile_controller.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/methods/methods.dart';
import 'package:wehealth/models/data_model/user_doctors_list_model.dart';

class DoctorController extends GetxController {
  DoctorController()
      : _repository = DoctorRepository(storage: StorageController.instance());
  final DoctorRepository _repository;

  DoctorListWrapper _doctorListWrapper = DoctorListWrapper();

  List<UserDoctorModel>? get doctorsList => _doctorListWrapper.doctorsList;

  fetchUserDoctorList() async {
    try {
      DoctorListWrapper? response = await _repository.getUserDoctorList();
      if (response != null && response.doctorsList != null) {
        _doctorListWrapper = response;
      }
      update();
    } catch (error) {
      log("Error While fetching fetchUserDoctorList ${error.toString()}");
    }
  }

  authenticationCode(String code) async {
    try {
      final userProfile = Get.find<ProfileController>().userProfile;
      ResponseWrapper? response = await _repository.getAuthenticationResponse(
        userProfile.username ?? "",
        code,
      );
      log("Response from controller => ${response.toString()}");
      if (response != null) {
        showToast(response.data, Get.context);
        if (response.error == 0) {
          await fetchUserDoctorList();
          Get.back();
        }
      }
      update();
    } catch (error) {
      log("Error While fetching fetchUserDoctorList ${error.toString()}");
      return false;
    }
  }
}
