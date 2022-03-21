import 'package:flutter/material.dart';

class AppStateNotifier extends ChangeNotifier {
  bool isDarkModeOn = false;

  void updateThemeOn(bool isDarkModeOn) {
    this.isDarkModeOn = isDarkModeOn;
    notifyListeners();
  }
}
