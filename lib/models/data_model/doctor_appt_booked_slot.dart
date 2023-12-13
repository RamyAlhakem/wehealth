class DoctorApptBookedSlotWrapper {
  int? error;
  List<DoctorApptBookedSlot>? bookedSlots;
  String? authResponse;

  DoctorApptBookedSlotWrapper(
      {this.error, this.bookedSlots, this.authResponse});

  DoctorApptBookedSlotWrapper.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['Data'] != null) {
      bookedSlots = <DoctorApptBookedSlot>[];
      json['Data'].forEach((v) {
        bookedSlots!.add(DoctorApptBookedSlot.fromJson(v));
      });
    }
    authResponse = json['authResponse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['error'] = error;
    if (bookedSlots != null) {
      jsonData['Data'] = bookedSlots!.map((v) => v.toJson()).toList();
    }
    jsonData['authResponse'] = authResponse;
    return jsonData;
  }
}

class DoctorApptBookedSlot {
  int? professionalScheduleID;
  int? appointmentCount;
  String? appointmentTime;
  int? slotPerson;

  DoctorApptBookedSlot(
      {this.professionalScheduleID,
      this.appointmentCount,
      this.appointmentTime,
      this.slotPerson});

  DoctorApptBookedSlot.fromJson(Map<String, dynamic> json) {
    professionalScheduleID = json['ProfessionalScheduleID'];
    appointmentCount = json['appointmentCount'];
    appointmentTime = json['appointmentTime'];
    slotPerson = json['SlotPerson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['ProfessionalScheduleID'] = professionalScheduleID;
    jsonData['appointmentCount'] = appointmentCount;
    jsonData['appointmentTime'] = appointmentTime;
    jsonData['SlotPerson'] = slotPerson;
    return jsonData;
  }
}
