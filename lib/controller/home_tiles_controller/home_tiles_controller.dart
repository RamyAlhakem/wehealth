import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wehealth/controller/home_tiles_controller/home_tiles_repository.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/constants/color_resources.dart';

class HomeTileController extends GetxController {
  final HomeTilesRepository _repository =
      HomeTilesRepository(storage: Get.find<StorageController>());

  List<HomeClassTile> prefTiles = [
    PhysicalActivity(index: 0),
    Sleep(index: 1),
    BodyMeasurement(index: 2),
    DietaryIntake(index: 3),
    MedAssist(index: 4),
    BloodGlucose(index: 5),
    BloodPressure(index: 6),
    HeartRate(index: 7),
    BodyTemperature(index: 8),
    BloodOxygen(index: 9),
    Family(index: 10),
    MyHealth(index: 11),
  ];

  List<HomeClassTile> tiles = [];

  static const cardManagementKey = "CARD_MANAGEMENT";

  reOrderFunction(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    HomeClassTile data = tiles.removeAt(oldIndex);
    tiles.insert(newIndex, data);
    for (var element in tiles.asMap().entries) {
      tiles[element.key].updateIndex(element.key + 1);
    }
    tiles.sort(
      (a, b) => a.currentIndex.compareTo(b.currentIndex),
    );
    log("REorder UPdate => Old index => $oldIndex $newIndex, Length => ${tiles.length}");
    update();
    _repository.postHomeTiles(tiles.map((e) => e.toMap()).toList());
    saveLocally();
  }

  saveLocally() async {
    SharedPreferences prefs = StorageController.instance().prefs!;
    await prefs.setStringList(
        cardManagementKey, tiles.map((e) => json.encode(e.toMap())).toList());
    log("#Locally Saved ${tiles.map((e) => json.encode(e.toMap())).toList().toString()}");
  }

  Future<List<HomeCard>?> getFromLocal() async {
    SharedPreferences prefs = StorageController.instance().prefs!;
    if (prefs.containsKey(cardManagementKey)) {
      List<String>? data = prefs.getStringList(cardManagementKey);
      final list = data
          ?.map(
            (e) => HomeCard.fromJson(
              json.decode(e),
            ),
          )
          .toList();
      list?.sort(
        (a, b) => a.position!.compareTo(b.position!),
      );
    }
    return null;
  }

  activitySetting(int index, bool value) {
    StorageController.instance();
    tiles[index].changeActivity(value);
    _repository.postHomeTiles([tiles[index].toMap()]);
    update();
    saveLocally();
  }

  List<HomeClassTile> get tilesForHome {
    return tiles.isEmpty
        ? prefTiles
        : tiles.where((element) => element.isActive).toList().sublist(
            0,
            math.min(
                5, tiles.where((element) => element.isActive).toList().length));
  }

  getAndSetTilesData({bool ignoreLocal = false}) async {
    final data = await getFromLocal();
    log("#Local Card data => ${data.toString()}");
    if (data != null) {
      tiles.clear();
      for (var item in data) {
        log(item.activity!);
        tiles.add(prefTiles
            .where((single) => item.activity == single.identifier)
            .first
          ..updateId(item.id!)
          ..updateIndex(item.position!)
          ..changeActivity(item.enable == 1));
      }
    } else {
      log("trying to fetch");
      try {
        UserCardsWrapper? response = await _repository.getHomeTiles();
        log("${response?.toJson().toString()}");
        if (response != null && response.homeCardList != null) {
          tiles.clear();
          if (response.homeCardList!.isEmpty) {
            tiles = [...prefTiles];
          }
          for (var item in response.homeCardList!) {
            log(item.activity!);
            if (!(tiles
                .any((element) => element.identifier == item.activity))) {
              tiles.add(
                prefTiles
                    .where((single) => item.activity == single.identifier)
                    .first
                  ..updateId(item.id!)
                  ..updateIndex(item.position!)
                  ..changeActivity(item.enable == 1),
              );
            }
          }
          saveLocally();
        }
        update();
      } catch (error) {
        log("Error while updating fetchHomeTilesData => $error");
      }
    }
  }
}

