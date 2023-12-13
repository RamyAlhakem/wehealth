import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';

class HeartRateFetchWrapper {
  int? error;
  String? authResponse;
  List<HeartRateFetchModel>? heartRateData;

  HeartRateFetchWrapper({this.error, this.authResponse, this.heartRateData});

  HeartRateFetchWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      heartRateData = <HeartRateFetchModel>[];
      json['Data'].forEach((v) {
        heartRateData!.add(HeartRateFetchModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (heartRateData != null) {
      jsonData['Data'] = heartRateData!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class HeartRateFetchModel {
  int? heartRateID;
  int? userID;
  int? heartRateQty;
  String? recordDateTime;
  int? deviceStatus;
  int? heartRateType;
  String? deviceuuid;
  String? deviceid;

  HeartRateFetchModel(
      {heartRateID,
      userID,
      heartRateQty,
      recordDateTime,
      this.deviceStatus,
      this.heartRateType,
      this.deviceuuid,
      this.deviceid});

  DateTime get recordDate => stringDateWithTZ.parse(recordDateTime ?? "0000-00-00T00:00:00.000Z");

  HeartRateFetchModel.fromJson(Map<String, dynamic> json) {
    heartRateID = json['heartRateID'];
    userID = json['userID'];
    heartRateQty = json['heartRateQty'].toInt();
    recordDateTime = json['recordDateTime'];
    deviceStatus = json['deviceStatus'];
    heartRateType = json['heartRateType'];
    deviceuuid = json['deviceuuid'];
    deviceid = json['deviceid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['heartRateID'] = heartRateID;
    data['userID'] = userID;
    data['heartRateQty'] = heartRateQty;
    data['recordDateTime'] = recordDateTime;
    data['deviceStatus'] = deviceStatus;
    data['heartRateType'] = heartRateType;
    data['deviceuuid'] = deviceuuid;
    data['deviceid'] = deviceid;
    return data;
  }
}
