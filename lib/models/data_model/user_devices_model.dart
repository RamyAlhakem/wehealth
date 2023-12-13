import '../../screens/dashboard/drawer/home/appointment/appt_constants.dart';

class UserDevicesWrapper {
  int? error;
  String? authResponse;
  List<UserDeviceModel>? deviceData;

  UserDevicesWrapper({this.error, this.authResponse, this.deviceData});

  UserDevicesWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      deviceData = <UserDeviceModel>[];
      json['Data'].forEach((v) {
        deviceData!.add(UserDeviceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (deviceData != null) {
      jsonData['Data'] = deviceData!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class UserDeviceModel {
  int? id;
  int? deviceid;
  int? userid;
  String? devicetypeid;
  String? deviceuuid;
  String? firstpairingtime;
  String? devicename;
  String? devicebond;
  String? devicebletype;
  int? devicestatus;
  int? devicesettingsstatus;
  String? lastsynchtime;
  String? insertionDateTime;

  DateTime? get insertDate => (insertionDateTime == null)
      ? null
      : stringDateWithTZ.parse(insertionDateTime!);

  UserDeviceModel(
      {this.id,
      this.deviceid,
      this.userid,
      this.devicetypeid,
      this.deviceuuid,
      this.firstpairingtime,
      this.devicename,
      this.devicebond,
      this.devicebletype,
      this.devicestatus,
      this.devicesettingsstatus,
      this.lastsynchtime,
      this.insertionDateTime});

  UserDeviceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceid = json['deviceid'];
    userid = json['userid'];
    devicetypeid = json['devicetypeid'];
    deviceuuid = json['deviceuuid'];
    firstpairingtime = json['firstpairingtime'];
    devicename = json['devicename'];
    devicebond = json['devicebond'];
    devicebletype = json['devicebletype'];
    devicestatus = json['devicestatus'];
    devicesettingsstatus = json['devicesettingsstatus'];
    lastsynchtime = json['lastsynchtime'];
    insertionDateTime = json['insertionDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['deviceid'] = deviceid;
    jsonData['userid'] = userid;
    jsonData['devicetypeid'] = devicetypeid;
    jsonData['deviceuuid'] = deviceuuid;
    jsonData['firstpairingtime'] = firstpairingtime;
    jsonData['devicename'] = devicename;
    jsonData['devicebond'] = devicebond;
    jsonData['devicebletype'] = devicebletype;
    jsonData['devicestatus'] = devicestatus;
    jsonData['devicesettingsstatus'] = devicesettingsstatus;
    jsonData['lastsynchtime'] = lastsynchtime;
    jsonData['insertionDateTime'] = insertionDateTime;
    return jsonData;
  }

  String get convertedName {
    switch (devicetypeid) {
      case "1":
        return "Walk Tracker";
      case "2":
        return "Chief Weighting Scale";
      case "3":
        return "Blood Pressure";
      case "4":
        return "Blood Oxygen";
      case "6":
        return "Nutritionist Scale";
      case "8":
        return "Fitness Tracker";
      case "11":
        return "Body Temperature";
      case "13":
        return "Blood Glucose";
      case "15":
        return "We Health Body Health Analyzer";
      case "18":
        return "CHIEF Smart Body Analyzer";
      case "19":
        return (devicename == "M2")
            ? "Blood Pressure Tracker"
            : "Checkup Asia Band";
      case "30":
        return "Google Fit";
      case "35":
        return "Roche Glucometer";
      case "36":
        return "Rossmax Blood Pressure";
      case "37":
        return "Microlife Blood Pressure";
      case "40":
        return "Apple Health";
      default:
        return "";
    }
  }

  String get imageLink {
    switch (devicebletype) {
      case "1":
        return "assets/icons/devices/walk_200px.webp";
      case "2":
        return "assets/icons/devices/scale_200px.webp";
      case "3":
        return "assets/icons/devices/rsz_1bp.webp";
      case "4":
        return "assets/icons/devices/rsz_oxi.webp";
      case "6":
        return "assets/icons/devices/nutritionisticon.webp";
      case "8":
        return "assets/icons/devices/newtracker.webp";
      case "11":
        return "assets/icons/devices/bodytempicon.webp";
      case "13":
        return "assets/icons/devices/rocheglucometer.png";
      case "15":
        return "assets/icons/devices/bodyanalyzertut.webp";
      case "18":
        return "assets/icons/devices/center_logo.webp";
      case "30":
        return "assets/icons/devices/googlefit.webp";
      case "35":
        return "assets/icons/devices/yongnuo_bg.webp";
      case "36":
        return "assets/icons/devices/rossmax_meter.png";
      case "37":
        return "assets/icons/devices/microlife_bp.png";
      case "40":
        return "assets/icons/devices/apple_health.png";
      default:
        return "assets/images/image_placeholder.png";
    }
  }
}