class HomeClassTile {
  Color baseColor;
  bool isActive;
  String identifier;
  int currentIndex;
  String title = "Default";
  String imageIcon = "";
  int id;
  int get userId => StorageController.instance().userId;

  HomeClassTile._({
    required this.identifier,
    required this.currentIndex,
    required int cardId,
    this.baseColor = Colors.blue,
    this.isActive = false,
  }) : id = cardId;

  changeActivity(bool sentValue) => isActive = sentValue;

  updateId(int newId) => id = newId;

  updateIndex(int newIndex) => currentIndex = newIndex;

  Map<String, dynamic> toMap() {
    return {
      "activity": identifier,
      "enable": isActive ? 1 : 0,
      "id": id,
      "isuploadedtoweb": 0,
      "position": currentIndex,
      "userID": userId,
    };
  }
}

class PhysicalActivity extends HomeClassTile {
  PhysicalActivity({required this.index, this.activity = true, int? id})
      : super._(
          identifier: 'physicalactivity',
          currentIndex: index,
          isActive: activity,
          cardId: id ?? index,
        );
  bool activity;
  int index;

  @override
  Color get baseColor => Colors.blue;

  @override
  String get title => "Physical Activity";

  @override
  String get imageIcon => "assets/images/illustration_physical_activity.webp";
}

class Sleep extends HomeClassTile {
  Sleep({required this.index, this.activity = true, int? id})
      : super._(
          identifier: 'sleepactivity',
          currentIndex: index,
          isActive: activity,
          cardId: id ?? index,
        );
  bool activity;
  int index;

  @override
  Color get baseColor => Colors.purple.shade300;

  @override
  String get title => "Sleep";

  @override
  String get imageIcon => "assets/images/illustration_sleep.webp";
}

class BodyMeasurement extends HomeClassTile {
  BodyMeasurement({required this.index, this.activity = true, int? id})
      : super._(
          identifier: 'bodymeasurement',
          currentIndex: index,
          isActive: activity,
          cardId: id ?? index,
        );
  bool activity;
  int index;

  @override
  Color get baseColor => Colors.yellow.shade800;

  @override
  String get title => "Body Measurement";

  @override
  String get imageIcon => "assets/images/illustration_body_measurement.webp";
}

class DietaryIntake extends HomeClassTile {
  DietaryIntake({required this.index, this.activity = true, int? id})
      : super._(
          identifier: 'dietaryintake',
          currentIndex: index,
          isActive: activity,
          cardId: id ?? index,
        );
  bool activity;
  int index;

  @override
  Color get baseColor => Colors.green.shade700;

  @override
  String get title => "Dietary Intake";

  @override
  String get imageIcon => "assets/images/illustration_diet.webp";
}

class MedAssist extends HomeClassTile {
  MedAssist({required this.index, this.activity = true, int? id})
      : super._(
          identifier: 'medassist',
          currentIndex: index,
          isActive: activity,
          cardId: id ?? index,
        );
  bool activity;
  int index;

  @override
  Color get baseColor => Colors.pinkAccent;

  @override
  String get title => "Med Assist";

  @override
  String get imageIcon => "assets/images/illustration_medassist.webp";
}

class BloodGlucose extends HomeClassTile {
  BloodGlucose({required this.index, this.activity = true, int? id})
      : super._(
          identifier: 'bloodGlucose',
          currentIndex: index,
          isActive: activity,
          cardId: id ?? index,
        );
  bool activity;
  int index;

  @override
  Color get baseColor => Colors.grey;

  @override
  String get title => "Blood Glucose";

  @override
  String get imageIcon => "assets/images/illustration_blood_glucose.webp";
}

