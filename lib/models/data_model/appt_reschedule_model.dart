class ApptRescheduleModel {
  String? appointmentDate;
  String? appointmentTime;
  int? apptID;
  String? entityType;
  String? picID;
  int? professionalID;
  int? status;

  ApptRescheduleModel(
      {this.appointmentDate,
      this.appointmentTime,
      this.apptID,
      this.entityType,
      this.picID,
      this.professionalID,
      this.status});

  ApptRescheduleModel.fromJson(Map<String, dynamic> json) {
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    apptID = json['apptID'];
    entityType = json['entityType'].toString();
    picID = json['picID'].toString();
    professionalID = json['professionalID'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> mapData = {};
    mapData['appointmentDate'] = appointmentDate;
    mapData['appointmentTime'] = appointmentTime;
    mapData['apptID'] = apptID;
    mapData['entityType'] = entityType;
    mapData['picID'] = picID;
    mapData['professionalID'] = professionalID;
    mapData['status'] = status;
    return mapData;
  }

  ApptRescheduleModel copyWith({
    String? appointmentDate,
    String? appointmentTime,
    int? apptID,
    String? entityType,
    String? picID,
    int? professionalID,
    int? status,
  }) {
    return ApptRescheduleModel(
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      apptID: apptID ?? this.apptID,
      entityType: entityType ?? this.entityType,
      picID: picID ?? this.picID,
      professionalID: professionalID ?? this.professionalID,
      status: status ?? this.status,
    );
  }
}
