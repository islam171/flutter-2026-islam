import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel extends ChangeNotifier {
  SettingsModel(this._prefs, {required bool dark, required String city})
    : _dark = dark,
      _city = city;

  final SharedPreferencesAsync _prefs;
  bool _dark;
  String _city;

  bool get dark => _dark;
  String get city => _city;

  Future<void> setDark(bool v) async {
    _dark = v;
    notifyListeners();
    await _prefs.setBool('darkMode', v);
  }

  Future<void> setCity(String v) async {
    _city = v;
    notifyListeners();
    String? key = await _prefs.getString("cityFilter");
    if (key == v) {
      await _prefs.setString("cityFilter", "");
    }
    await _prefs.setString("cityFilter", v);
  }
}
