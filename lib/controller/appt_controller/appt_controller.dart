import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/appt_controller/appt_repository.dart';
import 'package:wehealth/controller/profile_controller/profile_controller.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/models/data_model/appt_clinic_day_slot_model.dart';
import 'package:wehealth/models/data_model/appt_hopital_dep_list_model.dart';
import 'package:wehealth/models/data_model/appt_hospital_list_model.dart';
import 'package:wehealth/models/data_model/appt_request_model.dart';
import 'package:wehealth/models/data_model/appt_summary_model.dart';
import 'package:wehealth/models/data_model/doctor_appt_booked_slot.dart';
import 'package:wehealth/models/data_model/user_appt_doctor_list.dart';
import 'package:wehealth/models/data_model/user_appt_list_model.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';

class ApptController extends GetxController {
  final ApptRepository _repository = ApptRepository(
    storage: Get.find<StorageController>(),
  );

  ApptSummaryWrapper _apptSummaryModel = ApptSummaryWrapper();
  ApptHospitalListWrapper _apptHospitalListWrapper = ApptHospitalListWrapper();
  UserApptListWrapper _userApptListWrapper = UserApptListWrapper();
  DoctorApptDoctorListWrapper _doctorListWrapper =
      DoctorApptDoctorListWrapper();
  HospitalDepartmentListWrapper _departmentListWrapper =
      HospitalDepartmentListWrapper();
  SlotListResponse _doctorApptSlotWrapper = SlotListResponse();
  DoctorApptBookedSlotWrapper _doctorApptBookedSlotWrapper =
      DoctorApptBookedSlotWrapper();

  ApptRepository get repository => _repository;
  List<ApptSummaryModel>? get apptHistory => _apptSummaryModel.history;

  List<DoctorApptDoctor>? get apptDoctorList =>
      _doctorListWrapper.listOfDoctors;
  List<ApptSlotData>? get doctorApptSlots => _doctorApptSlotWrapper.slots;
  List<DoctorApptBookedSlot>? get doctorApptBookedSlots =>
      _doctorApptBookedSlotWrapper.bookedSlots;
  List<ApptSlotData> slotsForDay(String day) {
    if (doctorApptSlots == null) return [];
    return doctorApptSlots!
        .where((element) => element.day!.toLowerCase() == day.toLowerCase())
        .toList();
  }

  List<UserApptModel>? get userApptHistoryList {
    if (_userApptListWrapper.userAppointments != null) {
      return _userApptListWrapper.userAppointments!
          .where(
            (element) => ((stringDateWithTZ
                    .parse(element.appointmentDate ?? "")
                    .isBefore(DateTime.now())) ||
                element.status == 4 ||
                element.status == 7),
          )
          .toList();
    } else {
      return null;
    }
  }

  List<UserApptModel>? get userApptActiveList {
    if (_userApptListWrapper.userAppointments != null) {
      return _userApptListWrapper.userAppointments!
          .where((element) =>
              ((stringDateWithTZ.parse(element.appointmentDate ?? "").isAfter(
                        DateTime.now().subtract(
                          const Duration(days: 1),
                        ),
                      )) &&
                  element.status != 4 &&
                  element.status != 7))
          .toList();
    } else {
      return null;
    }
  }

  List<UserApptModel>? get userApptTeleConsultationList {
    if (_userApptListWrapper.userAppointments != null) {
      return _userApptListWrapper.userAppointments!
          .where((element) =>
              ((stringDateWithTZ.parse(element.appointmentDate ?? "").isAfter(
                        DateTime.now().subtract(
                          const Duration(days: 3),
                        ),
                      )) &&
                  element.appointmentType == 1))
          .toList();
    } else {
      return null;
    }
  }

  List<ApptHospitalData>? get apptHospitals =>
      _apptHospitalListWrapper.hospitals;
  List<HospitalDepData>? get hospitalDeps => _departmentListWrapper.deps;

  fetchApptSummary(DateTime? date) async {
    try {
      ApptSummaryWrapper? response =
          await _repository.getApptSummary(date ?? DateTime.now());
      if (response != null && response.history != null) {
        _apptSummaryModel = response;
      }
      update();
    } catch (error) {
      log("Error While fetching ApptSummary ${error.toString()}");
    }
  }

