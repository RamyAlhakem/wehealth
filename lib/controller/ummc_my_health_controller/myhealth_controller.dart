import 'package:get/get.dart';
import 'package:wehealth/controller/profile_controller/profile_controller.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/controller/ummc_my_health_controller/ummc_repository.dart';
import 'package:wehealth/global/methods/methods.dart';

class MyHealthController extends GetxController {
  final _repository =
      MyHealthRepository(storage: Get.find<StorageController>());

  varifyUserExistance({required String icNumber, required String mrn}) async {
    final userProfile = Get.find<ProfileController>().userProfile;
    if (userProfile.phone == null) {
      showToast("Need a phone number in profile!", Get.context);
    } else {
      await _repository.varifyUserUMMC(
          icNumber: icNumber, phone: userProfile.phone!, mrn: mrn);
    }
  }
}
