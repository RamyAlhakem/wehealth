import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';

class FetchBloodPressureDataWrapper {
  int? error;
  String? authResponse;
  List<BPData>? bpData;

  FetchBloodPressureDataWrapper({this.error, this.authResponse, this.bpData});

  FetchBloodPressureDataWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      bpData = <BPData>[];
      json['Data'].forEach((v) {
        bpData!.add(BPData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['authResponse'] = authResponse;
    if (bpData != null) {
      data['Data'] = bpData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BPData {
  int? bpID;
  String? userID;
  int? systolic;
  String? deviceid;
  int? diastolic;
  String? recordTime;
  int? pulserate;
  String? notes;
  String? insertDateTime;
  int? deviceStatus;
  String? unit;
  String? deviceuuid;

  DateTime get recordDate => stringDateWithTZ.parse(recordTime ?? "0000-00-00T00:00:00.000Z");

  BPData(
      {this.bpID,
      this.userID,
      this.systolic,
      this.deviceid,
      this.diastolic,
      this.recordTime,
      this.pulserate,
      this.notes,
      this.insertDateTime,
      this.deviceStatus,
      this.unit,
      this.deviceuuid});

  BPData.fromJson(Map<String, dynamic> json) {
    bpID = json['bpID'];
    userID = json['userID'];
    systolic = json['systolic'];
    deviceid = json['deviceid'];
    diastolic = json['diastolic'];
    recordTime = json['record_time'];
    pulserate = json['pulserate'];
    notes = json['notes'];
    insertDateTime = json['insertDateTime'];
    deviceStatus = json['deviceStatus'];
    unit = json['unit'];
    deviceuuid = json['deviceuuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bpID'] = bpID;
    data['userID'] = userID;
    data['systolic'] = systolic;
    data['deviceid'] = deviceid;
    data['diastolic'] = diastolic;
    data['record_time'] = recordTime;
    data['pulserate'] = pulserate;
    data['notes'] = notes;
    data['insertDateTime'] = insertDateTime;
    data['deviceStatus'] = deviceStatus;
    data['unit'] = unit;
    data['deviceuuid'] = deviceuuid;
    return data;
  }
}

class UploadBloodPressureClass {
  int? bpID;
  int? deviceType;
  String? deviceid;
  String? deviceuuid;
  int? diastolic;
  String? email;
  bool? isSection;
  int? isuploadedtoweb;
  String? notes;
  int? pulserate;
  String? recorddate;
  String? recordTime;
  int? serverid;
  int? systolic;
  int? userid;

  UploadBloodPressureClass(
      {this.bpID,
      this.deviceType,
      this.deviceid,
      this.deviceuuid,
      this.diastolic,
      this.email,
      this.isSection,
      this.isuploadedtoweb,
      this.notes,
      this.pulserate,
      this.recorddate,
      this.recordTime,
      this.serverid,
      this.systolic,
      this.userid});

  UploadBloodPressureClass.fromJson(Map<String, dynamic> json) {
    bpID = json['bpID'];
    deviceType = json['deviceType'];
    deviceid = json['deviceid'];
    deviceuuid = json['deviceuuid'];
    diastolic = json['diastolic'];
    email = json['email'];
    isSection = json['isSection'];
    isuploadedtoweb = json['isuploadedtoweb'];
    notes = json['notes'];
    pulserate = json['pulserate'];
    recorddate = json['recorddate'];
    recordTime = json['record_time'];
    serverid = json['serverid'];
    systolic = json['systolic'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['bpID'] = bpID;
    jsonData['deviceType'] = deviceType;
    jsonData['deviceid'] = deviceid;
    jsonData['deviceuuid'] = deviceuuid;
    jsonData['diastolic'] = diastolic;
    jsonData['email'] = email;
    jsonData['isSection'] = isSection;
    jsonData['isuploadedtoweb'] = isuploadedtoweb;
    jsonData['notes'] = notes;
    jsonData['pulserate'] = pulserate;
    jsonData['recorddate'] = recorddate;
    jsonData['record_time'] = recordTime;
    jsonData['serverid'] = serverid;
    jsonData['systolic'] = systolic;
    jsonData['userid'] = userid;
    return jsonData;
  }
}
