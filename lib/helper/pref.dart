import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Pref {
  static late Box _box;
  static Future<void> initialize() async {
    //FOR INITIALIZING HIVE TO USE APP DIRECTORY
    Hive.defaultDirectory = (await getApplicationCacheDirectory()).path;
    _box = Hive.box(name: 'myData');
  }

  static bool get showOnboarding =>
      _box.get('showOnboarding', defaultValue: true);

  static set showOnboarding(bool v) => _box.put('showOnboarding', v);

  static bool get isDarkMode => _box.get('isDarkMode') ?? false;
  static set isDarkMode(bool v) => _box.put('isDarkMode', v);

  static ThemeMode get defaultTheme {
    final data = _box.get('isDarkMode');
    log('data: $data');
    if (data == null) return ThemeMode.system;
    if (data == true) return ThemeMode.dark;
    return ThemeMode.light;
  }
}
