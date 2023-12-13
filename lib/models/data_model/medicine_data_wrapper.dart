class MedicineDataWrapper {
  int? error;
  String? authResponse;
  List<MedicineData>? medicineList;

  MedicineDataWrapper({this.error, this.authResponse, this.medicineList});

  MedicineDataWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      medicineList = <MedicineData>[];
      json['Data'].forEach((v) {
        medicineList!.add(MedicineData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (medicineList != null) {
      jsonData['Data'] = medicineList!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class MedicineData {
  int? id;
  String? indication;
  String? medicineName;
  String? isCombination;
  String? brandName;
  int? strengthsupplied;
  String? unit;
  String? take;
  String? insertionDateTime;

  MedicineData(
      {this.id,
      this.indication,
      this.medicineName,
      this.isCombination,
      this.brandName,
      this.strengthsupplied,
      this.unit,
      this.take,
      this.insertionDateTime});

  MedicineData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    indication = json['indication'];
    medicineName = json['medicineName'];
    isCombination = json['isCombination'];
    brandName = json['BrandName'];
    strengthsupplied = json['strengthsupplied'];
    unit = json['unit'];
    take = json['take'];
    insertionDateTime = json['insertionDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['indication'] = indication;
    jsonData['medicineName'] = medicineName;
    jsonData['isCombination'] = isCombination;
    jsonData['BrandName'] = brandName;
    jsonData['strengthsupplied'] = strengthsupplied;
    jsonData['unit'] = unit;
    jsonData['take'] = take;
    jsonData['insertionDateTime'] = insertionDateTime;
    return jsonData;
  }
}
