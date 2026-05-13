import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:countify/providers/setting_provider.dart';
import 'package:countify/utils/url_helper.dart';
import 'package:countify/widgets/sound_picker_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterItem {
  String name;
  int value;
  int maxLimit; // Optional max
  int minLimit; // Optional min
  String alertSound;
  String minusSound;
  String plusSound;
  bool isMinAlertEnabled;
  bool isMaxAlertEnabled;
  String counterStyle;
  final DateTime createdAt;

  CounterItem({
    required this.name,
    this.value = 0,
    this.maxLimit = 0,
    this.minLimit = 0,
    this.alertSound = "",
    this.minusSound = "",
    this.plusSound = "",
    this.isMinAlertEnabled = false,
    this.isMaxAlertEnabled = false,
    this.counterStyle = "",
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert Object to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
      'maxLimit': maxLimit,
      'minLimit': minLimit,
      'alertSound': alertSound,
      'minusSound': minusSound,
      'plusSound': plusSound,
      'isMinAlertEnabled': isMinAlertEnabled,
      'isMaxAlertEnabled': isMaxAlertEnabled,
      'counterStyle': counterStyle,
      'createdAt': createdAt
          .toIso8601String(), // to covert datetime object to string
    };
  }

  // Create Object from Map
  factory CounterItem.fromMap(Map<String, dynamic> map) {
    return CounterItem(
      name: map['name'] ?? '',
      value: map['value'] ?? 0,
      maxLimit: map['maxLimit'] ?? 0,
      minLimit: map['minLimit'] ?? 0,
      alertSound: map['alertSound'] ?? '',
      minusSound: map['minusSound'] ?? '',
      plusSound: map['plusSound'] ?? '',
      isMinAlertEnabled: map['isMinAlertEnabled'] ?? false,
      isMaxAlertEnabled: map['isMaxAlertEnabled'] ?? false,
      counterStyle: map['counterStyle'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['craetedAt'])
          : DateTime.now(),
    );
  }
}

enum SortType { name, value, date }

class CountProvider extends ChangeNotifier {
  // Start with an empty list of our new Class
  List<CounterItem> _items = [];
  int _sessionCount = 0;
  int _totalClicks = 0;
  bool _hasReviewed = false;
  SortType _currentSort = SortType.date;
  bool _isAscending = true;

  final AudioPlayer _player = AudioPlayer();
  final FlutterTts _tts = FlutterTts();
  // 1. Create a reference to the other provider
  late SettingsProvider _settings;
  // 2. Create an update method (this is what MultiProvider will call)
  void update(SettingsProvider newSettings) {
    _settings = newSettings;
    // No need for notifyListeners() here usually
  }

  List<CounterItem> get items => _items;

