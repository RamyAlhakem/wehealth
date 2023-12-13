import 'dart:developer';

class UserProfileWrapper {
  int? error;
  String? authResponse;
  List<UserProfile>? data = [];

  UserProfileWrapper({this.error, this.authResponse, this.data});

  UserProfileWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      data = <UserProfile>[];
      json['Data'].forEach((v) {
        data!.add(UserProfile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['error'] = error;
    data['authResponse'] = authResponse;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserProfile {
  int? userID;
  String? icNumber;
  String? loginType;
  String? username;
  String? realmpwd;
  String? email;
  String? phone;
  String? cardName;
  String? lifestyle;
  int? questionnaire;
  String? firstName;
  String? lastName;
  String? gender;
  String? birthDate;
  String? height;
  String? heightUnit;
  String? weight;
  String? profilepic;
  String? address;
  String? town;
  String? state;
  String? country;
  String? postCode;
  String? mobileNumber;
  String? version;
  int? age;
  String? marital;
  String? smoking;
  String? race;
  String? eduction;

  UserProfile(
      {this.userID,
      this.icNumber,
      this.loginType,
      this.username,
      this.realmpwd,
      this.email,
      this.phone,
      this.cardName,
      this.lifestyle,
      this.questionnaire,
      this.firstName,
      this.lastName,
      this.gender,
      this.birthDate,
      this.height,
      this.heightUnit,
      this.weight,
      this.profilepic,
      this.address,
      this.town,
      this.state,
      this.country,
      this.postCode,
      this.mobileNumber,
      this.version,
      this.age,
      this.marital,
      this.smoking,
      this.race,
      this.eduction});

  UserProfile.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    userID = json['userID'];
    icNumber = json['ic_number'];
    loginType = json['loginType'];
    username = json['username'];
    realmpwd = json['realmpwd'];
    email = json['email'];
    phone = json['phone'];
    cardName = json['cardname'];
    lifestyle = json['lifestyle'];
    questionnaire = json['questionnaire'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    height = json['height'];
    heightUnit = json['height_unit'];
    weight = json['weight'];
    profilepic = json['profilepic'];
    address = json['address'];
    town = json['town'];
    state = json['state'];
    country = json['country'];
    postCode = json['postCode'];
    mobileNumber = json['mobileNumber'];
    version = json['version'];
    age = json['age'];
    marital = json['marital'];
    smoking = json['smoking'];
    race = json['race'];
    eduction = json['Eduction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['ic_number'] = icNumber;
    data['loginType'] = loginType;
    data['username'] = username;
    data['realmpwd'] = realmpwd;
    data['email'] = email;
    data['phone'] = phone;
    data['cardname'] = cardName;
    data['lifestyle'] = lifestyle;
    data['questionnaire'] = questionnaire;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['birthDate'] = birthDate;
    data['height'] = height;
    data['height_unit'] = heightUnit;
    data['weight'] = weight;
    data['profilepic'] = profilepic;
    data['address'] = address;
    data['town'] = town;
    data['state'] = state;
    data['country'] = country;
    data['postCode'] = postCode;
    data['mobileNumber'] = mobileNumber;
    data['version'] = version;
    data['age'] = age;
    data['marital'] = marital;
    data['smoking'] = smoking;
    data['race'] = race;
    data['Eduction'] = eduction;
    return data;
  }

  UserProfile copyWith({
    int? userID,
    String? icNumber,
    String? loginType,
    String? username,
    String? realmpwd,
    String? email,
    String? phone,
    int? questionnaire,
    String? firstName,
    String? lastName,
    String? gender,
    String? birthDate,
    String? height,
    String? heightUnit,
    String? weight,
    String? profilepic,
    String? address,
    String? town,
    String? state,
    String? country,
    String? postCode,
    String? mobileNumber,
    String? version,
    int? age,
    String? marital,
    String? smoking,
    String? race,
    String? eduction,
  }) {
    return UserProfile(
      userID: userID ?? this.userID,
      icNumber: icNumber ?? this.icNumber,
      loginType: loginType ?? this.loginType,
      username: username ?? this.username,
      realmpwd: realmpwd ?? this.realmpwd,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      questionnaire: questionnaire ?? this.questionnaire,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      height: height ?? this.height,
      heightUnit: heightUnit ?? this.heightUnit,
      weight: weight ?? this.weight,
      profilepic: profilepic ?? this.profilepic,
      address: address ?? this.address,
      town: town ?? this.town,
      state: state ?? this.state,
      country: country ?? this.country,
      postCode: postCode ?? this.postCode,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      version: version ?? this.version,
      age: age ?? this.age,
      marital: marital ?? this.marital,
      smoking: smoking ?? this.smoking,
      race: race ?? this.race,
      eduction: eduction ?? this.eduction,
    );
  }
}
