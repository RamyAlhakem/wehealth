import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';

class UserMessagesWrapper {
  int? error;
  String? authResponse;
  List<MsgDetailsClass>? msgesList;

  UserMessagesWrapper({this.error, this.authResponse, this.msgesList});

  UserMessagesWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      msgesList = <MsgDetailsClass>[];
      json['Data'].forEach((v) {
        msgesList!.add(MsgDetailsClass.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (msgesList != null) {
      jsonData['Data'] = msgesList!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class MsgDetailsClass {
  int? id;
  int? fromUserID;
  int? isImportant;
  int? toUserID;
  String? subject;
  String? datetime;
  String? details;
  int? status;
  String? username;
  String? firstName;
  String? lastName;
  String? pic;
  String? gender;

  DateTime get timeStamp =>
      stringDateWithTZ.parse(datetime ?? "0000-00-00T00:00:00.000Z");

  bool get isMe => StorageController.instance().userId == (fromUserID ?? -1);

  MsgDetailsClass(
      {this.id,
      this.fromUserID,
      this.isImportant,
      this.toUserID,
      this.subject,
      this.datetime,
      this.details,
      this.status,
      this.username,
      this.firstName,
      this.lastName,
      this.pic,
      this.gender});

  MsgDetailsClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromUserID = json['fromUserID'];
    isImportant = json['is_important'];
    toUserID = json['toUserID'];
    subject = json['subject'];
    datetime = json['datetime'];
    details = json['details'];
    status = json['status'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    pic = json['pic'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['fromUserID'] = fromUserID;
    jsonData['is_important'] = isImportant;
    jsonData['toUserID'] = toUserID;
    jsonData['subject'] = subject;
    jsonData['datetime'] = datetime;
    jsonData['details'] = details;
    jsonData['status'] = status;
    jsonData['username'] = username;
    jsonData['firstName'] = firstName;
    jsonData['lastName'] = lastName;
    jsonData['pic'] = pic;
    jsonData['gender'] = gender;
    return jsonData;
  }
}
