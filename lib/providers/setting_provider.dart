import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';



class SettingsProvider extends ChangeNotifier {
  SharedPreferences? _prefs;

  // String userName = "apple";
  bool _isHepticsEnabled = true;
  bool _isSoundEnabled = true;
  String _defaultSounds = "Default";
  bool _readNumbers = false;
  String _defaultCounterStyle = "bigPlusButtonStyle";
  bool _keepScreenActive = true;
  bool _isDarkThemeEnabled = false;

  //Getters
  bool get isHepticsEnabled => _isHepticsEnabled;
  bool get isSoundEnabled => _isSoundEnabled;
  String get defaultSounds => _defaultSounds;
  bool get readNumbers => _readNumbers;
  String get defaultCounterStyle => _defaultCounterStyle;
  bool get keepScreenActive => _keepScreenActive;
  bool get isDarkThemeEnabled => _isDarkThemeEnabled;

  Future<void> loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    _isHepticsEnabled = _prefs!.getBool("isHepticsEnabled") ?? true; //done
    _isSoundEnabled = _prefs!.getBool("isSoundEnabled") ?? true; //done
    _defaultSounds = _prefs!.getString("defaultSounds") ?? "Default"; //done
    _readNumbers = _prefs!.getBool("readNumbers") ?? false; //done
    _defaultCounterStyle =
        _prefs!.getString("defaultCounterStyle") ?? "bigPlusButtonStyle"; //
    _keepScreenActive = _prefs!.getBool("keepScreenActive") ?? true; //done
    _isDarkThemeEnabled = _prefs!.getBool("isDarkThemeEnabled") ?? false; //done
    WakelockPlus.toggle(enable: _keepScreenActive);
    notifyListeners();
  }

  Future<void> toggleHeptics(bool value) async {
    _isHepticsEnabled = value;
    notifyListeners();
    await _prefs?.setBool("isHepticsEnabled", _isHepticsEnabled);
  }

  Future<void> toggleSounds(bool value) async {
    _isSoundEnabled = value;
    notifyListeners();
    await _prefs?.setBool("isSoundEnabled", _isSoundEnabled);
  }

  Future<void> toggleReadNumbers(bool value) async {
    _readNumbers = value;
    notifyListeners();
    await _prefs?.setBool("readNumbers", _readNumbers);
  }

  Future<void> toggleAlwaysOn(bool value) async {
    _keepScreenActive = value;
    await WakelockPlus.toggle(enable: _keepScreenActive);
    notifyListeners();
    await _prefs?.setBool("keepScreenActive", _keepScreenActive);
  }

  Future<void> switchTheme(bool value) async {
    _isDarkThemeEnabled = value;
    notifyListeners();
    await _prefs?.setBool("isDarkThemeEnabled", _isDarkThemeEnabled);
  }

  Future<void> setDefaultSound(String value) async {
    _defaultSounds = value;
    notifyListeners();
    await _prefs?.setString("defaultSounds", _defaultSounds);
  }

  Future<void> setDefaultCounterStyle(String value) async {
    _defaultCounterStyle = value;
    notifyListeners();
    await _prefs?.setString("defaultCounterStyle", _defaultCounterStyle);
  }

  Future<void> resetAllSettingsToDefault() async {
    await _prefs?.clear();
    await loadSettings();
    WakelockPlus.toggle(enable: _keepScreenActive);
    notifyListeners();
  }
}
