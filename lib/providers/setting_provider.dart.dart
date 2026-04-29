import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  String userName = "apple";

  void changeName(String newName) {
    userName = newName;
    notifyListeners();
  }
}
