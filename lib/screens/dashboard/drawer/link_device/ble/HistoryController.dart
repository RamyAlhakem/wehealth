import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wehealth/controller/home_tiles_controller/home_tiles_controller.dart';
import 'package:wehealth/screens/dashboard/drawer/link_device/ble/Helper.dart';
import 'package:wehealth/screens/dashboard/drawer/link_device/new_device_screen.dart';
import 'package:dio/dio.dart';

class HistoryController with ChangeNotifier {
  List history = [];
  // ignore: unnecessary_new
  Dio dio = new Dio();

  bool isenable = true;

  int i = 0;
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

  clearcachehistory() async {
    pref = await SharedPreferences.getInstance();
    pref.remove("myhistory");
  }

  addpost() async {
    final url = Uri.parse("https://staging-api-v2.umchtech.com/api/app");
    // final List<dynamic> DataHistory = [];
    // for (var item in updatehistory) {
    //   DataHistory.add(item);
    // }
    // String jsondata = jsonEncode(DataHistory);

    var data = {
      "systolic": updatehistory[i]["systole"].toString(),
      "diastolic": updatehistory[i]["dia"].toString(),
      "pulse": updatehistory[i]["pul"].toString(),
      "recordTime":
          "${updatehistory[i]["day"]}/${updatehistory[i]["month"]}/${updatehistory[i]["year"]}  ${updatehistory[i]["hour"]}:${updatehistory[i]["mint"]}",
      "unit": "mmHg",
      "deviceid": " B3 BT",
      "deviceuuid": "DC:72:9C:6B:F7:9D",
      "notes": "null",
      "userID": "junkkl2021@gmail.com",
      "deviceStatus": "44",
      "bpID": " 6934112",
      "isdeleted": "0",
    };
    i++;
    var params = {
      "data": [data]
    };

    var response = await http.post(url, body: params);
    var responsebody = jsonDecode(response.body);
    Helper.log("response body$responsebody", color: DebugColor.yellow);
  }

  getpost() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    final resopnse = await http.get(url);
    var responsebody = jsonDecode(resopnse.body);
    print(responsebody);
  }

  postdata() async {
    final String pathurl =
        "https://staging-api-v2.umchtech.com/api/app/addBloodPressure";

    var data = {
      "systolic": updatehistory[i]["systole"].toString(),
      "diastolic": updatehistory[i]["dia"].toString(),
      "pulse": updatehistory[i]["pul"].toString(),
      "recordTime":
          "${updatehistory[i]["day"]}/${updatehistory[i]["month"]}/${updatehistory[i]["year"]}  ${updatehistory[i]["hour"]}:${updatehistory[i]["mint"]}",
      "unit": "mmHg",
      "deviceid": " B3 BT",
      "deviceuuid": "DC:72:9C:6B:F7:9D",
      "notes": "null",
      "userID": "junkkl2021@gmail.com",
      "deviceStatus": "44",
      "bpID": " 6934112",
      "isdeleted": "0",
    };
    var parm = {
      "data": [data]
    };
    try {
      var response = await dio.post(
        pathurl,
        data: parm,
        options: Options(headers: {
          // "Authorization":
          //     "UyCUDJt1f6YNUpsjEQSlsV9wKcQNG6y7Od0PnaIFbx9QkdibOLZmFzcw3HR5OSnJ",
          "Accept": "application/json",
          "Content-Type": "application/json",
          "token":
              "pgNgzRwT2vavU8uwPK2SAdacIohJg7Fy1705889962" // Fix the content-type header
        }),
      );
      Helper.log("response data: ${response.data}", color: DebugColor.yellow);
    } catch (error) {
      print("Error: $error");
    }
  }
}
