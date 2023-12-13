class DoctorListWrapper {
  int? error;
  String? authResponse;
  List<UserDoctorModel>? doctorsList;

  DoctorListWrapper({this.error, this.authResponse, this.doctorsList});

  DoctorListWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      doctorsList = <UserDoctorModel>[];
      json['Data'].forEach((v) {
        doctorsList!.add(UserDoctorModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (doctorsList != null) {
      jsonData['Data'] = doctorsList!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class UserDoctorModel {
  String? firstName;
  String? lastName;
  String? gender;
  String? username;
  String? token;
  String? phone;
  String? email;
  int? status;
  int? professionalID;

  String get statusString {
    switch (status ?? -1) {
      case 0:
        return "Pending Authentication";
      case 1:
        return "Pending Doctor";
      case 2:
        return "Active";
      case 3:
        return "Doctor Rejected";
      case 4:
        return "Patient Rejected";
      default:
        return "Unknown";
    }
  }

  UserDoctorModel(
      {this.firstName,
      this.lastName,
      this.gender,
      this.username,
      this.token,
      this.phone,
      this.email,
      this.status,
      this.professionalID});

  UserDoctorModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    username = json['username'];
    token = json['token'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
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
    jsonData['professionalID'] = professionalID;
    return jsonData;
  }
}
