import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef PrefMap = MapEntry<String, Object?>;

class Service extends ChangeNotifier {
  Service() {
    Future(() async {
      pref = await SharedPreferences.getInstance();
      _keyValues = getKeyValues();
      notifyListeners();
    });
  }
  late SharedPreferences pref;

  List<PrefMap> _keyValues = [];
  List<PrefMap> get keyValues => _keyValues;
  List<PrefMap> getKeyValues() => pref
      .getKeys()
      .map(
        (key) => MapEntry(key, pref.get(key)),
      )
      .toList()
    ..sort((a, b) => a.key.compareTo(b.key));

  void delete({required String key}) {
    pref.remove(key);
    _keyValues = getKeyValues();
    notifyListeners();
  }

  void deleteAll() {
    pref.getKeys().forEach((key) {
      pref.remove(key);
    });
    _keyValues = getKeyValues();
    notifyListeners();
  }
}
