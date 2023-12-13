class MetabolicAgeModel {
  int? error;
  String? authResponse;
  List<MetabolicAgeData>? metabolicAgedataList;

  MetabolicAgeModel({this.error, this.authResponse, this.metabolicAgedataList});

  MetabolicAgeModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      metabolicAgedataList = <MetabolicAgeData>[];
      json['Data'].forEach((v) {
        metabolicAgedataList!.add(new MetabolicAgeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['authResponse'] = this.authResponse;
    if (this.metabolicAgedataList != null) {
      data['Data'] = this.metabolicAgedataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MetabolicAgeData {
  int? metabolicageID;
  int? userID;
  String? scaleDate;
  String? metabolicage;

  MetabolicAgeData({this.metabolicageID, this.userID, this.scaleDate, this.metabolicage});

  MetabolicAgeData.fromJson(Map<String, dynamic> json) {
    metabolicageID = json['metabolicageID'];
    userID = json['userID'];
    scaleDate = json['scaleDate'];
    metabolicage = json['metabolicage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['metabolicageID'] = this.metabolicageID;
    data['userID'] = this.userID;
    data['scaleDate'] = this.scaleDate;
    data['metabolicage'] = this.metabolicage;
    return data;
  }
}
