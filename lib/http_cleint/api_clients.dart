// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClients {
  static SharedPreferences? sharedPrefs;
  static Dio? dio;

  static Future updateHeader({
    SharedPreferences? prefs,
    String? newToken,
  }) async {
    dio = Dio();
    if (prefs != null) {
      sharedPrefs = prefs;
    }
    if (newToken != null) {
      sharedPrefs!.setString('user_token', newToken);
    }
    String token = sharedPrefs!.getString('first_token') ?? "";
    print("token in postting ===>> $token");
    dio!.options.headers['Authorization'] = 'Bearer $token';
    dio!.options.headers['Connection'] = 'keep-alive';
  }

  static Future postJson(dynamic params, String url) async {
    Response response;

    try {
      print('trying to upload...');
      response = await dio!.post(url, data: params);
      print(response);
      return response.data;
    } catch (e) {
      print(e.toString());
      return {"code": -999, "message": "$url|$e"};
    }
  }

  //static Future<Map<String, dynamic>> getJson(String url) async {

  static Future getJson(String url, [Options? option]) async {
    Response response;
    try {
      response = await dio!.get(
        url,
        options: option,
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return {"code": -999, "desc": "connection failed"};
      }
    } catch (e) {
      print(e.toString());
      return {"code": -999, "message": "$url|$e"};
    }
  }

  /* 
  * Post FormData
  * In Sender from
  * In User Login
  */

  static Future postFormMap(Map<String, dynamic> body, String url,
      [Options? optionalHeader]) async {
    Response response;
    print('geeting url when posting data ==> $url');
    print('getting body response when posting data ===> $body');

    try {
      print('trying to upload...');
      var formData = FormData.fromMap(body);
      response = await dio!.post(url, data: formData, options: optionalHeader);
      print("getting post responnse ===>>> $response");
      return response.data;
    } catch (e) {
      print("posting data error is here ===>>> ${e.toString()}");

      return {"message": "$url|$e"};
    }
  }

  static Future postFormUrlEncodedData(Map<String, dynamic> data, String url,
      [Options? option]) async {
    Response response;
    // print('geeting url when posting data ==> $url');
    log('getting body response when posting data ===> $data');

    try {
      print('trying to upload...');
      response = await dio!.post(
        url,
        data: data,
        options: option ??
            Options(
              contentType: Headers.formUrlEncodedContentType,
            ),
      );
      print("getting post responnse ===>>> $response");
      return response.data;
    } catch (e) {
      print("posting data error is here ===>>> ${e.toString()}");

      return {"message": "$url|$e"};
    }
  }

  //To put Data
  static Future putJson(Map<String, dynamic> params, String url) async {
    Response response;

    try {
      print('trying to upload...');
      response = await dio!.put(url, data: params);
      print(response);
      return response.data;
    } catch (e) {
      print(e.toString());
      return {"code": -999, "message": "$url|$e"};
    }
  }
}
