class AddMyMedicineClass {
  int? beforeActualTimeRemind;
  String? colour;
  String? days;
  int? daysBeforeMedicineOut;
  String? deviceID;
  String? dosageUnit;
  String? endDate;
  int? id;
  String? insertDateTime;
  String? insertionDate;
  String? instruction;
  int? isUploadedToWeb;
  bool? ispharmacyrefillreminder;
  bool? isreminder;
  bool? isvibration;
  int? medicineID;
  String? medicineTakeType;
  String? medicineTake;
  int? quantitySupplied;
  int? refilReminder;
  int? reminderType;
  int? serverId;
  String? shape;
  String? startDate;
  int? strengthSupplied;
  String? strengthTaken;
  String? timingPerDay;
  String? tune;
  String? unit;
  String? units;
  int? userID;
  int? variableDose;

  AddMyMedicineClass(
      {this.beforeActualTimeRemind,
      this.colour,
      this.days,
      this.daysBeforeMedicineOut,
      this.deviceID,
      this.dosageUnit,
      this.endDate,
      this.id,
      this.insertDateTime,
      this.insertionDate,
      this.instruction,
      this.isUploadedToWeb,
      this.ispharmacyrefillreminder,
      this.isreminder,
      this.isvibration,
      this.medicineID,
      this.medicineTakeType,
      this.medicineTake,
      this.quantitySupplied,
      this.refilReminder,
      this.reminderType,
      this.serverId,
      this.shape,
      this.startDate,
      this.strengthSupplied,
      this.strengthTaken,
      this.timingPerDay,
      this.tune,
      this.unit,
      this.units,
      this.userID,
      this.variableDose});

  AddMyMedicineClass.fromJson(Map<String, dynamic> json) {
    beforeActualTimeRemind = json['beforeActualTimeRemind'];
    colour = json['colour'];
    days = json['days'];
    daysBeforeMedicineOut = json['daysBeforeMedicineOut'];
    deviceID = json['deviceID'];
    dosageUnit = json['dosageUnit'];
    endDate = json['endDate'];
    id = json['id'];
    insertDateTime = json['insertDateTime'];
    insertionDate = json['insertionDate'];
    instruction = json['instruction'];
    isUploadedToWeb = json['isUploadedToWeb'];
    ispharmacyrefillreminder = json['ispharmacyrefillreminder'];
    isreminder = json['isreminder'];
    isvibration = json['isvibration'];
    medicineID = json['medicineID'];
    medicineTakeType = json['medicineTakeType'];
    medicineTake = json['medicineTake'];
    quantitySupplied = json['quantitySupplied'];
    refilReminder = json['refilReminder'];
    reminderType = json['reminderType'];
    serverId = json['serverId'];
    shape = json['shape'];
    startDate = json['startDate'];
    strengthSupplied = json['strengthSupplied'];
    strengthTaken = json['strengthTaken'];
    timingPerDay = json['timingPerDay'];
    tune = json['tune'];
    unit = json['unit'];
    units = json['units'];
    userID = json['userID'];
    variableDose = json['variableDose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['beforeActualTimeRemind'] = beforeActualTimeRemind;
    jsonData['colour'] = colour;
    jsonData['days'] = days;
    jsonData['daysBeforeMedicineOut'] = daysBeforeMedicineOut;
    jsonData['deviceID'] = deviceID;
    jsonData['dosageUnit'] = dosageUnit;
    jsonData['endDate'] = endDate;
    jsonData['id'] = id;
    jsonData['insertDateTime'] = insertDateTime;
    jsonData['insertionDate'] = insertionDate;
    jsonData['instruction'] = instruction;
    jsonData['isUploadedToWeb'] = isUploadedToWeb;
    jsonData['ispharmacyrefillreminder'] = ispharmacyrefillreminder;
    jsonData['isreminder'] = isreminder;
    jsonData['isvibration'] = isvibration;
    jsonData['medicineID'] = medicineID;
    jsonData['medicineTakeType'] = medicineTakeType;
    jsonData['medicineTake'] = medicineTake;
    jsonData['quantitySupplied'] = quantitySupplied;
    jsonData['refilReminder'] = refilReminder;
    jsonData['reminderType'] = reminderType;
    jsonData['serverId'] = serverId;
    jsonData['shape'] = shape;
    jsonData['startDate'] = startDate;
    jsonData['strengthSupplied'] = strengthSupplied;
    jsonData['strengthTaken'] = strengthTaken;
    jsonData['timingPerDay'] = timingPerDay;
    jsonData['tune'] = tune;
    jsonData['unit'] = unit;
    jsonData['units'] = units;
    jsonData['userID'] = userID;
    jsonData['variableDose'] = variableDose;
    return jsonData;
  }
}
