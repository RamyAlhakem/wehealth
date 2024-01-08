import 'package:flutter/widgets.dart';

class WeightHistoryController extends ChangeNotifier {
  List<double> history = [];
  save(double weight) {
    history.add(weight);
    notifyListeners();
  }

  List<double> get updatehistory {
    return history;
  }
}
