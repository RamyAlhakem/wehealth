import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';

class BloodOxygenWrapper {
  int? error;
  String? authResponse;
  List<BloodOxygenData>? dataList;

  BloodOxygenWrapper({this.error, this.authResponse, this.dataList});

  BloodOxygenWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      dataList = <BloodOxygenData>[];
      json['Data'].forEach((v) {
        dataList!.add(BloodOxygenData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['error'] = error;
    map['authResponse'] = authResponse;
    if (dataList != null) {
      map['Data'] = dataList!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class BloodOxygenData {
  int? id;
  String? user;
  String? oxygenlevel;
  String? pulse;
  String? recordDateTime;
  String? insertDate;
  String? notes;
  int? deviceStatus;
  String? deviceuuid;
  String? deviceid;

  DateTime get recordDate => stringDateWithTZ.parse(recordDateTime ?? "0000-00-00T00:00:00.000Z");
  double get oxygenFromString => double.tryParse(oxygenlevel ?? "") ?? 0.0;
  double get pulseFromString => double.tryParse(pulse ?? "") ?? 0.0;

  BloodOxygenData(
      {this.id,
      this.user,
      this.oxygenlevel,
      this.pulse,
      this.recordDateTime,
      this.insertDate,
      this.notes,
      this.deviceStatus,
      this.deviceuuid,
      this.deviceid});

  BloodOxygenData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    oxygenlevel = json['oxygenlevel'];
    pulse = json['pulse'];
    recordDateTime = json['record_date_time'];
    insertDate = json['insertDate'];
    notes = json['notes'];
    deviceStatus = json['deviceStatus'];
    deviceuuid = json['deviceuuid'];
    deviceid = json['deviceid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['user'] = user;
    map['oxygenlevel'] = oxygenlevel;
    map['pulse'] = pulse;
    map['record_date_time'] = recordDateTime;
    map['insertDate'] = insertDate;
    map['notes'] = notes;
    map['deviceStatus'] = deviceStatus;
    map['deviceuuid'] = deviceuuid;
    map['deviceid'] = deviceid;
    return map;
  }
}
