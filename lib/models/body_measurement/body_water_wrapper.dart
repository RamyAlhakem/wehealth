class BodyWaterModel {
  int? error;
  String? authResponse;
  List<BodyWaterData>? bodyWaterDataList;

  BodyWaterModel({this.error, this.authResponse, this.bodyWaterDataList});

  BodyWaterModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      bodyWaterDataList = <BodyWaterData>[];
      json['Data'].forEach((v) {
        bodyWaterDataList!.add(BodyWaterData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['authResponse'] = authResponse;
    if (bodyWaterDataList != null) {
      data['Data'] = bodyWaterDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BodyWaterData {
  int? waterDensityID;
  String? scaleDate;
  double? qty;

  BodyWaterData({this.waterDensityID, this.scaleDate, this.qty});

  BodyWaterData.fromJson(Map<String, dynamic> json) {
    waterDensityID = json['waterDensityID'];
    scaleDate = json['scaleDate'];
    qty = json['Qty'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['waterDensityID'] = waterDensityID;
    data['scaleDate'] = scaleDate;
    data['Qty'] = qty;
    return data;
  }
}
