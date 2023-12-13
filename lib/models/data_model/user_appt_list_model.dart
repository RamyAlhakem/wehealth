class UserApptListWrapper {
  int? error;
  String? authResponse;
  List<UserApptModel>? userAppointments;

  UserApptListWrapper({this.error, this.authResponse, this.userAppointments});

  UserApptListWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      userAppointments = <UserApptModel>[];
      json['Data'].forEach((v) {
        userAppointments!.add(UserApptModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['authResponse'] = authResponse;
    if (userAppointments != null) {
      data['Data'] = userAppointments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserApptModel {
  int? id;
  int? userID;
  int? professionalID;
  String? appointmentDate;
  String? appointmentTime;
  String? title;
  String? note;
  int? appointmentType;
  int? status;
  String? disclaimer;
  int? slotTime;
  String? hosApptID;
  int? entityType;
  String? twilioRoom;
  String? insertDateTime;
  String? updateDateTime;
  String? email;
  String? doctorfirstName;
  String? doctorlastName;
  String? deptName;
  int? dayBefore;
  int? weekDay;
  String? timeOpen;
  int? picID;
  String? picEmail;
  String? patientName;

  UserApptModel(
      {this.id,
      this.userID,
      this.professionalID,
      this.appointmentDate,
      this.appointmentTime,
      this.title,
      this.note,
      this.appointmentType,
      this.status,
      this.disclaimer,
      this.slotTime,
      this.hosApptID,
      this.entityType,
      this.twilioRoom,
      this.insertDateTime,
      this.updateDateTime,
      this.email,
      this.doctorfirstName,
      this.doctorlastName,
      this.deptName,
      this.dayBefore,
      this.weekDay,
      this.timeOpen,
      this.picID,
      this.picEmail,
      this.patientName});

  UserApptModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    professionalID = json['professionalID'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    title = json['Title'];
    note = json['note'];
    appointmentType = json['appointmentType'];
    status = json['status'];
    disclaimer = json['disclaimer'];
    slotTime = json['slotTime'];
    hosApptID = json['hos_apptID'];
    entityType = json['entityType'];
    twilioRoom = json['twilioRoom'];
    insertDateTime = json['insertDateTime'];
    updateDateTime = json['updateDateTime'];
    email = json['email'];
    doctorfirstName = json['DoctorfirstName'];
    doctorlastName = json['DoctorlastName'];
    deptName = json['deptName'];
    dayBefore = json['dayBefore'];
    weekDay = json['weekDay'];
    timeOpen = json['timeOpen'];
    picID = json['picID'];
    picEmail = json['picEmail'];
    patientName = json['patientName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userID'] = userID;
    data['professionalID'] = professionalID;
    data['appointmentDate'] = appointmentDate;
    data['appointmentTime'] = appointmentTime;
    data['Title'] = title;
    data['note'] = note;
    data['appointmentType'] = appointmentType;
    data['status'] = status;
    data['disclaimer'] = disclaimer;
    data['slotTime'] = slotTime;
    data['hos_apptID'] = hosApptID;
    data['entityType'] = entityType;
    data['twilioRoom'] = twilioRoom;
    data['insertDateTime'] = insertDateTime;
    data['updateDateTime'] = updateDateTime;
    data['email'] = email;
    data['DoctorfirstName'] = doctorfirstName;
    data['DoctorlastName'] = doctorlastName;
    data['deptName'] = deptName;
    data['dayBefore'] = dayBefore;
    data['weekDay'] = weekDay;
    data['timeOpen'] = timeOpen;
    data['picID'] = picID;
    data['picEmail'] = picEmail;
    data['patientName'] = patientName;
    return data;
  }
}
