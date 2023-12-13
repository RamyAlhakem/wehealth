class AddUserDeviceDataModel {
  int? devicebond;
  String? devicename;
  int? devicebletype;
  int? devicetypeid;
  String? deviceuuid;
  int? devicesettingsstatus;
  int? devicestatus;
  String? firstpairingtime;
  int? isuplaodedtoweb;
  String? lastsynchtime;
  int? id;
  int? deviceid;
  int? userID;

  AddUserDeviceDataModel({
    this.devicebond,
    this.devicename,
    this.devicebletype,
    this.devicetypeid,
    this.deviceuuid,
    this.devicesettingsstatus,
    this.devicestatus,
    this.firstpairingtime,
    this.isuplaodedtoweb,
    this.lastsynchtime,
    this.id,
    this.deviceid,
    this.userID,
  });

  AddUserDeviceDataModel.fromJson(Map<String, dynamic> json) {
    devicebond = json['devicebond'];
    devicename = json['devicename'];
    devicebletype = json['devicebletype'];
    devicetypeid = json['devicetypeid'];
    deviceuuid = json['deviceuuid'];
    devicesettingsstatus = json['devicesettingsstatus'];
    devicestatus = json['devicestatus'];
    firstpairingtime = json['firstpairingtime'];
    isuplaodedtoweb = json['isuplaodedtoweb'];
    lastsynchtime = json['lastsynchtime'];
    id = json['id'];
    deviceid = json['deviceid'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['devicebond'] = devicebond;
    map['devicename'] = devicename;
    map['devicebletype'] = devicebletype;
    map['devicetypeid'] = devicetypeid;
    map['deviceuuid'] = deviceuuid;
    map['devicesettingsstatus'] = devicesettingsstatus;
    map['devicestatus'] = devicestatus;
    map['firstpairingtime'] = firstpairingtime;
    map['isuplaodedtoweb'] = isuplaodedtoweb;
    map['lastsynchtime'] = lastsynchtime;
    map['id'] = id;
    map['deviceid'] = deviceid;
    map['userID'] = userID;
    return map;
  }
}
