class HospitalApptRequestModel {
  String? doctorfirstName;
  String? title;
  String? appointmentDate;
  String? appointmentTime;
  int? appointmentType;
  int? entityType;
  String? hosApptID;
  int? id;
  String? insertDateTime;
  int? isuploadedtoweb;
  String? note;
  int? professionalID;
  int? serverid;
  int? slotTime;
  int? status;
  int? userID;

  HospitalApptRequestModel(
      {this.doctorfirstName,
      this.title,
      this.appointmentDate,
      this.appointmentTime,
      this.appointmentType,
      this.entityType,
      this.hosApptID,
      this.id,
      this.insertDateTime,
      this.isuploadedtoweb,
      this.note,
      this.professionalID,
      this.serverid,
      this.slotTime,
      this.status,
      this.userID});

  HospitalApptRequestModel.fromJson(Map<String, dynamic> json) {
    doctorfirstName = json['DoctorfirstName'];
    title = json['Title'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    appointmentType = json['appointmentType'];
    entityType = json['entityType'];
    hosApptID = json['hos_apptID'];
    id = json['id'];
    insertDateTime = json['insertDateTime'];
    isuploadedtoweb = json['isuploadedtoweb'];
    note = json['note'];
    professionalID = json['professionalID'];
    serverid = json['serverid'];
    slotTime = json['slotTime'];
    status = json['status'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['DoctorfirstName'] = doctorfirstName;
    jsonData['Title'] = title;
    jsonData['appointmentDate'] = appointmentDate;
    jsonData['appointmentTime'] = appointmentTime;
    jsonData['appointmentType'] = appointmentType;
    jsonData['entityType'] = entityType;
    jsonData['hos_apptID'] = hosApptID;
    jsonData['id'] = id;
    jsonData['insertDateTime'] = insertDateTime;
    jsonData['isuploadedtoweb'] = isuploadedtoweb;
    jsonData['note'] = note;
    jsonData['professionalID'] = professionalID;
    jsonData['serverid'] = serverid;
    jsonData['slotTime'] = slotTime;
    jsonData['status'] = status;
    jsonData['userID'] = userID;
    return jsonData;
  }

  HospitalApptRequestModel copyWith({
    String? doctorfirstName,
    String? title,
    String? appointmentDate,
    String? appointmentTime,
    int? appointmentType,
    int? entityType,
    String? hosApptID,
    int? id,
    String? insertDateTime,
    int? isuploadedtoweb,
    String? note,
    int? professionalID,
    int? serverid,
    int? slotTime,
    int? status,
    int? userID,
  }) {
    return HospitalApptRequestModel(
      doctorfirstName: doctorfirstName ?? this.doctorfirstName,
      title: title ?? this.title,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      appointmentType: appointmentType ?? this.appointmentType,
      entityType: entityType ?? this.entityType,
      hosApptID: hosApptID ?? this.hosApptID,
      id: id ?? this.id,
      insertDateTime: insertDateTime ?? this.insertDateTime,
      isuploadedtoweb: isuploadedtoweb ?? this.isuploadedtoweb,
      note: note ?? this.note,
      professionalID: professionalID ?? this.professionalID,
      serverid: serverid ?? this.serverid,
      slotTime: slotTime ?? this.slotTime,
      status: status ?? this.status,
      userID: userID ?? this.userID,
    );
  }
}

class DoctorApptRequestModel {
  String? doctorfirstName;
  String? doctorlastName;
  String? title;
  String? appointmentDate;
  String? appointmentTime;
  int? appointmentType;
  int? entityType;
  int? id;
  String? insertDateTime;
  int? isuploadedtoweb;
  String? note;
  int? professionalID;
  int? serverid;
  int? slotTime;
  int? status;
  int? userID;

  DoctorApptRequestModel(
      {this.doctorfirstName,
      this.doctorlastName,
      this.title,
      this.appointmentDate,
      this.appointmentTime,
      this.appointmentType,
      this.entityType,
      this.id,
      this.insertDateTime,
      this.isuploadedtoweb,
      this.note,
      this.professionalID,
      this.serverid,
      this.slotTime,
      this.status,
      this.userID});

  DoctorApptRequestModel.fromJson(Map<String, dynamic> json) {
    doctorfirstName = json['DoctorfirstName'];
    doctorlastName = json['DoctorlastName'];
    title = json['Title'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    appointmentType = json['appointmentType'];
    entityType = json['entityType'];
    id = json['id'];
    insertDateTime = json['insertDateTime'];
    isuploadedtoweb = json['isuploadedtoweb'];
    note = json['note'];
    professionalID = json['professionalID'];
    serverid = json['serverid'];
    slotTime = json['slotTime'];
    status = json['status'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['DoctorfirstName'] = doctorfirstName;
    jsonData['DoctorlastName'] = doctorlastName;
    jsonData['Title'] = title;
    jsonData['appointmentDate'] = appointmentDate;
    jsonData['appointmentTime'] = appointmentTime;
    jsonData['appointmentType'] = appointmentType;
    jsonData['entityType'] = entityType;
    jsonData['id'] = id;
    jsonData['insertDateTime'] = insertDateTime;
    jsonData['isuploadedtoweb'] = isuploadedtoweb;
    jsonData['note'] = note;
    jsonData['professionalID'] = professionalID;
    jsonData['serverid'] = serverid;
    jsonData['slotTime'] = slotTime;
    jsonData['status'] = status;
    jsonData['userID'] = userID;
    return jsonData;
  }
}
