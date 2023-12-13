import 'package:intl/intl.dart';

class BodyWeightDataResponseWrapper {
  int? error;
  String? authResponse;
  List<BodyWeightData>? dataList;

  BodyWeightDataResponseWrapper({this.error, this.authResponse, this.dataList});

  BodyWeightDataResponseWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      dataList = <BodyWeightData>[];
      json['Data'].forEach((v) {
        dataList!.add(BodyWeightData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['authResponse'] = authResponse;
    if (dataList != null) {
      data['Data'] = dataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BodyWeightData {
  int? weightID;
  String? scaleDate;
  double? qty;
  double? height;
  int? deviceStatus;
  String? unit;
  String? notes;
  String? deviceuuid;
  String? deviceid;

  BodyWeightData(
      {this.weightID,
      this.scaleDate,
      this.qty,
      this.height,
      this.deviceStatus,
      this.unit,
      this.notes,
      this.deviceuuid,
      this.deviceid});

      DateTime get recordDate => stringDateWithTZ.parse(scaleDate ?? "0000-00-00T00:00:00.000Z");

  BodyWeightData.fromJson(Map<String, dynamic> json) {
    weightID = json['weightID'];
    scaleDate = json['scaleDate'];
    qty = json['Qty'].toDouble();
    height = json['height'].toDouble();
    deviceStatus = json['deviceStatus'];
    unit = json['unit'];
    notes = json['notes'];
    deviceuuid = json['deviceuuid'];
    deviceid = json['deviceid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weightID'] = weightID;
    data['scaleDate'] = scaleDate;
    data['Qty'] = qty;
    data['height'] = height;
    data['deviceStatus'] = deviceStatus;
    data['unit'] = unit;
    data['notes'] = notes;
    data['deviceuuid'] = deviceuuid;
    data['deviceid'] = deviceid;
    return data;
  }
}

DateFormat stringDateWithTZ = DateFormat("yyyy-MM-ddTHH:mm:ss.S");
