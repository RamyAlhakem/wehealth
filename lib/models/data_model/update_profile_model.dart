class UpdateProfileModel {
  int? age;
  String? birthDate;
  String? cardname;
  String? education;
  String? email;
  String? firstName;
  String? gender;
  String? height;
  String? icNumber;
  String? imagePath;
  int? isActive;
  int? isMonash;
  String? lastName;
  String? lifestyle;
  int? loginType;
  String? marital;
  String? password;
  String? phone;
  int? questionnaire;
  String? race;
  String? smoking;
  String? stride;
  String? token;
  String? address;
  String? town;
  String? country;
  int? userID;
  String? state;
  String? postCode;
  String? username;
  int? usertype;
  String? version;
  String? weight;

  UpdateProfileModel({
    this.age,
    this.birthDate,
    this.cardname,
    this.education,
    this.email,
    this.firstName,
    this.gender,
    this.height,
    this.icNumber,
    this.imagePath,
    this.isActive,
    this.isMonash,
    this.lastName,
    this.lifestyle,
    this.loginType,
    this.marital,
    this.password,
    this.phone,
    this.questionnaire,
    this.race,
    this.smoking,
    this.stride,
    this.token,
    this.address,
    this.town,
    this.country,
    this.userID,
    this.state,
    this.postCode,
    this.username,
    this.usertype,
    this.version,
    this.weight,
  });

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    birthDate = json['birthDate'];
    cardname = json['cardname'];
    education = json['education'];
    email = json['email'];
    firstName = json['firstName'];
    gender = json['gender'];
    height = json['height'];
    icNumber = json['ic_number'];
    imagePath = json['imagePath'];
    isActive = json['isActive'];
    isMonash = json['isMonash'];
    lastName = json['lastName'];
    lifestyle = json['lifestyle'];
    lifestyle = json['interest'];
    loginType = json['loginType'];
    marital = json['marital'];
    password = json['password'];
    phone = json['phone'];
    questionnaire = json['questionnaire'];
    race = json['race'];
    smoking = json['smoking'];
    stride = json['stride'];
    token = json['token'];
    address = json['address'];
    town = json['town'];
    country = json['country'];
    userID = json['userID'];
    state = json['state'];
    postCode = json['postCode'];
    username = json['username'];
    usertype = json['usertype'];
    version = json['version'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['age'] = age;
    data['birthDate'] = birthDate;
    data['cardname'] = cardname;
    data['education'] = education;
    data['email'] = email;
    data['firstName'] = firstName;
    data['gender'] = gender;
    data['height'] = height;
    data['ic_number'] = icNumber;
    data['imagePath'] = imagePath;
    data['isActive'] = isActive;
    data['isMonash'] = isMonash;
    data['lastName'] = lastName;
    data['lifestyle'] = lifestyle;
    data['interest'] = lifestyle;
    data['loginType'] = loginType;
    data['marital'] = marital;
    data['password'] = password;
    data['phone'] = phone;
    data['questionnaire'] = questionnaire;
    data['race'] = race;
    data['smoking'] = smoking;
    data['stride'] = stride;
    data['token'] = token;
    data['address'] = address;
    data['town'] = town;
    data['country'] = country;
    data['userID'] = userID;
    data['state'] = state;
    data['postCode'] = postCode;
    data['username'] = username;
    data['usertype'] = usertype;
    data['version'] = version;
    data['weight'] = weight;
    return data;
  }
}
