class BloodGlucoseDataUploadModel {
  int? id;
  String? deviceid;
  int? devicetype;
  String? deviceuuid;
  double? glucoseLevel;
  bool? isSection;
  int? isUploadedToWeb;
  String? mealType;
  String? notes;
  String? recordDatetime;
  String? recordtime;
  int? serverid;
  int? userid;

  BloodGlucoseDataUploadModel(
      {this.id,
      this.deviceid,
      this.devicetype,
      this.deviceuuid,
      this.glucoseLevel,
      this.isSection,
      this.isUploadedToWeb,
      this.mealType,
      this.notes,
      this.recordDatetime,
      this.recordtime,
      this.serverid,
      this.userid});

  BloodGlucoseDataUploadModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceid = json['deviceid'];
    devicetype = json['devicetype'];
    deviceuuid = json['deviceuuid'];
    glucoseLevel = json['glucose_level'];
    isSection = json['isSection'];
    isUploadedToWeb = json['isUploadedToWeb'];
    mealType = json['meal_type'];
    notes = json['notes'];
    recordDatetime = json['record_datetime'];
    recordtime = json['recordtime'];
    serverid = json['serverid'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['deviceid'] = deviceid;
    map['devicetype'] = devicetype;
    map['deviceuuid'] = deviceuuid;
    map['glucose_level'] = glucoseLevel;
    map['isSection'] = isSection;
    map['isUploadedToWeb'] = isUploadedToWeb;
    map['meal_type'] = mealType;
    map['notes'] = notes;
    map['record_datetime'] = recordDatetime;
    map['recordtime'] = recordtime;
    map['serverid'] = serverid;
    map['userid'] = userid;
    return map;
  }
}
