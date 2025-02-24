import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easylogger/flutter_logger.dart';

///сохранение и загрузка в shared_preferences
class LocalData {
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> saveJson(
      {required Map<String, dynamic> json, required LocalDataKey key}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key.name, jsonEncode(json));
  }

  static Future<Map<String, dynamic>> loadJson(
      {required LocalDataKey key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(key.name);
    if (data != null) {
      return jsonDecode(data) as Map<String, dynamic>;
    } else {
      Logger.e('нет данных для ${key.name}');
      return {'error': 'нет данных для ${key.name}'};
    }
  }

  static Future<void> saveListJson(
      {required List<Map<String, dynamic>> json,
      required LocalDataKey key}) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> list = json.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList(key.name, list);
  }

  static Future<void> saveListString(
      {required List<String> list, required LocalDataKey key}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key.name, list);
  }

  static Future<List<String>> loadListString(
      {required LocalDataKey key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? list = prefs.getStringList(key.name);
    if (list != null) {
      return list;
    } else {
      Logger.e('нет данных для ${key.name}');
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> loadListJson(
      {required LocalDataKey key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? list = prefs.getStringList(key.name);
    if (list != null) {
      return list.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
    } else {
      Logger.e('нет данных для ${key.name}');
      return [
        {'error': 'нет данных для ${key.name}'}
      ];
    }
  }
}

enum LocalDataKey {
  user,
  news,
  recomend,
  libriry,
  ads,
  hystoryZapAds,
  hystoryZapNews,
  hystoryZapEvents,
  subjectNews,
  events,
  myEvents,
  books,
  hystoryZapBooks,
  issueAddress,
  bookOrders,
  helps,
  searchNews,
  searchEvents,
  questions;

  String get url => switch (this) {
        LocalDataKey.user => 'user',
        LocalDataKey.news => '/news.php?PAGEN_',
        LocalDataKey.events => '/events.php?PAGEN_',
        LocalDataKey.searchNews => '/news.php?PAGEN_',
        LocalDataKey.searchEvents => '/events.php?PAGEN_',
        LocalDataKey.recomend => 'recomend',
        LocalDataKey.libriry => '/map_biblio.php?PAGEN=',
        LocalDataKey.ads => 'ads',
        LocalDataKey.hystoryZapAds => 'hystoryZapAds',
        LocalDataKey.hystoryZapNews => 'hystoryZapNews',
        LocalDataKey.hystoryZapEvents => 'hystoryZapEvents',
        LocalDataKey.subjectNews => 'subjectNews',
        LocalDataKey.myEvents => 'myEvents',
        LocalDataKey.books => 'books',
        LocalDataKey.hystoryZapBooks => 'hystoryZapBooks',
        LocalDataKey.issueAddress => 'issueAddress',
        LocalDataKey.bookOrders => 'bookOrders',
        LocalDataKey.helps => 'helps',
        LocalDataKey.questions => 'questions'
      };
}
