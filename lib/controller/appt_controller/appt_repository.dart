import 'dart:convert';
import 'dart:developer' show log;
import 'package:flutter/foundation.dart' show immutable;
import 'package:intl/intl.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/http_cleint/api_clients.dart';
import 'package:wehealth/models/data_model/appt_clinic_day_slot_model.dart';
import 'package:wehealth/models/data_model/appt_hopital_dep_list_model.dart';
import 'package:wehealth/models/data_model/appt_hospital_list_model.dart';
import 'package:wehealth/models/data_model/appt_summary_model.dart';
import 'package:wehealth/models/data_model/doctor_appt_booked_slot.dart';
import 'package:wehealth/models/data_model/user_appt_doctor_list.dart';
import 'package:wehealth/models/data_model/user_appt_list_model.dart';

import '../../http_cleint/app_config.dart';

@immutable
class ApptRepository {
  const ApptRepository({required this.storage});

  final StorageController storage;
  final String baseUrl = AppConfig.baseUrl;

  int get userId => storage.userId;
  String get userToken => storage.userToken;
  String get userEmail => storage.email;
  String get userPassword => storage.password;

  Future<ApptSummaryWrapper?> getApptSummary(DateTime dateData) async {
    String date = DateFormat('yyyy-MM-dd').format(dateData);
    String url =
        "$baseUrl/getapptsummary?token=$userToken&userid=$userId&date=$date";
    try {
      var response = await ApiClients.getJson(url);

      if (response['error'] == 0) {
        ApptSummaryWrapper wrapper = ApptSummaryWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getApptSummary Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getApptSummary ${error.toString()}");
      return null;
    }
  }

  Future<UserApptListWrapper?> getUserApptList() async {
    String url = "$baseUrl/getUserAppointment?token=$userToken&userid=$userId";
    try {
      var response = await ApiClients.getJson(url);

      if (response['error'] == 0) {
        UserApptListWrapper wrapper = UserApptListWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getUserApptList Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getUserApptList ${error.toString()}");
      return null;
    }
  }

  Future<ApptHospitalListWrapper?> getApptHospitalList() async {
    String url = "$baseUrl/getHospitalApptList?token=$userToken&userid=$userId";
    try {
      var response = await ApiClients.getJson(url);

      if (response['error'] == 0) {
        ApptHospitalListWrapper wrapper =
            ApptHospitalListWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getApptHospitalList Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getApptHospitalList ${error.toString()}");
      return null;
    }
  }

  Future<HospitalDepartmentListWrapper?> getHospitalDepList(
      int hopitalId) async {
    String url =
        "$baseUrl/getDepartmentApptList?token=$userToken&userid=$userId&hospitalid=$hopitalId";
    try {
      var response = await ApiClients.getJson(url);

      if (response['error'] == 0) {
        HospitalDepartmentListWrapper wrapper =
            HospitalDepartmentListWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getHospitalDepList Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getHospitalDepList ${error.toString()}");
      return null;
    }
  }

  Future<SlotListResponse?> getClinicApptDaySlots(
      int entityId, DateTime apptDate) async {
    int entityType = 1;
    String date = DateFormat('yyyy-MM-dd').format(apptDate);
    String day = DateFormat('yyyy-MM-dd').format(DateTime.now());

    String url =
        "$baseUrl/getDoctorsScheduleByDay?token=${storage.userToken}&userid=${storage.userId}&entityid=$entityId&entityType=$entityType&day=$day&date=$date";
    try {
      var response = await ApiClients.getJson(url);
      log(response.toString());
      if (response['error'] == 0) {
        SlotListResponse wrapper =
            SlotListResponse.fromJson(response);
        // log(response);
        return wrapper;
      } else {
        log("getClinicApptDaySlots Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getClinicApptDaySlots ${error.toString()}");
      return null;
    }
  }

  Future<ApptClinicDaySlotsStatusWrapper?> getClinicApptDaySlotsStatus(
      int professionalId, DateTime apptDate) async {
    String apptDateString = DateFormat('yyyy-MM-dd').format(apptDate);

    String url =
        "$baseUrl/getBookedAppointment?token=${storage.userToken}&userid=${storage.userId}&professionalID=$professionalId&appointmentDate=$apptDateString";
    try {
      var response = await ApiClients.getJson(url);
      log(url);
      if (response['error'] == 0) {
        ApptClinicDaySlotsStatusWrapper wrapper =
            ApptClinicDaySlotsStatusWrapper.fromJson(response);

        return wrapper;
      } else {
        log("getClinicApptDaySlotsStatus Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getClinicApptDaySlotsStatus ${error.toString()}");
      return null;
    }
  }

  Future<bool?> postApptRequest(Map<String, dynamic> requestModel) async {
    String url = "$baseUrl/adduserprofessionalappointment";

    final data = {
      "userid": {storage.userId},
      "token": {storage.userToken},
      "data": json.encode([requestModel]),
    };

    try {
      var response = await ApiClients.postFormUrlEncodedData(data, url);

      if (response['error'] == 0) {
        return true;
      } else {
        log("postApptRequest Status => ${response['error']}!");
        return false;
      }
    } catch (error) {
      log("Error While fetching postApptRequest ${error.toString()}");
      return null;
    }
  }

  Future<bool?> postApptReschedule(UserApptModel requestModel) async {
    String url = "$baseUrl/cancelrescheduleappointment";
    final apptData = {
      "appointmentDate": requestModel.appointmentDate,
      "appointmentTime": requestModel.appointmentTime,
      "apptID": requestModel.id,
      "entityType": requestModel.entityType,
      "picID": requestModel.picID,
      "professionalID": requestModel.professionalID,
      "status": 7
    };

    final data = {
      "userid": storage.userId,
      "token": storage.userToken,
      "data": json.encode([apptData]),
    };

    log('Final reschedule model => ${data.toString()}');

    try {
      var response = await ApiClients.postFormUrlEncodedData(data, url);
      log('Reschedule res => ${response.toString()}');
      if (response['error'] == 0) {
        return true;
      } else {
        log("postApptReschedule Status => $response!");
        return false;
      }
    } catch (error) {
      log("Error While fetching postApptReschedule ${error.toString()}");
      return null;
    }
  }

  Future<bool?> postApptCancel(int requestModel) async {
    String url = "$baseUrl/cancelAppointment";

    final data = {
      "userid": storage.userId,
      "token": storage.userToken,
      "data": json.encode([{"id": requestModel}]),
    };

    try {
      var response = await ApiClients.postFormUrlEncodedData(data, url);

      if (response['error'] == 0) {
        return true;
      } else {
        log("postApptCancel Status => ${response['error']}!");
        return false;
      }
    } catch (error) {
      log("Error While fetching postApptCancel ${error.toString()}");
      return null;
    }
  }

  Future<DoctorApptDoctorListWrapper?> getApptDoctorList() async {
    String url = "$baseUrl/getListOfDoctors?token=$userToken&userid=$userId";
    try {
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {
        DoctorApptDoctorListWrapper wrapper =
            DoctorApptDoctorListWrapper.fromJson(response);

        return wrapper;
      } else {
        log("getApptDoctorList Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getApptDoctorList ${error.toString()}");
      return null;
    }
  }

  Future<SlotListResponse?> getDoctorApptSlots(int doctorProfId) async {
    String url =
        "$baseUrl/getDoctorsSchedule?professionalID=$doctorProfId&token=$userToken";
    try {
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {
        SlotListResponse wrapper =
            SlotListResponse.fromJson(response);
        return wrapper;
      } else {
        log("getDoctorApptSlots Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getDoctorApptSlots ${error.toString()}");
      return null;
    }
  }

  Future<DoctorApptBookedSlotWrapper?> getDoctorApptBookedSlots(
      int doctorProfId, String date) async {
    String url =
        "$baseUrl/getBookedAppointment?userid=$userId&token=$userToken&appointmentDate=$date&professionalID=$doctorProfId";
    try {
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {
        DoctorApptBookedSlotWrapper wrapper =
            DoctorApptBookedSlotWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getDoctorApptBookedSlots Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getDoctorApptBookedSlots ${error.toString()}");
      return null;
    }
  }
}
