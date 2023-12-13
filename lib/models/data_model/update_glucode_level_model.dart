class UpdateGlucoseLevel {
  String? glucoseLevel;
  String? id;
  String? mealType;
  String? notes;
  String? recordDatetime;

  UpdateGlucoseLevel(
      {this.glucoseLevel,
      this.id,
      this.mealType,
      this.notes,
      this.recordDatetime});

  UpdateGlucoseLevel.fromJson(Map<String, dynamic> json) {
    glucoseLevel = json['glucose_level'];
    id = json['id'];
    mealType = json['meal_type'];
    notes = json['notes'];
    recordDatetime = json['record_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['glucose_level'] = glucoseLevel;
    data['id'] = id;
    data['meal_type'] = mealType;
    data['notes'] = notes;
    data['record_datetime'] = recordDatetime;
    return data;
  }
}
