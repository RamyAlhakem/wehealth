class AppConfig {

  static String iOSAppVersion = "5.0.3"; 
  static String androidAppVersion = "50.7.3"; 
  static String huaweiAppVersion = "50.7.3"; 

  static const String profileImagebaseUrl = "https://www.umchtech.com/chief/portal/uploads/";
  static const String imageBaseUrl = "https://www.umchtech.com/chief/portal/";
  static const String baseUrl = "https://apiwehealth.cloudns.asia";
  static const String seconderyBaseUrl = "https://www.umchtech.com";
  static const String waterIntakeBaseUrl = "https://api.umchtech.com";

  static const String login = "/login";
  static const String registration = "/registration";
  static const String updateUser = "/UpdateUserInfo";
  static const String updateDeviceToken = "/updateDeviceToken";
  static const String notificationInbox = "/updateDeviceToken";
  static const String insertNotification = "/insertNotification";
  static const String sendFirebaseMsg = "/sendfirebasemsg";

  //
  static const String addBp = "/addbp";

  /* ===========|> End Points <|=========== */
  static const String bodyWeightDataUri = "/GetWeight";
  static const String updateMedAdhereStatus = "/MyMedicineStatus";

  /// this is [water intake end point]
  static const String addWaterIntake = "/AddactivityWater";
  static const String getWaterIntake = "/GetactivityWater";
  
}
