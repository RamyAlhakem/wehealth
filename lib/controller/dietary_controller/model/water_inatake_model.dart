import 'package:wehealth/models/body_measurement/body_weight_wrapper.dart';

class GetWaterIntakeModel {
  int? error;
  String? authResponse;
  List<WaterIntakeData>? data;

  GetWaterIntakeModel({this.error, this.authResponse, this.data});

  GetWaterIntakeModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      data = <WaterIntakeData>[];
      json['Data'].forEach((v) {
        data!.add(WaterIntakeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['authResponse'] = authResponse;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WaterIntakeData {
  int? id;
  String? drinkname;
  double? drinksize;
  String? recorddatetime;
  int? userid;

  WaterIntakeData({
    this.id,
    this.drinkname,
    this.drinksize,
    this.recorddatetime,
    this.userid,
  });

  DateTime get time => stringDateWithTZ.parse(recorddatetime ?? "");

  WaterIntakeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    drinkname = json['drinkname'];
    drinksize = json['drinksize'].toDouble();
    recorddatetime = json['recorddatetime'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['drinkname'] = drinkname;
    data['drinksize'] = drinksize;
    data['recorddatetime'] = recorddatetime;
    data['userid'] = userid;
    return data;
  }
}

/* class GetWaterIntakeModel {
  int? error;
  String? authResponse;
  List<WaterIntakeData>? waterIntakeData;

  GetWaterIntakeModel({this.error, this.authResponse, this.waterIntakeData});

  GetWaterIntakeModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      waterIntakeData = <WaterIntakeData>[];
      json['Data'].forEach((v) {
        waterIntakeData!.add(WaterIntakeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['authResponse'] = authResponse;
    if (this.waterIntakeData != null) {
      data['Data'] = this.waterIntakeData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WaterIntakeData {
  String? drinkname;
  double? drinksize;
  String? recorddatetime;
  int? userid;

  WaterIntakeData({this.drinkname, this.drinksize, this.recorddatetime, this.userid});

  WaterIntakeData.fromJson(Map<String, dynamic> json) {
    drinkname = json['drinkname'];
    drinksize = json['drinksize'];
    recorddatetime = json['recorddatetime'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['drinkname'] = drinkname;
    data['drinksize'] = drinksize;
    data['recorddatetime'] = recorddatetime;
    data['userid'] = userid;
    return data;
  }
}
 */