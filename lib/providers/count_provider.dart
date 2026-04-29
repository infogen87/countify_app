import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterItem {
  String name;
  int value;
  int? maxLimit; // Optional max
  int? minLimit; // Optional min

  CounterItem({
    required this.name,
    this.value = 0,
    this.maxLimit,
    this.minLimit,
  });

  // Convert Object to Map
  Map<String, dynamic> toMap() {
    return {'name': name, 'value': value};
  }

  // Create Object from Map
  factory CounterItem.fromMap(Map<String, dynamic> map) {
    return CounterItem(name: map['name'], value: map['value']);
  }
}

class CountProvider extends ChangeNotifier {
  // Start with an empty list of our new Class
  List<CounterItem> _items = [];

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
      notifyListeners();
    }
  }

  void addItem(String name) async {
    _items.add(CounterItem(name: name));
    _saveToPrefs();
    notifyListeners();
  }

  void incrementCount(int index) {
    _items[index].value++;
    if (_items[index].maxLimit != null &&
        _items[index].value == _items[index].maxLimit) {
      HapticFeedback.vibrate(); // Vibrate the phone
    }
    _saveToPrefs();
    notifyListeners();
  }

  void decrementCount(int index) {
    _items[index].value--;
    if (_items[index].minLimit != null &&
        _items[index].value == _items[index].minLimit) {
      HapticFeedback.vibrate(); // Vibrate the phone
    }
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
    if (item.maxLimit != null && item.value >= item.maxLimit!) {
      return Colors.red;
    }
    if (item.minLimit != null && item.value <= item.minLimit!) {
      return Colors.green;
    }
    return Colors.white; // Default
  }

  void sortItems() async {}

  void setMinValue(int minValue, int index){
    _items[index].minLimit = minValue;
    _saveToPrefs();
    notifyListeners();
  }

  void setMaxValue(int maxValue, int index){
    _items[index].maxLimit = maxValue;
    _saveToPrefs();
    notifyListeners();
  }
}
