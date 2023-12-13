class UserMsgCountWrapper {
  int? error;
  String? authResponse;
  List<Count>? count;

  UserMsgCountWrapper({error, this.authResponse, this.count});

  UserMsgCountWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      count = <Count>[];
      json['Data'].forEach((v) {
        count!.add(Count.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> josnData = {};
    josnData['error'] = error;
    josnData['authResponse'] = authResponse;
    if (count != null) {
      josnData['Data'] = count!.map((v) => v.toJson()).toList();
    }
    return josnData;
  }
}

class Count {
  int? unread;

  Count({this.unread});

  Count.fromJson(Map<String, dynamic> json) {
    unread = json['unread'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['unread'] = unread;
    return jsonData;
  }
}
