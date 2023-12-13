import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/models/data_model/add_user_device_data_model.dart';

import 'package:wehealth/models/data_model/user_devices_model.dart';

import 'user_devices_repository.dart';

class UserDevicesController extends GetxController {
  final UserDevicesRepository _apiRepository =
      UserDevicesRepository(storageController: Get.find<StorageController>());

  UserDevicesWrapper _userDevicesWrapper = UserDevicesWrapper();
  List<UserDeviceModel>? get userDevices {
    return _userDevicesWrapper.deviceData?.where((value) {
      return _userDevicesWrapper.deviceData
              ?.where((element) => element.devicebletype == value.devicebletype)
              .sorted((a, b) => a.insertDate!.compareTo(b.insertDate!))
              .last
              .id ==
          value.id;
    }).toList();
  }

  bool get hasBloodPressureDevice {
    bool? hasDevice = userDevices?.any((element) =>
        element.devicebletype == "3" ||
        element.devicebletype == "37" ||
        element.devicebletype == "36");
    return hasDevice ?? false;
  }

  bool get hasBloodGlucoseDevice {
    bool? hasDevice = userDevices?.any(
      (element) =>
          element.devicebletype == "15" || element.devicebletype == "35",
    );
    return hasDevice ?? false;
  }

  getUserDevices() async {
    try {
      UserDevicesWrapper? response = await _apiRepository.getUserDevices();
      if (response != null && response.deviceData != null) {
        _userDevicesWrapper = response;
        // Get.snackbar(
        //   "Completed!",
        //   "You devices are loaded now!",
        //   margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        // );
      }
      update();
    } catch (error) {
      log("Error while updating getUserDevices => $error");
    }
  }

  Future<bool?> postNewUserDevice({required String deviceName, required int bleTypeId, String? uuid}) async {
    final dateformat = DateFormat("yyyy-MM-d HH:mm:s");

    final deviceModel = AddUserDeviceDataModel(
      id: 0,
      deviceid: 1,
      devicebond: 0,
      devicestatus: 1,
      isuplaodedtoweb: 1,
      lastsynchtime: "",
      devicetypeid: bleTypeId,
      devicebletype: bleTypeId,
      devicename: deviceName,
      deviceuuid: uuid ?? _apiRepository.storageController.email,
      userID: _apiRepository.storageController.userId,
      firstpairingtime: dateformat.format(
        DateTime.now(),
      ),
    );
    log(deviceModel.toJson().toString());

    try {
      bool? response = await _apiRepository.addUserDevice(deviceModel);
      if (response != null) {
        await getUserDevices();
        return true;
      }
      update();
      return false;
    } catch (error) {
      log("Error while updating deleteUserDevices => $error");
      return false;
    }
  }

  Future<bool> deleteUserDevices(UserDeviceModel deviceModel) async {
    try {
      bool? response = await _apiRepository.deleteUserDevice(deviceModel);
      if (response != null) {
        await getUserDevices();
        return true;
      }
      update();
      return false;
    } catch (error) {
      log("Error while updating deleteUserDevices => $error");
      return false;
    }
  }
}
