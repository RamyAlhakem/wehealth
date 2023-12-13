class ProfileHospitalListWrapper {
  int? error;
  String? authResponse;
  List<ProfileHospitalModel>? hospitalList;

  ProfileHospitalListWrapper(
      {this.error, this.authResponse, this.hospitalList});

  ProfileHospitalListWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      hospitalList = <ProfileHospitalModel>[];
      json['Data'].forEach((v) {
        hospitalList!.add(ProfileHospitalModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (hospitalList != null) {
      jsonData['Data'] = hospitalList!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class ProfileHospitalModel {
  int? id;
  String? name;
  String? address;
  String? phone;
  String? contactPerson;
  int? status;
  int? type;
  String? refrence;
  String? invoicePrefix;
  int? lastInvoiceNo;
  String? insertionDateTime;
  int? appointment;

  ProfileHospitalModel(
      {this.id,
      this.name,
      this.address,
      this.phone,
      this.contactPerson,
      this.status,
      this.type,
      this.refrence,
      this.invoicePrefix,
      this.lastInvoiceNo,
      this.insertionDateTime,
      this.appointment});

  ProfileHospitalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    contactPerson = json['contactPerson'];
    status = json['status'];
    type = json['type'];
    refrence = json['refrence'];
    invoicePrefix = json['invoicePrefix'];
    lastInvoiceNo = json['lastInvoiceNo'];
    insertionDateTime = json['insertionDateTime'];
    appointment = json['appointment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['name'] = name;
    jsonData['address'] = address;
    jsonData['phone'] = phone;
    jsonData['contactPerson'] = contactPerson;
    jsonData['status'] = status;
    jsonData['type'] = type;
    jsonData['refrence'] = refrence;
    jsonData['invoicePrefix'] = invoicePrefix;
    jsonData['lastInvoiceNo'] = lastInvoiceNo;
    jsonData['insertionDateTime'] = insertionDateTime;
    jsonData['appointment'] = appointment;
    return jsonData;
  }
}
