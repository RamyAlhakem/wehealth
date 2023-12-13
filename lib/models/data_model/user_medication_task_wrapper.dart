import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserMedicationTaskWrapper {
  int? error;
  String? authResponse;
  List<UserMedicationTaskModel>? medicationList;

  UserMedicationTaskWrapper(
      {this.error, this.authResponse, this.medicationList});

  UserMedicationTaskWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      medicationList = <UserMedicationTaskModel>[];
      json['Data'].forEach((v) {
        medicationList!.add(UserMedicationTaskModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (medicationList != null) {
      jsonData['Data'] = medicationList!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class UserMedicationTaskModel {
  int? id;
  int? userID;
  String? medicineName;
  String? todaytime;
  String? days;
  String? startDate;
  String? endDate;

  DateTime get formattedEndDate => DateFormat("d-M-y").parse(endDate ?? "");
  DateTime get formattedTime => DateFormat("H:mm").parse(todaytime ?? "");
  TimeOfDay get timeOfTaking =>
      TimeOfDay.fromDateTime(DateFormat.Hm().parse(todaytime ?? "00:00"));

  UserMedicationTaskModel({
    this.id,
    this.userID,
    this.medicineName,
    this.todaytime,
    this.days,
    this.startDate,
    this.endDate,
  });

  UserMedicationTaskModel copyWith({
    int? id,
    int? userID,
    String? medicineName,
    String? todaytime,
    String? days,
    String? startDate,
    String? endDate,
  }) {
    return UserMedicationTaskModel(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      medicineName: medicineName ?? this.medicineName,
      todaytime: todaytime ?? this.todaytime,
      days: days ?? this.days,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  UserMedicationTaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    medicineName = json['medicineName'];
    todaytime = json['todaytime'];
    days = json['days'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['userID'] = userID;
    jsonData['medicineName'] = medicineName;
    jsonData['todaytime'] = todaytime;
    jsonData['days'] = days;
    jsonData['startDate'] = startDate;
    jsonData['endDate'] = endDate;
    return jsonData;
  }
}
