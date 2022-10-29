import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static dontShowSlide() {
    _prefs.setBool('show_slide', false);
  }

  static bool get showSlide => _prefs.getBool('show_slide') ?? true;
}
