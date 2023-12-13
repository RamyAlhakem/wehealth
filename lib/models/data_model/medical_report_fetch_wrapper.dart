import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';

class MedicalReportFetchWrapper {
  int? error;
  String? authResponse;
  List<MedicalReportData>? reportList;

  MedicalReportFetchWrapper({this.error, this.authResponse, this.reportList});

  MedicalReportFetchWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      reportList = <MedicalReportData>[];
      json['Data'].forEach((v) {
        reportList!.add(MedicalReportData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['error'] = error;
    map['authResponse'] = authResponse;
    if (reportList != null) {
      map['Data'] = reportList!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class MedicalReportData {
  int? id;
  int? userID;
  String? reporttype;
  String? reportname;
  String? reportdate;
  String? insertDateTime;

  DateTime get date =>
      stringDateWithTZ.parse(insertDateTime ?? "0000-00-00T00:00:00.000Z");

  String get reportTypeDecoded {
    switch ((reporttype ?? "").trim()) {
      case "0":
        return "Lab";
      case "1":
        return "Radiology";
      case "2":
        return "Wellness";
      case "3":
        return "Discharge Summary";
      case "4":
        return "Other Report";
      default:
        return "Lab";
    }
  }

  MedicalReportData(
      {this.id,
      this.userID,
      this.reporttype,
      this.reportname,
      this.reportdate,
      this.insertDateTime});

  MedicalReportData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    reporttype = json['reporttype'];
    reportname = json['reportname'];
    reportdate = json['reportdate'];
    insertDateTime = json['insertDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['userID'] = userID;
    map['reporttype'] = reporttype;
    map['reportname'] = reportname;
    map['reportdate'] = reportdate;
    map['insertDateTime'] = insertDateTime;
    return map;
  }
}
