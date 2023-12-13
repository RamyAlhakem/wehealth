class SubscriptionPlanWrapper {
  int? error;
  String? authResponse;
  List<SubscriptionPlanModel>? subscriptionPlans;

  SubscriptionPlanWrapper(
      {this.error, this.authResponse, this.subscriptionPlans});

  SubscriptionPlanWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      subscriptionPlans = <SubscriptionPlanModel>[];
      json['Data'].forEach((v) {
        subscriptionPlans!.add(SubscriptionPlanModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (subscriptionPlans != null) {
      jsonData['Data'] = subscriptionPlans!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class SubscriptionPlanModel {
  int? id;
  int? organizationID;
  int? planid;
  String? planName;
  int? price;
  String? frequency;
  String? pricedescription;
  String? validatefrom;
  String? validateto;
  String? status;
  String? insertiondate;
  String? photopath;

  SubscriptionPlanModel(
      {this.id,
      this.organizationID,
      this.planid,
      this.planName,
      this.price,
      this.frequency,
      this.pricedescription,
      this.validatefrom,
      this.validateto,
      this.status,
      this.insertiondate,
      this.photopath});

  SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organizationID = json['organizationID'];
    planid = json['planid'];
    planName = json['planName'];
    price = json['price'];
    frequency = json['frequency'];
    pricedescription = json['pricedescription'];
    validatefrom = json['validatefrom'];
    validateto = json['validateto'];
    status = json['status'];
    insertiondate = json['insertiondate'];
    photopath = json['photopath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['organizationID'] = organizationID;
    jsonData['planid'] = planid;
    jsonData['planName'] = planName;
    jsonData['price'] = price;
    jsonData['frequency'] = frequency;
    jsonData['pricedescription'] = pricedescription;
    jsonData['validatefrom'] = validatefrom;
    jsonData['validateto'] = validateto;
    jsonData['status'] = status;
    jsonData['insertiondate'] = insertiondate;
    jsonData['photopath'] = photopath;
    return jsonData;
  }
}
