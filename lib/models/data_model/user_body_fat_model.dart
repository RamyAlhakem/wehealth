class UserBodyFat {
  int? error;
  String? authResponse;
  List<BodyFatData>? bodyFatDataList;

  UserBodyFat({this.error, this.authResponse, this.bodyFatDataList});

  UserBodyFat.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      bodyFatDataList = <BodyFatData>[];
      json['Data'].forEach((v) {
        bodyFatDataList!.add(new BodyFatData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['authResponse'] = this.authResponse;
    if (this.bodyFatDataList != null) {
      data['Data'] = this.bodyFatDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BodyFatData {
  int? fatID;
  String? scaleDate;
  int? qty;

  BodyFatData({this.fatID, this.scaleDate, this.qty});

  BodyFatData.fromJson(Map<String, dynamic> json) {
    fatID = json['fatID'];
    scaleDate = json['scaleDate'];
    qty = json['Qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fatID'] = this.fatID;
    data['scaleDate'] = this.scaleDate;
    data['Qty'] = this.qty;
    return data;
  }
}
