import 'dart:async';

import 'package:dio/dio.dart';
import 'package:wehealth/http_cleint/api_clients.dart';

class TwilioFunctionsService {
  TwilioFunctionsService._();
  static final instance = TwilioFunctionsService._();
  final accessTokenUrl = 'https://umchtech.com/twilio/index.php';

  Future<dynamic> createToken(String identity, int roomName) async {
    try {
      Map<String, dynamic> data = {
        "user_identity": identity,
        "room_name": roomName,
      };

      var response = await ApiClients.postFormUrlEncodedData(
        data,
        accessTokenUrl,
        Options(
          contentType: Headers.jsonContentType,
        ),
      );
      return Map.from(response);
    } catch (error) {
      throw Exception([error.toString()]);
    }
  }
}
