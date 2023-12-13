class MedicineDataPostingModel {
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

  MedicineDataPostingModel(
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

  MedicineDataPostingModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = {};
    data['beforeActualTimeRemind'] = beforeActualTimeRemind;
    data['colour'] = colour;
    data['days'] = days;
    data['daysBeforeMedicineOut'] = daysBeforeMedicineOut;
    data['deviceID'] = deviceID;
    data['dosageUnit'] = dosageUnit;
    data['endDate'] = endDate;
    data['id'] = id;
    data['insertDateTime'] = insertDateTime;
    data['insertionDate'] = insertionDate;
    data['instruction'] = instruction;
    data['isUploadedToWeb'] = isUploadedToWeb;
    data['ispharmacyrefillreminder'] = ispharmacyrefillreminder;
    data['isreminder'] = isreminder;
    data['isvibration'] = isvibration;
    data['medicineID'] = medicineID;
    data['medicineTakeType'] = medicineTakeType;
    data['medicineTake'] = medicineTake;
    data['quantitySupplied'] = quantitySupplied;
    data['refilReminder'] = refilReminder;
    data['reminderType'] = reminderType;
    data['serverId'] = serverId;
    data['shape'] = shape;
    data['startDate'] = startDate;
    data['strengthSupplied'] = strengthSupplied;
    data['strengthTaken'] = strengthTaken;
    data['timingPerDay'] = timingPerDay;
    data['tune'] = tune;
    data['unit'] = unit;
    data['units'] = units;
    data['userID'] = userID;
    data['variableDose'] = variableDose;
    return data;
  }
}
