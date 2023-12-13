class WaistCircumferenceResponseWrapper {
  int? error;
  String? authResponse;
  List<WaistCircumferenceData>? dataList;

  WaistCircumferenceResponseWrapper(
      {this.error, this.authResponse, this.dataList});

  WaistCircumferenceResponseWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      dataList = <WaistCircumferenceData>[];
      json['Data'].forEach((v) {
        dataList!.add(WaistCircumferenceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> mapData = {};
    mapData['error'] = error;
    mapData['authResponse'] = authResponse;
    if (dataList != null) {
      mapData['Data'] = dataList!.map((v) => v.toJson()).toList();
    }
    return mapData;
  }
}

class WaistCircumferenceData {
  int? waistcircumferenceid;
  int? userID;
  String? waistcircumference;
  String? insertiontime;
  String? hipcircumference;
  String? waisttohipratio;
  int? deviceStatus;
  String? notes;

  WaistCircumferenceData(
      {this.waistcircumferenceid,
      this.userID,
      this.waistcircumference,
      this.insertiontime,
      this.hipcircumference,
      this.waisttohipratio,
      this.deviceStatus,
      this.notes});

  WaistCircumferenceData.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> mapData = {};
    mapData['waistcircumferenceid'] = waistcircumferenceid;
    mapData['userID'] = userID;
    mapData['waistcircumference'] = waistcircumference;
    mapData['insertiontime'] = insertiontime;
    mapData['hipcircumference'] = hipcircumference;
    mapData['waisttohipratio'] = waisttohipratio;
    mapData['deviceStatus'] = deviceStatus;
    mapData['notes'] = notes;
    return mapData;
  }
}
