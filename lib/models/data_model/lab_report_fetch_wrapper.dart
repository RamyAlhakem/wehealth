import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';

class LabReportFetchWrapper {
  int? error;
  String? authResponse;
  List<LabReportData>? reportList;

  LabReportFetchWrapper({this.error, this.authResponse, this.reportList});

  LabReportFetchWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      reportList = <LabReportData>[];
      json['Data'].forEach((v) {
        reportList!.add(LabReportData.fromJson(v));
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

class LabReportData {
  int? id;
  int? userID;
  String? reportname;
  String? reportdate;
  double? totalcholestrol;
  double? cholestrolhdlratio;
  double? totalhdl;
  double? totalldl;
  double? totaltriglycerides;
  double? totalplasmaglucose;
  double? hemoglobin;
  String? insertDateTime;

  DateTime get date => stringDateWithTZ.parse(insertDateTime ?? "0000-00-00T00:00:00.000Z");

  LabReportData(
      {this.id,
      this.userID,
      this.reportname,
      this.reportdate,
      this.totalcholestrol,
      this.cholestrolhdlratio,
      this.totalhdl,
      this.totalldl,
      this.totaltriglycerides,
      this.totalplasmaglucose,
      this.hemoglobin,
      this.insertDateTime});

  LabReportData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    reportname = json['reportname'];
    reportdate = json['reportdate'];
    totalcholestrol = json['totalcholestrol'].toDouble();
    cholestrolhdlratio = json['cholestrolhdlratio'].toDouble();
    totalhdl = json['totalhdl'].toDouble();
    totalldl = json['totalldl'].toDouble();
    totaltriglycerides = json['totaltriglycerides'].toDouble();
    totalplasmaglucose = json['totalplasmaglucose'].toDouble();
    hemoglobin = json['hemoglobin'].toDouble();
    insertDateTime = json['insertDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['userID'] = userID;
    map['reportname'] = reportname;
    map['reportdate'] = reportdate;
    map['totalcholestrol'] = totalcholestrol;
    map['cholestrolhdlratio'] = cholestrolhdlratio;
    map['totalhdl'] = totalhdl;
    map['totalldl'] = totalldl;
    map['totaltriglycerides'] = totaltriglycerides;
    map['totalplasmaglucose'] = totalplasmaglucose;
    map['hemoglobin'] = hemoglobin;
    map['insertDateTime'] = insertDateTime;
    return map;
  }
}
