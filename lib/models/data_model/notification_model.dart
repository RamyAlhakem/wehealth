class NotificationResponseWrapper {
  int? error;
  String? authResponse;
  List<NotificationModel>? notifications;

  NotificationResponseWrapper({error, authResponse, data});

  NotificationResponseWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      notifications = <NotificationModel>[];
      json['Data'].forEach((v) {
        notifications!.add(NotificationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['error'] = error;
    map['authResponse'] = authResponse;
    if (notifications != null) {
      map['Data'] = notifications!.map((item) => item.toJson()).toList();
    }
    return map;
  }
}

class NotificationModel {
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

  NotificationModel(
      {id,
      fromUserID,
      isImportant,
      toUserID,
      subject,
      datetime,
      details,
      status,
      username,
      firstName,
      lastName,
      pic,
      gender});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fromUserID'] = fromUserID;
    data['is_important'] = isImportant;
    data['toUserID'] = toUserID;
    data['subject'] = subject;
    data['datetime'] = datetime;
    data['details'] = details;
    data['status'] = status;
    data['username'] = username;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['pic'] = pic;
    data['gender'] = gender;
    return data;
  }
}
