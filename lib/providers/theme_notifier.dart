import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;
  Brightness _brightness;

  ThemeNotifier(this._themeData, this._brightness);

  getTheme() => _themeData;

  getBrightness() => _brightness;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    _brightness = _themeData.accentColorBrightness;
    notifyListeners();
  }
}
