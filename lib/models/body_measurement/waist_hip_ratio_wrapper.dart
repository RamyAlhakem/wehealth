class WaistHipRatioModel {
  int? error;
  String? authResponse;
  List<WaistHipRatioData>? waistHipRatioDataList;

  WaistHipRatioModel({this.error, this.authResponse, this.waistHipRatioDataList});

  WaistHipRatioModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      waistHipRatioDataList = <WaistHipRatioData>[];
      json['Data'].forEach((v) {
        waistHipRatioDataList!.add(new WaistHipRatioData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['authResponse'] = this.authResponse;
    if (this.waistHipRatioDataList != null) {
      data['Data'] = this.waistHipRatioDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WaistHipRatioData {
  int? waistcircumferenceid;
  int? userID;
  String? waistcircumference;
  String? insertiontime;
  String? hipcircumference;
  String? waisttohipratio;
  int? deviceStatus;
  String? notes;

  WaistHipRatioData(
      {this.waistcircumferenceid,
      this.userID,
      this.waistcircumference,
      this.insertiontime,
      this.hipcircumference,
      this.waisttohipratio,
      this.deviceStatus,
      this.notes});

  WaistHipRatioData.fromJson(Map<String, dynamic> json) {
    waistcircumferenceid = json['waistcircumferenceid'];
    userID = json['userID'];
    waistcircumference = json['waistcircumference'];
    insertiontime = json['insertiontime'];
    hipcircumference = json['hipcircumference'];
    waisttohipratio = json['waisttohipratio'];
    deviceStatus = json['deviceStatus'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['waistcircumferenceid'] = this.waistcircumferenceid;
    data['userID'] = this.userID;
    data['waistcircumference'] = this.waistcircumference;
    data['insertiontime'] = this.insertiontime;
    data['hipcircumference'] = this.hipcircumference;
    data['waisttohipratio'] = this.waisttohipratio;
    data['deviceStatus'] = this.deviceStatus;
    data['notes'] = this.notes;
    return data;
  }
}
