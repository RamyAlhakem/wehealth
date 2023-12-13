// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wehealth/controller/auth_controller/auth_repository.dart';
import 'package:wehealth/controller/home_tiles_controller/home_tiles_controller.dart';
import 'package:wehealth/controller/profile_controller/profile_controller.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/methods/methods.dart';
import 'package:wehealth/models/data_model/login_model.dart';
import 'package:wehealth/models/data_model/registration_model.dart';
import 'package:wehealth/screens/auth/signin.dart';
import 'package:wehealth/screens/dashboard/dashboard_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../http_cleint/api_clients.dart';
import '../../http_cleint/app_config.dart';

class AuthController extends GetxController {
  AuthController({required this.prefs})
      : _repository = AuthRepository(prefs: prefs);

  final AuthRepository _repository;

  /// [============== |> Initialization <| ==============] /
  final auth = FirebaseAuth.instance;
  final SharedPreferences prefs;
  bool _phoneVarified = false;
  LoggedUser? user;
  String? _varificationId;
  UserCredential? _phoneUser;
  UserCredential? get phoneUser => _phoneUser;
  bool get phoneStatus => _phoneVarified;

  bool get otp => _varificationId != null;

  //Phone Auth Section
  Future<void> requestOTP(String number) async {
    auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (phoneAuthCredential) async {
        UserCredential user =
            await auth.signInWithCredential(phoneAuthCredential);
        if (user.additionalUserInfo != null) {
          _phoneUser = user;
          _phoneVarified = true;
          update();
        }
        update();
      },
      verificationFailed: (error) {
        print("Error with phone: $error");
      },
      codeSent: (verificationId, forceResendingToken) {
        print("VARIFICATION CODE SENT!!! ID: $_varificationId");
        _varificationId = _varificationId;
        update();
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _varificationId = verificationId;
        print("Error with phone: (**TIME OUT**) ID: $verificationId");
      },
    );
  }

  Future<bool> validatePhoneOTP(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        smsCode: otp, verificationId: _varificationId!);
    UserCredential status = await auth.signInWithCredential(credential);
    if (status.additionalUserInfo != null) {
      _phoneVarified = true;
      _phoneUser = status;
      update();
      return true;
    }
    return false;
  }
  // Phone Auth Section
  changePassword(String oldPass, String newPass, String confirmPass) async {
    final res =
        await _repository.postUpdatePassword(oldPass, newPass, confirmPass);
    try {
      if (res != null && res == true) {
        showToast("Password Changed!", Get.context);
      }
      update();
    } catch (error) {
      log("Error While fetching ApptSummary ${error.toString()}");
    }
  }

  forgotPassword(String email) async {
    final res = await _repository.postForgetPassword(email);
    try {
      if (res != null && res == true) {
        showToast(
            "Please check your email to change your password.!", Get.context);
      }
      update();
    } catch (error) {
      log("Error While forgotPassword ${error.toString()}");
    }
  }

  // [============== |> SignIn with Email & Password <| ==============] /
  Future login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    Map<String, dynamic> params = {};
    params['email'] = email;
    params['password'] = password;
    params['functionName'] = "validateUser";
    params['macAddress'] = "02:00:00:00:00:00";
    params['deviceName'] = "Android SDK built for arm64";
    log(" =========== getting params ===>> \n$params\n =========== ");

    String url = AppConfig.baseUrl + AppConfig.login;
    var response = await ApiClients.postJson(params, url);
    LogInModel model = LogInModel.fromMap(response);

    log(model.authResponse);
    if (model.error == 0) {
      log("Login UserID : ${model.data![0].userId}");
      user = model.data?[0];
      update();
      String token = user?.token ?? "";
      log("TOKEN $token");
      await saveUserId(user!.userId!);
      await ApiClients.updateHeader(newToken: token);
      //
      await Get.find<ProfileController>().getUserProfile();
      Get.find<StorageController>().updateEmail(email);
      Get.find<StorageController>().updatepassword(password);
      await Get.put(HomeTileController()).getAndSetTilesData();
      showToast("Log In Successful!!", Get.context);
      Get.to(() => const DashboardScreen());
    } else {
      showToast(model.authResponse, Get.context);
    }
  }

  // ============== |> SignUp with Email & Password <| ============== /
  Future register({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    Map<String, dynamic> params = {};
    params['email'] = email;
    params['password'] = password;
    log(" =========== getting params ===>> \n$params\n =========== ");

    String url = AppConfig.baseUrl + AppConfig.registration;
    var response = await ApiClients.postJson(params, url);
    RegistrationModel model = RegistrationModel.fromMap(response);

    log(model.authResponse);
    if (model.error == 0) {
      log("TOKEN ${model.data?[0].token}");
      await Get.find<ProfileController>().getUserProfile();
      update();
      showToast("Registration Successful!!", context);
      Get.to(() => const SigninScreen());
    } else {
      showToast(model.authResponse, context);
    }
  }

  // ============== |> SignUp with Email & Password <| ============== /

  saveUserId(int userId) {
    prefs.setInt('user_id', userId);
    log("User ID saved! $userId");
  }

  int getUserId() {
    if (prefs.containsKey('user_id')) {
      return prefs.getInt('user_id')!;
    } else {
      log("No user ID available! Returned 0");
      return 0;
      // throw UnimplementedError("No user ID found!");
    }
  }

  Future updateDeviceId(String deviceId) async {
    Map<String, dynamic> params = {};
    params['deviceID'] = deviceId;
    params['token'] = prefs.getString('user_token') ?? "token_error";
    params['userID'] = prefs.getInt('user_id') ?? 0;
    log("#User Token => ${params['token']}");
    String url = AppConfig.baseUrl + AppConfig.updateDeviceToken;
    var response = await ApiClients.putJson(params, url);
    if (response['error'] == 0) {
      log("##updateDeviceID ==> ${response['authResponse']}");
    } else {
      log("Update DeviceID ==> ${response['authResponse']}");
    }
  }

  // ============== |> SignUp with Email & Password <| ============== /
/* // TODO: Facebook auth you'll need to create app on facebook dev colsole. And setup everything for it to work.
  AccessToken? _facebookTOken;
  FaceBookUser? _faceBookUser;
  FaceBookUser? get facebookUser => _faceBookUser;
  AccessToken? get facebookUserToken => _facebookTOken;

  Future<void> facebookSignin() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      _facebookTOken = result.accessToken!;
      getFacebookUser();
      update();
    } else {
      print(result.status);
      print(result.message);
    }
  }

  Future<void> getFacebookUser() async {
    if (_facebookTOken != null) {
      final userData = await FacebookAuth.instance.getUserData();
      _faceBookUser = FaceBookUser.fromMap(userData);
      if (_faceBookUser != null) {
        Get.to(() => const DemoScreen());
      }
      update();
    } else {
      print("NO EXISTING FACEBOOK USER!");
    }
  }

  Future<void> facebookSignOut() async {
    await FacebookAuth.instance.logOut();
    _faceBookUser = null;
    _facebookTOken = null;
    update();
  } */
//Facebook Auth Section

// Google Auth Section
// TODO: To use the google auth you'll need to create a firebase app. And add the signin credentials.
//Also need to setup google cloud platform.
  GoogleSignInAccount? _googleUser;
  final GoogleSignIn _googleSignInController = GoogleSignIn(
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com', //(Optional)
    scopes: ['email'],
  );

  GoogleSignInAccount? get currentGoogleUser => _googleUser;
  GoogleSignIn get googleAuthController => _googleSignInController;

  Future<void> signInWithGoogle() async {
    try {
      final account = await _googleSignInController.signIn();
      if (account != null) {
        _googleUser = account;
        update();
        // Get.to(() => const DemoScreen());
      }
    } catch (error) {
      print("Google sign in ERROR: $error");
    }
  }

  Future<void> googleSignOut() async {
    await _googleSignInController.disconnect();
    _googleUser = null;
    update();
  }

  Future<void> fetchGoogleUser() async {
    final account = await _googleSignInController.signInSilently();
    if (account != null) {
      _googleUser = account;
    }
    update();
  }
}
