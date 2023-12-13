class UserPlansWrapper {
  int? error;
  String? authResponse;
  List<UserPlanClass>? userPlans;

  UserPlansWrapper({this.error, this.authResponse, this.userPlans});

  UserPlansWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      userPlans = <UserPlanClass>[];
      json['Data'].forEach((v) {
        userPlans!.add(UserPlanClass.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (userPlans != null) {
      jsonData['Data'] = userPlans!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class UserPlanClass {
  int? id;
  int? userid;
  int? planid;
  int? professionalID;
  String? subscriptiondate;
  String? expirydate;
  String? promotioncode;
  int? planAmount;
  int? voucherAmount;
  int? chargeAmount;
  int? autorenew;
  int? autoBill;
  String? paymentMethod;
  String? paymentToken;
  String? cancelDate;
  String? status;
  String? insertDateTime;

  UserPlanClass(
      {this.id,
      this.userid,
      this.planid,
      this.professionalID,
      this.subscriptiondate,
      this.expirydate,
      this.promotioncode,
      this.planAmount,
      this.voucherAmount,
      this.chargeAmount,
      this.autorenew,
      this.autoBill,
      this.paymentMethod,
      this.paymentToken,
      this.cancelDate,
      this.status,
      this.insertDateTime});

  UserPlanClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    planid = json['planid'];
    professionalID = json['professionalID'];
    subscriptiondate = json['subscriptiondate'];
    expirydate = json['expirydate'];
    promotioncode = json['promotioncode'];
    planAmount = json['planAmount'];
    voucherAmount = json['voucherAmount'];
    chargeAmount = json['chargeAmount'];
    autorenew = json['autorenew'];
    autoBill = json['autoBill'];
    paymentMethod = json['paymentMethod'];
    paymentToken = json['paymentToken'];
    cancelDate = json['cancelDate'];
    status = json['status'];
    insertDateTime = json['insertDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['userid'] = userid;
    jsonData['planid'] = planid;
    jsonData['professionalID'] = professionalID;
    jsonData['subscriptiondate'] = subscriptiondate;
    jsonData['expirydate'] = expirydate;
    jsonData['promotioncode'] = promotioncode;
    jsonData['planAmount'] = planAmount;
    jsonData['voucherAmount'] = voucherAmount;
    jsonData['chargeAmount'] = chargeAmount;
    jsonData['autorenew'] = autorenew;
    jsonData['autoBill'] = autoBill;
    jsonData['paymentMethod'] = paymentMethod;
    jsonData['paymentToken'] = paymentToken;
    jsonData['cancelDate'] = cancelDate;
    jsonData['status'] = status;
    jsonData['insertDateTime'] = insertDateTime;
    return jsonData;
  }
}
