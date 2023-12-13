class VisceralarFatModel {
  int? error;
  String? authResponse;
  List<ViscelarFatdata>? viscelarFatDataList;

  VisceralarFatModel({this.error, this.authResponse, this.viscelarFatDataList});

  VisceralarFatModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      viscelarFatDataList = <ViscelarFatdata>[];
      json['Data'].forEach((v) {
        viscelarFatDataList!.add(new ViscelarFatdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['authResponse'] = this.authResponse;
    if (this.viscelarFatDataList != null) {
      data['Data'] = this.viscelarFatDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViscelarFatdata {
  int? visceralFatID;
  String? scaleDate;
  int? qty;

  ViscelarFatdata({this.visceralFatID, this.scaleDate, this.qty});

  ViscelarFatdata.fromJson(Map<String, dynamic> json) {
    visceralFatID = json['visceralFatID'];
    scaleDate = json['scaleDate'];
    qty = json['Qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['visceralFatID'] = this.visceralFatID;
    data['scaleDate'] = this.scaleDate;
    data['Qty'] = this.qty;
    return data;
  }
}