  fetchDoctorApptDoctorList() async {
    try {
      DoctorApptDoctorListWrapper? response =
          await _repository.getApptDoctorList();
      if (response != null && response.listOfDoctors != null) {
        _doctorListWrapper = response;
      }
      update();
    } catch (error) {
      log("Error While fetching fetchUserApptDoctorList ${error.toString()}");
    }
  }

  fetchDoctorApptSlots(int doctorProfId) async {
    try {
      SlotListResponse? response =
          await _repository.getDoctorApptSlots(doctorProfId);
      if (response != null && response.slots != null) {
        _doctorApptSlotWrapper = response;
        _doctorApptSlotWrapper.slots!.sort(
          (a, b) => a.fromTime!.compareTo(b.fromTime!),
        );
      }
      update();
    } catch (error) {
      log("Error While fetching fetchDoctorApptSlots ${error.toString()}");
    }
  }

  fetchDoctorApptBookedSlots(int profId, String date) async {
    try {
      DoctorApptBookedSlotWrapper? response =
          await _repository.getDoctorApptBookedSlots(profId, date);
      if (response != null && response.bookedSlots != null) {
        _doctorApptBookedSlotWrapper = response;
      }
      update();
    } catch (error) {
      log("Error While fetching fetchDoctorApptBookedSlots ${error.toString()}");
    }
  }

  fetchUserApptList() async {
    try {
      UserApptListWrapper? response = await _repository.getUserApptList();
      if (response != null && response.userAppointments != null) {
        _userApptListWrapper = response;
        update();
      }
    } catch (error) {
      log("Error While fetching fetchUserApptList ${error.toString()}");
    }
  }

  fetchApptHospitalList() async {
    try {
      ApptHospitalListWrapper? response =
          await _repository.getApptHospitalList();
      if (response != null && response.hospitals != null) {
        _apptHospitalListWrapper = response;
      }
      update();
    } catch (error) {
      log("Error While fetching ApptHospitalList ${error.toString()}");
    }
  }

  fetchHospitalDepList(String hospitalName) async {
    int hospitalId = apptHospitals
            ?.where((element) => element.name == hospitalName)
            .first
            .id ??
        -1;
    try {
      HospitalDepartmentListWrapper? response =
          await _repository.getHospitalDepList(hospitalId);
      if (response != null && response.deps != null) {
        _departmentListWrapper = response;
        log("fetched! Length => ${_departmentListWrapper.deps?.length}");
      }
      update();
    } catch (error) {
      log("Error While fetching fetchHospitalDepList ${error.toString()}");
    }
  }

  postHospitalApptRequest(
    ApptSlotData daySlotData,
    HospitalDepData depData,
    DateTime apptDate,
  ) async {
    try {
      final model = HospitalApptRequestModel(
        title:
            "Appointment with ${depData.deptName} Scheduled at ${daySlotData.fromTime}",
        appointmentDate: DateFormat('yyyy-M-d').format(apptDate),
        appointmentTime: daySlotData.fromTime,
        appointmentType: daySlotData.appointmentType,
        note: "",
        isuploadedtoweb: 1,
        serverid: 0,
        slotTime: int.tryParse(daySlotData.slotTime ?? "0"),
        hosApptID: depData.compHospitalGymID.toString(),
        entityType: 1, // daySlotData.appointmentType,
        id: 0,
        insertDateTime: DateFormat("yyyy-M-d h:m:s").format(DateTime.now()),
        professionalID: depData.id,
        status: depData.apptApproval,
        doctorfirstName: depData.deptName,
        userID: _repository.storage.userId,
      );

      final response = await _repository.postApptRequest(model.toJson());
      log("postApptRequest res => $response");
      fetchUserApptList();
      return response;
    } catch (error) {
      log("Error While fetching fetchUserApptList ${error.toString()}");
      return null;
    }
  }

  postDoctorApptRequest(
    ApptSlotData aptSlot,
    DoctorApptDoctor doctor,
    String apptDate,
    String note,
  ) async {
    try {
      final profile = Get.find<ProfileController>().userProfile;
      final model = DoctorApptRequestModel(
        title:
            "Appointment with ${profile.firstName} Scheduled at ${aptSlot.fromTime}-${aptSlot.toTime}",
        appointmentDate: apptDate,
        appointmentTime: "${aptSlot.fromTime} - ${aptSlot.toTime}",
        appointmentType: aptSlot.appointmentType,
        note: note,
        isuploadedtoweb: 1,
        serverid: 0,
        slotTime: int.tryParse(aptSlot.slotTime ?? "0"),
        entityType: 0, //aptSlot.appointmentType,
        id: 0, //manual
        insertDateTime: DateFormat("yyyy-M-d h:m:s").format(DateTime.now()),
        professionalID: doctor.professionalID,
        status: 0,
        doctorfirstName: doctor.firstName,
        doctorlastName: doctor.lastName,
        userID: _repository.storage.userId,
      );

      final response = await _repository.postApptRequest(model.toJson());
      log("postApptRequest res => $response");
      fetchUserApptList();
      return response;
    } catch (error) {
      log("Error While fetching fetchUserApptList ${error.toString()}");
      return null;
    }
  }

