import 'package:wehealth/global/constants/functions_extensions.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';

class BloodGlucoseDataFetchWrapper {
  int? error;
  String? authResponse;
  List<BloodGlucoseData>? dataList;

  BloodGlucoseDataFetchWrapper({this.error, this.authResponse, this.dataList});

  BloodGlucoseDataFetchWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      dataList = <BloodGlucoseData>[];
      json['Data'].forEach((v) {
        dataList!.add(BloodGlucoseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['error'] = error;
    map['authResponse'] = authResponse;
    if (dataList != null) {
      map['Data'] = dataList!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class BloodGlucoseData {
  int? id;
  String? user;
  double? glucoseLevel;
  String? recordDatetime;
  String? insertDate;
  String? mealType;
  String? notes;
  String? deviceid;
  String? deviceuuid;
  int? deviceStatus;
  String? unit;

  DateTime get recordDate => stringDateWithTZ.parse(recordDatetime ?? "0000-00-00T00:00:00.000Z");

  String get typeToName {
    switch (mealType) {
      case "BeforeBed":
        return "Before Bed";
      case "AfterMeal":
        return "After Meal";
      case "BeforeMeal":
        return "Before Meal";
      case "Fasting":
        return "Fasting";
      default:
        return "Other";
    }
  }

  RangeChecker get getBloodGlucoseSattus {
    switch ((mealType ?? "").toLowerCase()) {
      case "beforemeal":
        return rangeCheckerExclusive(0, 3, 7.8, (glucoseLevel ?? 0));
      case "aftermeal":
        return rangeCheckerExclusive(0, 3, 7.8, (glucoseLevel ?? 0));
      case "beforebed":
        return rangeCheckerExclusive(0, 3, 6.1, (glucoseLevel ?? 0));
      case "fasting":
        return rangeCheckerExclusive(0, 3, 6.1, (glucoseLevel ?? 0));
      case "other":
        return rangeCheckerExclusive(0, 3, 6.1, (glucoseLevel ?? 0));
      default:
        return RangeChecker.outOfRange;
    }
  }



  BloodGlucoseData(
      {this.id,
      this.user,
      this.glucoseLevel,
      this.recordDatetime,
      this.insertDate,
      this.mealType,
      this.notes,
      this.deviceid,
      this.deviceuuid,
      this.deviceStatus,
      this.unit});

  BloodGlucoseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    glucoseLevel = json['glucose_level'].toDouble();
    recordDatetime = json['record_datetime'];
    insertDate = json['insertDate'];
    mealType = json['meal_type'];
    notes = json['notes'];
    deviceid = json['deviceid'];
    deviceuuid = json['deviceuuid'];
    deviceStatus = json['deviceStatus'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['user'] = user;
    map['glucose_level'] = glucoseLevel;
    map['record_datetime'] = recordDatetime;
    map['insertDate'] = insertDate;
    map['meal_type'] = mealType;
    map['notes'] = notes;
    map['deviceid'] = deviceid;
    map['deviceuuid'] = deviceuuid;
    map['deviceStatus'] = deviceStatus;
    map['unit'] = unit;
    return map;
  }
}
