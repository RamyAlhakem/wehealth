class UserMedicineStatusWrapper {
  int? error;
  String? authResponse;
  List<MedicineStatusModel>? medicineStatusData;

  UserMedicineStatusWrapper(
      {this.error, this.authResponse, this.medicineStatusData});

  UserMedicineStatusWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      medicineStatusData = <MedicineStatusModel>[];
      json['Data'].forEach((v) {
        medicineStatusData!.add(MedicineStatusModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (medicineStatusData != null) {
      jsonData['Data'] = medicineStatusData!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class MedicineStatusModel {
  int? id;
  int? myMedicineID;
  int? userID;
  int? status;
  String? dateTime;
  String? insertDateTime;
  String? timeTaken;
  String? reason;

  MedicineStatusModel(
      {this.id,
      this.myMedicineID,
      this.userID,
      this.status,
      this.dateTime,
      this.insertDateTime,
      this.timeTaken,
      this.reason});

  MedicineStatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    myMedicineID = json['myMedicineID'];
    userID = json['userID'];
    status = json['status'];
    dateTime = json['dateTime'];
    insertDateTime = json['insertDateTime'];
    timeTaken = json['timeTaken'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['myMedicineID'] = myMedicineID;
    jsonData['userID'] = userID;
    jsonData['status'] = status;
    jsonData['dateTime'] = dateTime;
    jsonData['insertDateTime'] = insertDateTime;
    jsonData['timeTaken'] = timeTaken;
    jsonData['reason'] = reason;
    return jsonData;
  }
}
