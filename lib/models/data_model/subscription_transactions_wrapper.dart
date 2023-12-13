class SubscriptionTransactionsWrapper {
  int? error;
  String? authResponse;
  List<SubscriptionTransModel>? transactionsList;

  SubscriptionTransactionsWrapper(
      {this.error, this.authResponse, this.transactionsList});

  SubscriptionTransactionsWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      transactionsList = <SubscriptionTransModel>[];
      json['Data'].forEach((v) {
        transactionsList!.add(SubscriptionTransModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (transactionsList != null) {
      jsonData['Data'] = transactionsList!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class SubscriptionTransModel {
  int? id;
  int? userid;
  int? planid;
  String? transcdate;
  int? transactamount;
  String? paymentmethod;
  String? paymentStatus;
  String? insertDateTime;
  String? authcode;
  String? invoicenumber;
  String? securehash2;
  String? responseDesc;
  String? maskedpan;
  String? invoicePath;

  SubscriptionTransModel(
      {this.id,
      this.userid,
      this.planid,
      this.transcdate,
      this.transactamount,
      this.paymentmethod,
      this.paymentStatus,
      this.insertDateTime,
      this.authcode,
      this.invoicenumber,
      this.securehash2,
      this.responseDesc,
      this.maskedpan,
      this.invoicePath});

  SubscriptionTransModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    planid = json['planid'];
    transcdate = json['transcdate'];
    transactamount = json['transactamount'];
    paymentmethod = json['paymentmethod'];
    paymentStatus = json['paymentStatus'];
    insertDateTime = json['insertDateTime'];
    authcode = json['authcode'];
    invoicenumber = json['invoicenumber'];
    securehash2 = json['securehash2'];
    responseDesc = json['responseDesc'];
    maskedpan = json['maskedpan'];
    invoicePath = json['invoicePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['userid'] = userid;
    jsonData['planid'] = planid;
    jsonData['transcdate'] = transcdate;
    jsonData['transactamount'] = transactamount;
    jsonData['paymentmethod'] = paymentmethod;
    jsonData['paymentStatus'] = paymentStatus;
    jsonData['insertDateTime'] = insertDateTime;
    jsonData['authcode'] = authcode;
    jsonData['invoicenumber'] = invoicenumber;
    jsonData['securehash2'] = securehash2;
    jsonData['responseDesc'] = responseDesc;
    jsonData['maskedpan'] = maskedpan;
    jsonData['invoicePath'] = invoicePath;
    return jsonData;
  }
}
