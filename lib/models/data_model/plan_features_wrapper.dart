class PlanFeaturesWrapper {
  int? error;
  String? authResponse;
  List<PlanFeatureModel>? allFeatures;

  PlanFeaturesWrapper({this.error, this.authResponse, this.allFeatures});

  PlanFeaturesWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      allFeatures = <PlanFeatureModel>[];
      json['Data'].forEach((v) {
        allFeatures!.add(PlanFeatureModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (allFeatures != null) {
      jsonData['Data'] = allFeatures!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class PlanFeatureModel {
  int? id;
  int? planid;
  String? featurename;
  String? featuredescription;
  int? available;
  String? insertiondate;

  PlanFeatureModel(
      {this.id,
      this.planid,
      this.featurename,
      this.featuredescription,
      this.available,
      this.insertiondate});

  PlanFeatureModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planid = json['planid'];
    featurename = json['featurename'];
    featuredescription = json['featuredescription'];
    available = json['available'];
    insertiondate = json['insertiondate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['planid'] = planid;
    jsonData['featurename'] = featurename;
    jsonData['featuredescription'] = featuredescription;
    jsonData['available'] = available;
    jsonData['insertiondate'] = insertiondate;
    return jsonData;
  }
}
