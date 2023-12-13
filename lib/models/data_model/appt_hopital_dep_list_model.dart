class HospitalDepartmentListWrapper {
  int? error;
  String? authResponse;
  List<HospitalDepData>? deps;

  HospitalDepartmentListWrapper({this.error, this.authResponse, this.deps});

  HospitalDepartmentListWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      deps = <HospitalDepData>[];
      json['Data'].forEach((v) {
        deps!.add(HospitalDepData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (deps != null) {
      jsonData['Data'] = deps!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class HospitalDepData {
  int? id;
  int? compHospitalGymID;
  String? deptName;
  int? apptApproval;
  int? status;
  String? insertDateTime;
  int? dayBefore;
  String? timeOpen;
  int? weekDay;
  int? picID;

  HospitalDepData(
      {this.id,
      this.compHospitalGymID,
      this.deptName,
      this.apptApproval,
      this.status,
      this.insertDateTime,
      this.dayBefore,
      this.timeOpen,
      this.weekDay,
      this.picID});

  HospitalDepData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    compHospitalGymID = json['compHospitalGymID'];
    deptName = json['deptName'];
    apptApproval = json['apptApproval'];
    status = json['status'];
    insertDateTime = json['insertDateTime'];
    dayBefore = json['dayBefore'];
    timeOpen = json['timeOpen'];
    weekDay = json['weekDay'];
    picID = json['picID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['compHospitalGymID'] = compHospitalGymID;
    jsonData['deptName'] = deptName;
    jsonData['apptApproval'] = apptApproval;
    jsonData['status'] = status;
    jsonData['insertDateTime'] = insertDateTime;
    jsonData['dayBefore'] = dayBefore;
    jsonData['timeOpen'] = timeOpen;
    jsonData['weekDay'] = weekDay;
    jsonData['picID'] = picID;
    return jsonData;
  }
}