  reqApptReschedule(
    UserApptModel apptModel,
    ApptSlotData slotData,
    DateTime newDate, [
    String? doctorApptNote,
  ]) async {
    try {
      final response = await _repository.postApptReschedule(apptModel);
      log("postApptReschedule res => $response");

      final hospitalId = int.tryParse(apptModel.hosApptID ?? "");
      if (hospitalId != null) {
        final listOfDeps = await _repository.getHospitalDepList(hospitalId);
        final depData = listOfDeps!.deps?.firstWhereOrNull(
            (element) => element.deptName == apptModel.deptName);

        final model = HospitalApptRequestModel(
          title:
              "Appointment with ${apptModel.deptName} Scheduled at ${slotData.fromTime}",
          appointmentDate: DateFormat('yyyy-M-d').format(newDate),
          appointmentTime: slotData.fromTime,
          appointmentType: slotData.appointmentType,
          note: "",
          isuploadedtoweb: 1,
          serverid: 0,
          slotTime: int.tryParse(slotData.slotTime ?? "0"),
          hosApptID: apptModel.hosApptID,
          entityType: 1,
          id: 0,
          insertDateTime: DateFormat("yyyy-M-d h:m:s").format(DateTime.now()),
          professionalID: slotData.professionalId,
          status: depData?.apptApproval,
          doctorfirstName: apptModel.doctorfirstName,
          userID: _repository.storage.userId,
        );
        await _repository.postApptRequest({
          ...model.toJson(),
          "note":
              "Rescheduled from Date: ${DateFormat("dd/MM/yyyy").format(DateFormat("yyyy-MM-dd").parse(apptModel.appointmentDate!))}, Time: ${apptModel.appointmentTime}",
        });
        Get.back();
        Get.rawSnackbar(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          backgroundColor: Colors.green,
          borderRadius: 6,
          title: "Congratulations!",
          message: "Appointment rescheduled!",
        );
      } else {
        final profile = Get.find<ProfileController>().userProfile;
        final model = DoctorApptRequestModel(
          title:
              "Appointment with ${profile.firstName} Scheduled at ${slotData.fromTime}-${slotData.toTime}",
          appointmentDate: DateFormat('yyyy-M-d').format(newDate),
          appointmentTime: "${slotData.fromTime} - ${slotData.toTime}",
          appointmentType: slotData.appointmentType,
          note: doctorApptNote,
          isuploadedtoweb: 1,
          serverid: 0,
          slotTime: int.tryParse(slotData.slotTime ?? "0"),
          entityType: 0, //aptSlot.appointmentType,
          id: 0,
          insertDateTime: DateFormat("yyyy-M-d h:m:s").format(DateTime.now()),
          professionalID: slotData.professionalId,
          status: 0,
          doctorfirstName: apptModel.doctorfirstName,
          doctorlastName: apptModel.doctorlastName,
          userID: _repository.storage.userId,
        );

        await _repository.postApptRequest(model.toJson());
        Get.back();
        Get.rawSnackbar(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          backgroundColor: Colors.green,
          borderRadius: 6,
          title: "Congratulations!",
          message: "Appointment rescheduled!",
        );
      }

      fetchUserApptList();
      return response;
    } catch (error, s) {
      log("Error While fetching postApptReschedule ${error.toString()}",
          error: error, stackTrace: s);
      return null;
    }
  }

  Future<bool?> reqApptCancel(int id) async {
    try {
      final response = await _repository.postApptCancel(id);
      log("reqApptCancel res => $response");
      fetchUserApptList();
      if (response ?? false) {
        Get.back();
      }
      return response;
    } catch (error) {
      log("Error While fetching reqApptCancel ${error.toString()}");
      return null;
    }
  }
}
