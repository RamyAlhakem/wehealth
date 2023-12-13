import 'dart:developer';

import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/http_cleint/api_clients.dart';
import 'package:wehealth/models/data_model/notification_model.dart';
import 'package:wehealth/models/data_model/user_latest_msges_wrapper.dart';
import 'package:wehealth/models/data_model/user_msg_count.dart';
import 'package:wehealth/models/data_model/user_sent_msg_wrapper.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';

import '../../http_cleint/app_config.dart';

class MessageNotificationRepository {
  const MessageNotificationRepository({
    required this.storage,
  });

  final String baseUrl = AppConfig.baseUrl;
  final StorageController storage;
  int get userId => storage.userId;
  String get userToken => storage.userToken;
  String get email => storage.email;

  Future<UserMessagesWrapper?> getUserSentMsges() async {
    String url = "$baseUrl/getMessageSent?userid=$userId&token=$userToken";
    try {
      var response = await ApiClients.getJson(url);

      if (response['error'] == 0) {
        UserMessagesWrapper wrapper = UserMessagesWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getUserSentMsges Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getUserSentMsges ${error.toString()}");
      return null;
    }
  }

  Future<UserMessagesWrapper?> getUserRecievedMsges() async {
    String url = "$baseUrl/getMessageInbox?userid=$userId&token=$userToken";
    try {
      var response = await ApiClients.getJson(url);

      if (response['error'] == 0) {
        UserMessagesWrapper wrapper = UserMessagesWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getUserRecievedMsges Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getUserRecievedMsges ${error.toString()}");
      return null;
    }
  }

  Future<UserMsgCountWrapper?> getUserMsgCount() async {
    String url = "$baseUrl/inboxMessageCount?userid=$userId&token=$userToken";
    try {
      var response = await ApiClients.getJson(url);

      if (response['error'] == 0) {
        UserMsgCountWrapper wrapper = UserMsgCountWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getUserMsgCount Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getUserMsgCount ${error.toString()}");
      return null;
    }
  }

  Future<UserLatestMessagesWrapper?> getUserLatestMsges(int sentUserId) async {
    String url =
        "$baseUrl/getlatestmessages?Fromuserid=$userId&token=$userToken&Touserid=$sentUserId";
    try {
      var response = await ApiClients.getJson(url);

      if (response['error'] == 0) {
        UserLatestMessagesWrapper wrapper =
            UserLatestMessagesWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getUserLatestMsges Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getUserLatestMsges ${error.toString()}");
      return null;
    }
  }

  Future<NotificationResponseWrapper?> getUserNotifications() async {
    String url =
        "$baseUrl/getnotificationinbox?userid=$userId&token=$userToken";
    try {
      var response = await ApiClients.getJson(url);

      if (response['error'] == 0) {
        NotificationResponseWrapper wrapper =
            NotificationResponseWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getUserNotifications Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching getUserNotifications ${error.toString()}");
      return null;
    }
  }

  Future<SendMsgModel?> postUserMessage(
      int contactId, String msg, String subject) async {
    String url = "$baseUrl/addMessage";

    final msgData = SendMsgModel(
      userid: userId,
      from: userId,
      to: contactId,
      token: userToken,
      subject: subject,
      details: msg,
      insertionDateTime: stringDateWithTZ.format(DateTime.now()),
    );

    log(msgData.toMap().toString());
    try {
      var response =
          await ApiClients.postFormUrlEncodedData(msgData.toMap(), url);
      log("post msgData res => ${response.toString()}");
      if (response['error'] == 0) {
        return msgData;
      } else {
        log("postUserMessage Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching postUserMessage ${error.toString()}");
      return null;
    }
  }

  Future<bool?> postUserNotificationImportance(int id) async {
    String url = "$baseUrl/isImportantNotifications";
    final Map<String, dynamic> data = {
      'userid': userId,
      'token': userToken,
      'notification_id': id,
    };

    log(data.toString());
    try {
      var response = await ApiClients.postFormUrlEncodedData(data, url);
      log("post postUserNotificationImportance res => ${response.toString()}");
      if (response['error'] == 0) {
        return true;
      } else {
        log("postUserNotificationImportance Status => ${response['error']}!");
        return false;
      }
    } catch (error) {
      log("Error While fetching postUserNotificationImportance ${error.toString()}");
      return null;
    }
  }
  Future<bool?> postUserNotificationDelete(int id) async {
    String url = "$baseUrl/deleteNotifications";
    final Map<String, dynamic> data = {
      'userid': userId,
      'token': userToken,
      'notification_id': id,
    };

    log(data.toString());
    try {
      var response = await ApiClients.postFormUrlEncodedData(data, url);
      log("post postUserNotificationDelete res => ${response.toString()}");
      if (response['error'] == 0) {
        return true;
      } else {
        log("postUserNotificationDelete Status => ${response['error']}!");
        return false;
      }
    } catch (error) {
      log("Error While fetching postUserNotificationDelete ${error.toString()}");
      return null;
    }
  }
}

class SendMsgModel {
  int userid;
  int from;
  int to;
  String token;
  String subject;
  String details;
  String insertionDateTime;
  SendMsgModel({
    required this.userid,
    required this.from,
    required this.to,
    required this.token,
    required this.subject,
    required this.details,
    required this.insertionDateTime,
  });

  SendMsgModel copyWith({
    int? userid,
    int? from,
    int? to,
    String? token,
    String? subject,
    String? details,
    String? insertionDateTime,
  }) {
    return SendMsgModel(
      userid: userid ?? this.userid,
      from: from ?? this.from,
      to: to ?? this.to,
      token: token ?? this.token,
      subject: subject ?? this.subject,
      details: details ?? this.details,
      insertionDateTime: insertionDateTime ?? this.insertionDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userid,
      'from': from,
      'to': to,
      'token': token,
      'subject': subject,
      'details': details,
      'insertionDateTime': insertionDateTime,
    };
  }

  factory SendMsgModel.fromMap(Map<String, dynamic> map) {
    return SendMsgModel(
      userid: map['userid'] as int,
      from: map['from'] as int,
      to: map['to'] as int,
      token: map['token'] as String,
      subject: map['subject'] as String,
      details: map['details'] as String,
      insertionDateTime: map['insertionDateTime'] as String,
    );
  }

/*   String toJson() => json.encode(toMap());

  factory SendMsgModel.fromJson(String source) =>
      SendMsgModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SendMsgModel(userid: $userid, from: $from, to: $to, token: $token, subject: $subject, details: $details, insertionDateTime: $insertionDateTime)';
  }

  @override
  bool operator ==(covariant SendMsgModel other) {
    if (identical(this, other)) return true;

    return other.userid == userid &&
        other.from == from &&
        other.to == to &&
        other.token == token &&
        other.subject == subject &&
        other.details == details &&
        other.insertionDateTime == insertionDateTime;
  }

  @override
  int get hashCode {
    return userid.hashCode ^
        from.hashCode ^
        to.hashCode ^
        token.hashCode ^
        subject.hashCode ^
        details.hashCode ^
        insertionDateTime.hashCode;
  }*/
}
