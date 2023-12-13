class RegistrationModel {
  int error;
  String authResponse;
  List<RegisterUser>? data;
  RegistrationModel({
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

  factory RegistrationModel.fromMap(Map<String, dynamic> map) {
    return RegistrationModel(
      error: map['error']?.toInt() ?? 0,
      authResponse: map['authResponse'] ?? '',
      data: map['data'] != null
          ? List<RegisterUser>.from(
              map['data']?.map((x) => RegisterUser.fromMap(x)))
          : null,
    );
  }
}

class RegisterUser {
  int userId;
  String token;
  String realmpwd;
  RegisterUser({
    required this.userId,
    required this.token,
    required this.realmpwd,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'token': token});
    result.addAll({'realmpwd': realmpwd});

    return result;
  }

  factory RegisterUser.fromMap(Map<String, dynamic> map) {
    return RegisterUser(
      userId: map['userId']?.toInt() ?? 0,
      token: map['token'] ?? '',
      realmpwd: map['realmpwd'] ?? '',
    );
  }
}
