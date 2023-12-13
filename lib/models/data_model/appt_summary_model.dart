class ApptSummaryWrapper {
  int? error;
  String? authResponse;
  List<ApptSummaryModel>? history;
  bool? custom;

  ApptSummaryWrapper(
      {this.error, this.authResponse, this.history, this.custom});

  ApptSummaryWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      history = <ApptSummaryModel>[];
      json['Data'].forEach((item) {
        history!.add(ApptSummaryModel.fromJson(item));
      });
    }
    custom = json['Custom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['authResponse'] = authResponse;
    if (history != null) {
      data['Data'] = history!.map((v) => v.toJson()).toList();
    }
    data['Custom'] = custom;
    return data;
  }
}

class ApptSummaryModel {
  int? id;
  int? professionalId;
  String? day;
  String? fromTime;
  String? toTime;
  String? slotTime;
  String? insertationDatetime;
  int? slotPerson;
  int? appointmentType;
  int? entityType;
  int? bookedApptCount;

  ApptSummaryModel(
      {this.id,
      this.professionalId,
      this.day,
      this.fromTime,
      this.toTime,
      this.slotTime,
      this.insertationDatetime,
      this.slotPerson,
      this.appointmentType,
      this.entityType,
      this.bookedApptCount});

  ApptSummaryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    professionalId = json['ProfessionalId'];
    day = json['Day'];
    fromTime = json['FromTime'];
    toTime = json['ToTime'];
    slotTime = json['SlotTime'];
    insertationDatetime = json['InsertationDatetime'];
    slotPerson = json['SlotPerson'];
    appointmentType = json['appointmentType'];
    entityType = json['entityType'];
    bookedApptCount = json['bookedApptCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ProfessionalId'] = professionalId;
    data['Day'] = day;
    data['FromTime'] = fromTime;
    data['ToTime'] = toTime;
    data['SlotTime'] = slotTime;
    data['InsertationDatetime'] = insertationDatetime;
    data['SlotPerson'] = slotPerson;
    data['appointmentType'] = appointmentType;
    data['entityType'] = entityType;
    data['bookedApptCount'] = bookedApptCount;
    return data;
  }
}
