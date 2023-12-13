import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String apptTypeToString(int? appointmentType) {
  switch (appointmentType) {
    case 0:
      return "New/Follow Up";
    case 1:
      return "Tele-Consultation";
    default:
      return "Walk-In";
  }
}

Color getColorBasedOfAppt(int? appointmentType) {
  switch (appointmentType) {
    case 0:
      return const Color(0xFF99CC00);
    case 1:
      return const Color(0xFF004C00);
    default:
      return const Color(0xFF2070B1);
  }
}

String apptStatusToString(int? aptStatus) {
  switch (aptStatus) {
    case 0:
      return "Pending Acceptance";
    case 1:
      return "Pending Acceptance";
    case 2:
      return "Accepted";
    case 3:
      return "Rejected";
    case 4:
      return "Cancelled";
    case 5:
      return "No Show";
    case 6:
      return "Completed";
    case 7:
      return "Rescheduled";
    default:
      return "";
  }
}

/* String apptStatusToString(int? aptStatus) {
  switch (aptStatus) {
    case 0:
      return "NEW";
    case 1:
      return "PENDING";
    case 2:
      return "ACCEPTED";
    case 3:
      return "REJECTED";
    case 4:
      return "CANCELLED";
    case 5:
      return "NO SHOW";
    case 6:
      return "COMPLETED";
    case 7:
      return "EXPIRED";
    default:
      return "UNKNOWN";
  }
} */

DateFormat stringDateWithTZ = DateFormat("yyyy-MM-ddTHH:mm:ss.S");
