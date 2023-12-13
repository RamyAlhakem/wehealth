class FoodSuggestionResponse {
  int? error;
  String? authResponse;
  List<FoodSuggestionData>? data;

  FoodSuggestionResponse({this.error, this.authResponse, this.data});

  FoodSuggestionResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    authResponse = json['authResponse'];
    if (json['Data'] != null) {
      data = <FoodSuggestionData>[];
      json['Data'].forEach((v) {
        data!.add(FoodSuggestionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['error'] = error;
    map['authResponse'] = authResponse;
    if (data != null) {
      map['Data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class FoodSuggestionData {
  String? foodid;
  String? englishname;
  String? country;

  FoodSuggestionData({this.foodid, this.englishname, this.country});

  FoodSuggestionData.fromJson(Map<String, dynamic> json) {
    foodid = json['foodid'];
    englishname = json['englishname'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['foodid'] = foodid;
    map['englishname'] = englishname;
    map['country'] = country;
    return map;
  }
}
