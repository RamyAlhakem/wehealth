class UserHospitalRelationWrapper {
  int? error;
  String? authResponse;
  List<UserHospitalRelation>? relationData;

  UserHospitalRelationWrapper(
      {this.error, this.authResponse, this.relationData});

  UserHospitalRelationWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      relationData = <UserHospitalRelation>[];
      json['Data'].forEach((v) {
        relationData!.add(UserHospitalRelation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (relationData != null) {
      jsonData['Data'] = relationData!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class UserHospitalRelation {
  int? id;
  int? compHospitalGymID;
  int? userID;
  String? refID;
  String? insertDateTime;

  UserHospitalRelation(
      {this.id,
      this.compHospitalGymID,
      this.userID,
      this.refID,
      this.insertDateTime});

  UserHospitalRelation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    compHospitalGymID = json['compHospitalGymID'];
    userID = json['userID'];
    refID = json['refID'];
    insertDateTime = json['insertDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['compHospitalGymID'] = compHospitalGymID;
    jsonData['userID'] = userID;
    jsonData['refID'] = refID;
    jsonData['insertDateTime'] = insertDateTime;
    return jsonData;
  }
}
