import 'package:flutter/material.dart';
import 'package:wehealth/screens/dashboard/dashboard_screen.dart';
import '../../screens/auth/signin.dart';
import '../../localization/choose_language_screen.dart';
import '../../screens/auth/signup.dart';
import '../../settings/main_settings.dart';

var routes = <String, WidgetBuilder>{
  //

  SigninScreen.id: (_) => const SigninScreen(),
  SignUpScreen.id: (_) => const SignUpScreen(),
  AppMainSettings.id: (_) => const AppMainSettings(),
  DashboardScreen.id: (_) => const DashboardScreen(),
  ChooseLanguageScreen.id: (_) => const ChooseLanguageScreen(),
};
