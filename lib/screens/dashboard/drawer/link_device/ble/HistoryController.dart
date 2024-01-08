import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryController with ChangeNotifier {
  List history = [];
  bool isenable = true;
  late SharedPreferences pref;

  save(dynamic checkup) {
    history.add(checkup);
    notifyListeners();
  }

  List get updatehistory {
    return history;
  }

  disablebutton() {
    isenable = false;
    notifyListeners();
  }

  enablebutton() {
    isenable = true;
    notifyListeners();
  }

  clearhistory() {
    updatehistory.clear();
    notifyListeners();
  }

  SaveData() async {
    pref = await SharedPreferences.getInstance();
    String jsonstring = json.encode(updatehistory);
    await pref.setString("myhistory", jsonstring);
  }

  LoadData() async {
    pref = await SharedPreferences.getInstance();
    String jsonstring = pref.getString("myhistory") ?? "";
    if (jsonstring != null) {
      json.decode(jsonstring);
      List<dynamic> savedhistory = json.decode(jsonstring);
      history = savedhistory;
      notifyListeners();
    }
  }
  clearcachehistory()async{
    pref=await SharedPreferences.getInstance();
    pref.remove("myhistory");
  }
}
