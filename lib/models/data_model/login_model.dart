class LogInModel {
  int error;
  String authResponse;
  List<LoggedUser>? data;
  LogInModel({
    required this.error,
    required this.authResponse,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'error': error});
    result.addAll({'authResponse': authResponse});
    result.addAll({'data': data?.map((x) => x.toMap()).toList()});
    return result;
  }

  factory LogInModel.fromMap(Map<String, dynamic> map) {
    return LogInModel(
      error: map['error']?.toInt() ?? 1,
      authResponse: map['authResponse'] ?? '',
      data: map['data'] != null
          ? List<LoggedUser>.from(
              map['data']?.map((x) => LoggedUser.fromMap(x)))
          : null,
    );
  }
}

class LoggedUser {
  int? userId;
  String? username;
  String? token;
  String? realmpwd;
  String? email;
  String? role;
  int? questionnaire;
  String? firstName;
  String? lastName;
  String? gender;
  String? birthDate;
  String? height;
  String? weight;
  String? profilepic;
  String? address;
  String? town;
  String? state;
  String? country;
  String? postCode;
  String? mobileNumber;
  String? icNumber;
  String? loginType;
  int? userRole;
  String? cardname;
  String? name;
  String? status;

  LoggedUser({
    this.userId,
    this.username,
    this.token,
    this.realmpwd,
    this.email,
    this.role,
    this.questionnaire,
    this.firstName,
    this.lastName,
    this.gender,
    this.birthDate,
    this.height,
    this.weight,
    this.profilepic,
    this.address,
    this.town,
    this.state,
    this.country,
    this.postCode,
    this.mobileNumber,
    this.icNumber,
    this.loginType,
    this.userRole,
    this.cardname,
    this.name,
    this.status,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'username': username});
    result.addAll({'token': token});
    result.addAll({'realmpwd': realmpwd});
    result.addAll({'email': email});
    result.addAll({'role': role});
    result.addAll({'questionnaire': questionnaire});
    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'gender': gender});
    result.addAll({'birthDate': birthDate});
    result.addAll({'height': height});
    result.addAll({'weight': weight});
    result.addAll({'profilepic': profilepic});
    result.addAll({'address': address});
    result.addAll({'town': town});
    result.addAll({'state': state});
    result.addAll({'country': country});
    result.addAll({'postCode': postCode});
    result.addAll({'mobileNumber': mobileNumber});
    result.addAll({'icNumber': icNumber});
    result.addAll({'loginType': loginType});
    result.addAll({'userRole': userRole});
    result.addAll({'cardname': cardname});
    result.addAll({'name': name});
    result.addAll({'status': status});

    return result;
  }

  factory LoggedUser.fromMap(Map<String, dynamic> map) {
    return LoggedUser(
      userId: map['userID']?.toInt(),
      username: map['username'],
      token: map['token'],
      realmpwd: map['realmpwd'],
      email: map['email'],
      role: map['role'],
      questionnaire: map['questionnaire']?.toInt(),
      firstName: map['firstName'],
      lastName: map['lastName'],
      gender: map['gender'],
      birthDate: map['birthDate'],
      height: map['height'],
      weight: map['weight'],
      profilepic: map['profilepic'],
      address: map['address'],
      town: map['town'],
      state: map['state'],
      country: map['country'],
      postCode: map['postCode'],
      mobileNumber: map['mobileNumber'],
      icNumber: map['ic_number'],
      loginType: map['loginType'],
      userRole: map['userRole']?.toInt(),
      cardname: map['cardname'],
      name: map['name'],
      status: map['status'],
    );
  }
}