class BloodPressure extends HomeClassTile {
  BloodPressure({required this.index, this.activity = true, int? id})
      : super._(
          identifier: 'bloodpressure',
          currentIndex: index,
          isActive: activity,
          cardId: id ?? index,
        );
  bool activity;
  int index;

  @override
  Color get baseColor => Colors.orange.shade400;

  @override
  String get title => "Blood Pressure";

  @override
  String get imageIcon => "assets/images/illustration_blood_pressure.webp";
}

class HeartRate extends HomeClassTile {
  HeartRate({required this.index, this.activity = true, int? id})
      : super._(
          identifier: 'heartrate',
          currentIndex: index,
          isActive: activity,
          cardId: id ?? index,
        );
  bool activity;
  int index;

  @override
  Color get baseColor => Colors.green.shade400;

  @override
  String get title => "Heart Rate";

  @override
  String get imageIcon => "assets/images/heartrateillustration.webp";
}

class BodyTemperature extends HomeClassTile {
  BodyTemperature({required this.index, this.activity = true, int? id})
      : super._(
          identifier: 'bodytemperature',
          currentIndex: index,
          isActive: activity,
          cardId: id ?? index,
        );
  bool activity;
  int index;

  @override
  Color get baseColor => Colors.red;

  @override
  String get title => "Body Temperature";

  @override
  String get imageIcon => "assets/images/temperature.webp";
}

class BloodOxygen extends HomeClassTile {
  BloodOxygen({required this.index, this.activity = true, int? id})
      : super._(
          identifier: 'spo2',
          currentIndex: index,
          isActive: activity,
          cardId: id ?? index,
        );
  bool activity;
  int index;

  @override
  Color get baseColor => ColorResources.bloodOxygenScreenColor;

  @override
  String get title => "Blood Oxygen";

  @override
  String get imageIcon => "assets/images/spo2umch.webp";
}

class Family extends HomeClassTile {
  Family({required this.index, this.activity = true, int? id})
      : super._(
          identifier: 'family',
          currentIndex: index,
          isActive: activity,
          cardId: id ?? index,
        );
  bool activity;
  int index;

  @override
  Color get baseColor => Colors.pink.shade200;

  @override
  String get title => "Family";

  @override
  String get imageIcon => "assets/images/familydashboard.webp";
}

class MyHealth extends HomeClassTile {
  MyHealth({required this.index, this.activity = true, int? id})
      : super._(
          identifier: 'selfcheckin',
          currentIndex: index,
          isActive: activity,
          cardId: id ?? index,
        );
  bool activity;
  int index;

  @override
  Color get baseColor => Colors.green.shade700;

  @override
  String get title => "My Health";

  @override
  String get imageIcon => "assets/images/ummc.png";
}

class UserCardsWrapper {
  int? error;
  String? authResponse;
  List<HomeCard>? homeCardList;

  UserCardsWrapper({this.error, this.authResponse, this.homeCardList});

  UserCardsWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      homeCardList = <HomeCard>[];
      json['Data'].forEach((v) {
        if (v['activity'] != "undefined") {
          homeCardList!.add(HomeCard.fromJson(v));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    jsonData['authResponse'] = authResponse;
    if (homeCardList != null) {
      jsonData['Data'] = homeCardList!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class HomeCard {
  int? id;
  int? userID;
  int? enable;
  String? activity;
  int? position;
  String? insertionDateTime;

  HomeCard(
      {this.id,
      this.userID,
      this.enable,
      this.activity,
      this.position,
      this.insertionDateTime});

  HomeCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    enable = json['enable'];
    activity = json['activity'];
    position = json['position'];
    insertionDateTime = json['insertionDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['userID'] = userID;
    jsonData['enable'] = enable;
    jsonData['activity'] = activity;
    jsonData['position'] = position;
    jsonData['insertionDateTime'] = insertionDateTime;
    return jsonData;
  }
}
