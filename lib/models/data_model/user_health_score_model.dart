class UserHealthScoreWrapper {
  int? error;
  String? authResponse;
  HealthScoreData? healthScoreData;

  UserHealthScoreWrapper({this.error, this.authResponse, this.healthScoreData});

  UserHealthScoreWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    healthScoreData =
        json['Data'] != null ? HealthScoreData.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonString = {};
    jsonString['error'] = error;
    jsonString['authResponse'] = authResponse;
    if (healthScoreData != null) {
      jsonString['Data'] = healthScoreData!.toJson();
    }
    return jsonString;
  }
}

class HealthScoreData {
  int? dietScore;
  int? glucoseScore;
  int? bpScore;
  int? bmiScore;
  int? smokingscore;
  int? paScore;
  int? cholesterolScore;
  int? obtainedScore;
  int? totalScore;

  HealthScoreData(
      {this.dietScore,
      this.glucoseScore,
      this.bpScore,
      this.bmiScore,
      this.smokingscore,
      this.paScore,
      this.cholesterolScore,
      this.obtainedScore,
      this.totalScore});

  HealthScoreData.fromJson(Map<String, dynamic> json) {
    dietScore = json['dietScore'];
    glucoseScore = json['glucoseScore'];
    bpScore = json['bpScore'];
    bmiScore = json['bmiScore'];
    smokingscore = json['smokingscore'];
    paScore = json['paScore'];
    cholesterolScore = json['cholesterolScore'];
    obtainedScore = json['obtainedScore'];
    totalScore = json['totalScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonString = {};
    jsonString['dietScore'] = dietScore;
    jsonString['glucoseScore'] = glucoseScore;
    jsonString['bpScore'] = bpScore;
    jsonString['bmiScore'] = bmiScore;
    jsonString['smokingscore'] = smokingscore;
    jsonString['paScore'] = paScore;
    jsonString['cholesterolScore'] = cholesterolScore;
    jsonString['obtainedScore'] = obtainedScore;
    jsonString['totalScore'] = totalScore;
    return jsonString;
  }
}