  // --- SAVE DATA ---
  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    // Convert List of Objects -> List of Maps -> JSON String
    String jsonString = jsonEncode(_items.map((item) => item.toMap()).toList());
    await prefs.setString('counter_list', jsonString);
  }

  // --- LOAD DATA (Run this when the app starts) ---
  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('counter_list');

    if (jsonString != null) {
      List<dynamic> decodedList = jsonDecode(jsonString);
      _items = decodedList.map((item) => CounterItem.fromMap(item)).toList();
    }

    _sessionCount = prefs.getInt("session_count") ?? 0;
    _sessionCount++;
    await prefs.setInt("session_count", _sessionCount);
    _totalClicks = prefs.getInt("total_clicks") ?? 0;
    _hasReviewed = prefs.getBool("has_reviewed") ?? false;
  }

  void addItem(
    String name, {
    required String defaultSound,
    required String defaultCounterStyle,
  }) async {
    _items.add(
      CounterItem(
        name: name,
        alertSound: defaultSound,
        plusSound: defaultSound,
        minusSound: defaultSound,
        counterStyle: defaultCounterStyle,
      ),
    );

    _saveToPrefs();
    notifyListeners();
  }

  Future<void> incrementCount(int index) async {
    _items[index].value++;

    if (_items[index].isMaxAlertEnabled &&
        _items[index].value == _items[index].maxLimit) {
      if (_settings.isSoundEnabled) {
        _player.stop();
        _player.play(AssetSource(soundEffects[items[index].alertSound]!));
      }
      if (_settings.isHepticsEnabled) {
        HapticFeedback.vibrate();
      }
    } else {
      if (_settings.isSoundEnabled) {
        _player.stop();
        _player.play(AssetSource(soundEffects[items[index].plusSound]!));
      }

      if (_settings.isHepticsEnabled) {
        HapticFeedback.selectionClick();
      }
    }
    if (_settings.readNumbers && !kIsWeb) {
      _tts.speak(_items[index].value.toString());
    }
    recordAction();
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> decrementCount(int index) async {
    _items[index].value--;

    if (_items[index].isMinAlertEnabled &&
        _items[index].value == _items[index].minLimit) {
      if (_settings.isSoundEnabled) {
        _player.stop();
        _player.play(AssetSource(soundEffects[items[index].alertSound]!));
      }
      if (_settings.isHepticsEnabled) {
        HapticFeedback.vibrate();
      }
    } else {
      if (_settings.isSoundEnabled) {
        _player.stop();
        _player.play(AssetSource(soundEffects[items[index].minusSound]!));
      }
      if (_settings.isHepticsEnabled) {
        HapticFeedback.selectionClick();
      }
    }
    if (_settings.readNumbers && !kIsWeb) {
      _tts.speak(_items[index].value.toString());
    }
    recordAction();
    _saveToPrefs();
    notifyListeners();
  }

  void changeItemName(String newName, int index) {
    _items[index].name = newName;
    _saveToPrefs();
    notifyListeners();
  }

  void deleteItem(int index) async {
    _items.removeAt(index);
    _saveToPrefs();
    notifyListeners();
  }

  void setInitialValue(int initialValue, int index) {
    _items[index].value = initialValue;
    _saveToPrefs();
    notifyListeners();
  }

  Color getItemColor(int index) {
    final item = _items[index];

    // Logic remains the same, but it's now centralized
    if (item.maxLimit != 0 && item.value >= item.maxLimit) {
      return Colors.red;
    }
    if (item.minLimit != 0 && item.value <= item.minLimit) {
      return Colors.green;
    }
    return Colors.white; // Default
  }

  void sortItems() async {}

  void setMinAlertState(int index, bool enabled, int minValue) {
    _items[index].isMinAlertEnabled = enabled;
    _items[index].minLimit = minValue;
    _saveToPrefs();
    notifyListeners();
  }

  void setMaxAlertState(int index, bool enabled, int maxValue) {
    _items[index].isMaxAlertEnabled = enabled;
    _items[index].maxLimit = maxValue;
    _saveToPrefs();
    notifyListeners();
  }

  void setAlertSound(String soundName, int index) {
    _items[index].alertSound = soundName;
    _saveToPrefs();
    notifyListeners();
  }

  void setPlusSound(String soundName, int index) {
    _items[index].plusSound = soundName;
    _saveToPrefs();
    notifyListeners();
  }

  void setMinusSound(String soundName, int index) {
    _items[index].minusSound = soundName;
    _saveToPrefs();
    notifyListeners();
  }

  void setCounterStyle(String styleName, int index) {
    _items[index].counterStyle = styleName;
    _saveToPrefs();
    notifyListeners();
  }

  void clearAll() {
    _items.clear();

    notifyListeners();
  }

  Future<void> resetAll() async {
    _items.clear();
    await _saveToPrefs();
    await _settings.resetAllSettingsToDefault();
    notifyListeners();
  }

  void recordAction() async {
    if (_hasReviewed) return;

    _totalClicks++;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("total_clicks", _totalClicks);

    if (_sessionCount >= 5 && _totalClicks == 20) {
      await UrlHelper.requestInAppReview();
      _hasReviewed = true;
      await prefs.setBool("has_reviewed", true);
    }
  }

  void _applySort() {
    switch (_currentSort) {
      case SortType.name:
        _items.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortType.value:
        _items.sort((a, b) => a.value.compareTo(b.value));
        break;
      case SortType.date:
        _items.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
    }
    if (!_isAscending) {
      _items = _items.reversed.toList();
    }
  }

  void toggleSort(SortType type) {
    if (_currentSort == type) {
      _isAscending = !_isAscending; // Reverse direction if same type clicked
    } else {
      _currentSort = type;
      _isAscending = true;
    }
    _applySort();
    notifyListeners();
  }
}
