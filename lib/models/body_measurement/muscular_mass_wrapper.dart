class MuscularMassModel {
  int? error;
  String? authResponse;
  List<MuscularMassData>? muscularMassDataList;

  MuscularMassModel({this.error, this.authResponse, this.muscularMassDataList});

  MuscularMassModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      muscularMassDataList = <MuscularMassData>[];
      json['Data'].forEach((v) {
        muscularMassDataList!.add(MuscularMassData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['authResponse'] = authResponse;
    if (muscularMassDataList != null) {
      data['Data'] = muscularMassDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MuscularMassData {
  int? muscleID;
  String? scaleDate;
  double? qty;

  MuscularMassData({this.muscleID, this.scaleDate, this.qty});

  MuscularMassData.fromJson(Map<String, dynamic> json) {
    muscleID = json['muscleID'];
    scaleDate = json['scaleDate'];
    qty = json['Qty'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['muscleID'] = muscleID;
    data['scaleDate'] = scaleDate;
    data['Qty'] = qty;
    return data;
  }
}
