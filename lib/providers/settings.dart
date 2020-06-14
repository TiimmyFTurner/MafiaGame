//import 'dart:ui';

import 'package:flutter/Material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends ChangeNotifier {
  static final Map<String, ThemeData> _themes = {
    'light': ThemeData(
      fontFamily: 'Koodak',
      brightness: Brightness.light,
      backgroundColor: Color(0xffdaebee),
      primaryColor: Color(0xFFff5126),
      accentColor: Color(0xFFfcedda),
      textTheme: TextTheme(button: TextStyle(color: Colors.black)),
      iconTheme: IconThemeData(color: Colors.black),
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: Color(0xffdaebee),
        textTheme: TextTheme(
            headline6: TextStyle(
                color: Colors.black, fontSize: 18, fontFamily: 'Koodak')),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      cardColor: Color(0xffb6d7de),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    ),
    'dark': ThemeData(
      fontFamily: 'Koodak',
      brightness: Brightness.dark,
      backgroundColor: Color(0xff000245),
      primaryColor: Color(0xFFff6464),
      accentColor: Color(0xFF8b4367),
      textTheme: TextTheme(button: TextStyle(color: Colors.white)),
      iconTheme: IconThemeData(color: Colors.white),
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: Color(0xff000245),
        textTheme: TextTheme(
            headline6: TextStyle(
                color: Colors.white, fontSize: 18, fontFamily: 'Koodak')),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cardColor: Color(0xff543864),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    ),
  };
  ThemeData _themeData = _themes['light'];

  SharedPreferences _prefs;

  Future readSetting() async {
    _prefs = await SharedPreferences.getInstance();
    _themeData = (_prefs.getBool('darkMode') ?? false)
        ? _themes['dark']
        : _themes['light'];
    notifyListeners();
  }

  ThemeData get themeData => _themeData;

  ThemeData get darkTheme => _themes['dark'];

  bool get darkMode => _themeData == _themes['dark'] ? true : false;

  set switchDarkMode(bool status) {
    _themeData = status ? _themes['dark'] : _themes['light'];
    _prefs.setBool('darkMode', status);
    notifyListeners();
  }
}
