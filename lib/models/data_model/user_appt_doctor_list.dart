class DoctorApptDoctorListWrapper {
  int? error;
  String? authResponse;
  List<DoctorApptDoctor>? listOfDoctors;

  DoctorApptDoctorListWrapper(
      {this.error, this.authResponse, this.listOfDoctors});

  DoctorApptDoctorListWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      listOfDoctors = <DoctorApptDoctor>[];
      json['Data'].forEach((v) {
        listOfDoctors!.add(DoctorApptDoctor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (listOfDoctors != null) {
      jsonData['Data'] = listOfDoctors!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class DoctorApptDoctor {
  String? firstName;
  String? lastName;
  String? gender;
  String? username;
  String? token;
  String? phone;
  String? email;
  int? status;
  int? userID;
  int? professionalID;

  DoctorApptDoctor(
      {this.firstName,
      this.lastName,
      this.gender,
      this.username,
      this.token,
      this.phone,
      this.email,
      this.status,
      this.userID,
      this.professionalID});

  DoctorApptDoctor.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    username = json['username'];
    token = json['token'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
    userID = json['userID'];
    professionalID = json['professionalID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['firstName'] = firstName;
    jsonData['lastName'] = lastName;
    jsonData['gender'] = gender;
    jsonData['username'] = username;
    jsonData['token'] = token;
    jsonData['phone'] = phone;
    jsonData['email'] = email;
    jsonData['status'] = status;
    jsonData['userID'] = userID;
    jsonData['professionalID'] = professionalID;
    return jsonData;
  }
}
