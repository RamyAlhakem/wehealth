class BoneMassModel {
  int? error;
  String? authResponse;
  List<BoneMassData>? boneMassDataList;

  BoneMassModel({this.error, this.authResponse, this.boneMassDataList});

  BoneMassModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      boneMassDataList = <BoneMassData>[];
      json['Data'].forEach((v) {
        boneMassDataList!.add(new BoneMassData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['authResponse'] = this.authResponse;
    if (this.boneMassDataList != null) {
      data['Data'] = this.boneMassDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BoneMassData {
  int? boneDensityID;
  String? scaleDate;
  double? qty;

  BoneMassData({this.boneDensityID, this.scaleDate, this.qty});

  BoneMassData.fromJson(Map<String, dynamic> json) {
    boneDensityID = json['boneDensityID'];
    scaleDate = json['scaleDate'];
    qty = json['Qty'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['boneDensityID'] = this.boneDensityID;
    data['scaleDate'] = this.scaleDate;
    data['Qty'] = this.qty;
    return data;
  }
}
