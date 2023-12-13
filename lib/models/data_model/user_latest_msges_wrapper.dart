class UserLatestMessagesWrapper {
  int? error;
  String? authResponse;
  List<LatestMsgClass>? latestMsgList;

  UserLatestMessagesWrapper(
      {this.error, this.authResponse, this.latestMsgList});

  UserLatestMessagesWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      latestMsgList = <LatestMsgClass>[];
      json['Data'].forEach((v) {
        latestMsgList!.add(LatestMsgClass.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (latestMsgList != null) {
      jsonData['Data'] = latestMsgList!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class LatestMsgClass {
  int? fromUserID;
  int? toUserID;
  String? subject;
  String? details;
  String? datetime;

  LatestMsgClass(
      {this.fromUserID,
      this.toUserID,
      this.subject,
      this.details,
      this.datetime});

  LatestMsgClass.fromJson(Map<String, dynamic> json) {
    fromUserID = json['fromUserID'];
    toUserID = json['toUserID'];
    subject = json['subject'];
    details = json['details'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['fromUserID'] = fromUserID;
    jsonData['toUserID'] = toUserID;
    jsonData['subject'] = subject;
    jsonData['details'] = details;
    jsonData['datetime'] = datetime;
    return jsonData;
  }
}
