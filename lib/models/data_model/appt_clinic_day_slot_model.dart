class SlotListResponse {
  int? error;
  String? authResponse;
  List<ApptSlotData>? slots;

  SlotListResponse({this.error, this.authResponse, this.slots});

  SlotListResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      slots = <ApptSlotData>[];
      json['Data'].forEach((v) {
        slots!.add(ApptSlotData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (slots != null) {
      jsonData['Data'] = slots!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class ApptSlotData {
  int? id;
  int? professionalId;
  int? appointmentType;
  int? entityType;
  int? slotPerson;
  String? day;
  String? fromTime;
  String? toTime;
  String? slotTime;
  String? insertationDatetime;
  /// Comes [null] most of the time.
  String? apptDate;

  ApptSlotData(
      {this.id,
      this.professionalId,
      this.day,
      this.fromTime,
      this.toTime,
      this.slotTime,
      this.insertationDatetime,
      this.appointmentType,
      this.entityType,
      this.apptDate,
      this.slotPerson});

  ApptSlotData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    professionalId = json['ProfessionalId'];
    day = json['Day'];
    fromTime = json['FromTime'];
    toTime = json['ToTime'];
    slotTime = json['SlotTime'];
    insertationDatetime = json['InsertationDatetime'];
    appointmentType = json['appointmentType'];
    entityType = json['entityType'];
    apptDate = json['apptDate'];
    slotPerson = json['SlotPerson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['ProfessionalId'] = professionalId;
    jsonData['Day'] = day;
    jsonData['FromTime'] = fromTime;
    jsonData['ToTime'] = toTime;
    jsonData['SlotTime'] = slotTime;
    jsonData['InsertationDatetime'] = insertationDatetime;
    jsonData['appointmentType'] = appointmentType;
    jsonData['entityType'] = entityType;
    jsonData['apptDate'] = apptDate;
    jsonData['SlotPerson'] = slotPerson;
    return jsonData;
  }
}

class ApptClinicDaySlotsStatusWrapper {
  int? error;
  List<DayBookedSlotsData>? bookedSlotsList;
  String? authResponse;

  ApptClinicDaySlotsStatusWrapper(
      {this.error, this.bookedSlotsList, this.authResponse});

  ApptClinicDaySlotsStatusWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['Data'] != null) {
      bookedSlotsList = <DayBookedSlotsData>[];
      json['Data'].forEach((v) {
        bookedSlotsList!.add(DayBookedSlotsData.fromJson(v));
      });
    }
    authResponse = json['authResponse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    if (bookedSlotsList != null) {
      jsonData['Data'] = bookedSlotsList!.map((v) => v.toJson()).toList();
    }
    jsonData['authResponse'] = authResponse;
    return jsonData;
  }
}

class DayBookedSlotsData {
  int? professionalScheduleID;
  int? appointmentCount;
  String? appointmentTime;
  int? slotPerson;

  DayBookedSlotsData(
      {this.professionalScheduleID,
      this.appointmentCount,
      this.appointmentTime,
      this.slotPerson});

  DayBookedSlotsData.fromJson(Map<String, dynamic> json) {
    professionalScheduleID = json['ProfessionalScheduleID'];
    appointmentCount = json['appointmentCount'];
    appointmentTime = json['appointmentTime'];
    slotPerson = json['SlotPerson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['ProfessionalScheduleID'] = professionalScheduleID;
    jsonData['appointmentCount'] = appointmentCount;
    jsonData['appointmentTime'] = appointmentTime;
    jsonData['SlotPerson'] = slotPerson;
    return jsonData;
  }
}
