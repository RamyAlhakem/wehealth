import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';

class BodyTempFetchWrapper {
  int? error;
  String? authResponse;
  List<BodyTempData>? dataList;

  BodyTempFetchWrapper({this.error, this.authResponse, this.dataList});

  BodyTempFetchWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      dataList = <BodyTempData>[];
      json['Data'].forEach((v) {
        dataList!.add(BodyTempData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['error'] = error;
    map['authResponse'] = authResponse;
    if (dataList != null) {
      map['Data'] = dataList!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class BodyTempData {
  int? id;
  String? user;
  String? temperaturelevel;
  String? recordDateTime;
  String? unit;
  String? tempratureCelcius;
  String? tempratureForeignheight;
  String? notes;
  String? deviceuuid;

  DateTime get recordDate => stringDateWithTZ.parse(recordDateTime ?? "0000-00-00T00:00:00.000Z");
  double get pursedTemperature => double.tryParse(temperaturelevel ?? "") ?? 0;
  double get pursedTempC => double.tryParse(tempratureCelcius ?? "") ?? 0;
  double get pursedTempF => double.tryParse(tempratureForeignheight ?? "") ?? 0;

  BodyTempData(
      {this.id,
      this.user,
      this.temperaturelevel,
      this.recordDateTime,
      this.unit,
      this.tempratureCelcius,
      this.tempratureForeignheight,
      this.notes,
      this.deviceuuid});

  BodyTempData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    temperaturelevel = json['temperaturelevel'];
    recordDateTime = json['recordDateTime'];
    unit = json['unit'];
    tempratureCelcius = json['temprature_celcius'];
    tempratureForeignheight = json['temprature_foreignheight'];
    notes = json['notes'];
    deviceuuid = json['deviceuuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['user'] = user;
    map['temperaturelevel'] = temperaturelevel;
    map['recordDateTime'] = recordDateTime;
    map['unit'] = unit;
    map['temprature_celcius'] = tempratureCelcius;
    map['temprature_foreignheight'] = tempratureForeignheight;
    map['notes'] = notes;
    map['deviceuuid'] = deviceuuid;
    return map;
  }
}

class BodyTempUploadModel {
  int? id;
  int? isUploadedToWeb;
  String? recordDateTime;
  String? recordtime;
  int? serverid;
  double? temperaturelevel;
  String? unit;
  int? userid;
  String? usernotes;

  BodyTempUploadModel(
      {this.id,
      this.isUploadedToWeb,
      this.recordDateTime,
      this.recordtime,
      this.serverid,
      this.temperaturelevel,
      this.unit,
      this.userid,
      this.usernotes});

  BodyTempUploadModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isUploadedToWeb = json['isUploadedToWeb'];
    recordDateTime = json['recordDateTime'];
    recordtime = json['recordtime'];
    serverid = json['serverid'];
    temperaturelevel = json['temperaturelevel'];
    unit = json['unit'];
    userid = json['userid'];
    usernotes = json['usernotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['isUploadedToWeb'] = isUploadedToWeb;
    map['recordDateTime'] = recordDateTime;
    map['recordtime'] = recordtime;
    map['serverid'] = serverid;
    map['temperaturelevel'] = temperaturelevel;
    map['unit'] = unit;
    map['userid'] = userid;
    map['usernotes'] = usernotes;
    return map;
  }
}
