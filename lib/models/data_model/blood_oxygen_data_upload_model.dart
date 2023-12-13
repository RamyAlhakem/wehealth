class BloodOxygenDataUploadModel {
  int? id;
  String? deviceid;
  int? devicetype;
  String? deviceuuid;
  int? isUploadedToWeb;
  bool? issectionheader;
  String? notes;
  int? oxygenlevel;
  int? pulse;
  String? recordDateTime;
  String? recordtime;
  int? serverid;
  int? userID;

  BloodOxygenDataUploadModel(
      {this.id,
      this.deviceid,
      this.devicetype,
      this.deviceuuid,
      this.isUploadedToWeb,
      this.issectionheader,
      this.notes,
      this.oxygenlevel,
      this.pulse,
      this.recordDateTime,
      this.recordtime,
      this.serverid,
      this.userID});

  BloodOxygenDataUploadModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceid = json['deviceid'];
    devicetype = json['devicetype'];
    deviceuuid = json['deviceuuid'];
    isUploadedToWeb = json['isUploadedToWeb'];
    issectionheader = json['issectionheader'];
    notes = json['notes'];
    oxygenlevel = json['oxygenlevel'];
    pulse = json['pulse'];
    recordDateTime = json['record_date_time'];
    recordtime = json['recordtime'];
    serverid = json['serverid'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deviceid'] = deviceid;
    data['devicetype'] = devicetype;
    data['deviceuuid'] = deviceuuid;
    data['isUploadedToWeb'] = isUploadedToWeb;
    data['issectionheader'] = issectionheader;
    data['notes'] = notes;
    data['oxygenlevel'] = oxygenlevel;
    data['pulse'] = pulse;
    data['record_date_time'] = recordDateTime;
    data['recordtime'] = recordtime;
    data['serverid'] = serverid;
    data['userID'] = userID;
    return data;
  }
}
