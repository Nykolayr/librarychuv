import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_logger/surf_logger.dart';

///сохранение и загрузка в shared_preferences
class LocalData {
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> saveJsonUser(Map<String, dynamic> json,
      [String key = 'user']) async {
    Logger.d('json');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(json));
  }

  Future<String> loadJsonUser([String key = 'user']) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }
}
