import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserMedicineDataWrapper {
  int? error;
  String? authResponse;
  List<UserMedicineData>? userMedicineList;

  UserMedicineDataWrapper(
      {this.error, this.authResponse, this.userMedicineList});

  UserMedicineDataWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      userMedicineList = <UserMedicineData>[];
      json['Data'].forEach((v) {
        userMedicineList!.add(UserMedicineData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (userMedicineList != null) {
      jsonData['Data'] = userMedicineList!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class UserMedicineData {
  String? medicineName;
  int? id;
  int? medicineID;
  int? userID;
  String? shape;
  String? colour;
  String? variableDose;
  String? strengthSupplied;
  String? strengthTaken;
  String? medicineTake;
  String? medicineTakeType;
  String? unit;
  String? timingPerDay;
  String? reminderType;
  String? beforeActualTimeRemind;
  String? startDate;
  String? endDate;
  String? days;
  String? instruction;
  String? insertDateTime;
  String? deviceID;
  String? quantitySupplied;
  String? refilReminder;
  String? daysBeforeMedicineOut;
  String? dosageUnit;

  UserMedicineData(
      {this.medicineName,
      this.id,
      this.medicineID,
      this.userID,
      this.shape,
      this.colour,
      this.variableDose,
      this.strengthSupplied,
      this.strengthTaken,
      this.medicineTake,
      this.medicineTakeType,
      this.unit,
      this.timingPerDay,
      this.reminderType,
      this.beforeActualTimeRemind,
      this.startDate,
      this.endDate,
      this.days,
      this.instruction,
      this.insertDateTime,
      this.deviceID,
      this.quantitySupplied,
      this.refilReminder,
      this.daysBeforeMedicineOut,
      this.dosageUnit});

  DateTime get formattedEndDate => DateFormat("d-M-y").parse(endDate ?? "");
  DateTime get formattedTime => DateFormat("H:mm").parse(timingPerDay ?? "");
  TimeOfDay get timeOfTaking =>
      TimeOfDay.fromDateTime(DateFormat.Hm().parse(timingPerDay ?? "00:00"));

  UserMedicineData.fromJson(Map<String, dynamic> json) {
    medicineName = json['medicineName'];
    id = json['id'];
    medicineID = json['medicineID'];
    userID = json['userID'];
    shape = json['shape'];
    colour = json['colour'];
    variableDose = json['variableDose'];
    strengthSupplied = json['strengthSupplied'];
    strengthTaken = json['strengthTaken'];
    medicineTake = json['medicineTake'];
    medicineTakeType = json['medicineTakeType'];
    unit = json['unit'];
    timingPerDay = json['timingPerDay'];
    reminderType = json['reminderType'];
    beforeActualTimeRemind = json['beforeActualTimeRemind'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    days = json['days'];
    instruction = json['instruction'];
    insertDateTime = json['insertDateTime'];
    deviceID = json['deviceID'];
    quantitySupplied = json['quantitySupplied'];
    refilReminder = json['refilReminder'];
    daysBeforeMedicineOut = json['daysBeforeMedicineOut'];
    dosageUnit = json['dosageUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['medicineName'] = medicineName;
    jsonData['id'] = id;
    jsonData['medicineID'] = medicineID;
    jsonData['userID'] = userID;
    jsonData['shape'] = shape;
    jsonData['colour'] = colour;
    jsonData['variableDose'] = variableDose;
    jsonData['strengthSupplied'] = strengthSupplied;
    jsonData['strengthTaken'] = strengthTaken;
    jsonData['medicineTake'] = medicineTake;
    jsonData['medicineTakeType'] = medicineTakeType;
    jsonData['unit'] = unit;
    jsonData['timingPerDay'] = timingPerDay;
    jsonData['reminderType'] = reminderType;
    jsonData['beforeActualTimeRemind'] = beforeActualTimeRemind;
    jsonData['startDate'] = startDate;
    jsonData['endDate'] = endDate;
    jsonData['days'] = days;
    jsonData['instruction'] = instruction;
    jsonData['insertDateTime'] = insertDateTime;
    jsonData['deviceID'] = deviceID;
    jsonData['quantitySupplied'] = quantitySupplied;
    jsonData['refilReminder'] = refilReminder;
    jsonData['daysBeforeMedicineOut'] = daysBeforeMedicineOut;
    jsonData['dosageUnit'] = dosageUnit;
    return jsonData;
  }
}
