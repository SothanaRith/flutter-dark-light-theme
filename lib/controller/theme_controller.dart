import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:themeform/theme/light_dark_theme.dart';

class ThemeController extends GetxController {
  ThemeData theme = MyThemes.lightTheme;
  var imageAsset = 'assets/light.jpeg';
  bool darkTheme = false;

  // set variable to SharedPreferences for short and make more beautiful
  final Future<SharedPreferences> pref = SharedPreferences.getInstance();
  // store key string to prevent write wrong words
  static const String themePreferenceKey = 'preference';

  // to change theme color
  void toggleTheme() {
    theme = darkTheme ? MyThemes.darkTheme : MyThemes.lightTheme;
    imageAsset = darkTheme ? 'assets/dark.jpeg' : 'assets/light.jpeg';
    _saveThemeToPreferences();
    update();
  }

  // load preference theme data to remember the last change theme is
  Future<void> loadThemeFromPreferences() async {
    final SharedPreferences prefs = await pref;
    int themeIndex = prefs.getInt(themePreferenceKey) ?? 0;
    darkTheme = themeIndex != 0;
    theme = darkTheme ? MyThemes.darkTheme : MyThemes.lightTheme;
    imageAsset = darkTheme ? 'assets/dark.jpeg' : 'assets/light.jpeg';
    update();
  }
  // to update theme data when user change theme
  Future<void> _saveThemeToPreferences() async {
    final SharedPreferences prefs = await pref;
    int themeIndex = darkTheme ? 1 : 0;
    await prefs.setInt(themePreferenceKey, themeIndex);
    update();
  }
}