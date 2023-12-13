class UserBodyBMR {
  int? error;
  String? authResponse;
  List<BmrData>? bmrDataList;

  UserBodyBMR({this.error, this.authResponse, this.bmrDataList});

  UserBodyBMR.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      bmrDataList = <BmrData>[];
      json['Data'].forEach((v) {
        bmrDataList!.add(new BmrData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['authResponse'] = this.authResponse;
    if (this.bmrDataList != null) {
      data['Data'] = this.bmrDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BmrData {
  int? bmrID;
  String? scaleDate;
  double? qty;

  BmrData({this.bmrID, this.scaleDate, this.qty});

  BmrData.fromJson(Map<String, dynamic> json) {
    bmrID = json['bmrID'];
    scaleDate = json['scaleDate'];
    qty = json['Qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bmrID'] = this.bmrID;
    data['scaleDate'] = this.scaleDate;
    data['Qty'] = this.qty;
    return data;
  }
}
