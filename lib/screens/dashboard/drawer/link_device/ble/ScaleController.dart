import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wehealth/screens/dashboard/drawer/link_device/ble/WeightData.dart';

class ScaleController extends ChangeNotifier {
  List<WeightData> data = [];
  saveweight(WeightData myweight) {
    data.add(myweight);
    notifyListeners();
  }

  List<WeightData> get updateweight {
    return data;
  }

  clear() {
    updateweight.clear();
    notifyListeners();
  }

}
