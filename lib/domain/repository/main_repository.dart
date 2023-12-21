// ignore_for_file: avoid_catches_without_on_clauses

import 'package:get/get.dart';
import 'package:librarychuv/data/api.dart';
import 'package:librarychuv/data/local_data.dart';
import 'package:librarychuv/data/mock/ads_mock.dart';
import 'package:librarychuv/data/mock/book_mock.dart';
import 'package:librarychuv/data/mock/librires_mock.dart';
import 'package:librarychuv/data/mock/news_mock.dart';
import 'package:librarychuv/data/mock/region_mock.dart';
import 'package:librarychuv/domain/models/abstract.dart';
import 'package:librarychuv/domain/models/ads.dart';
import 'package:librarychuv/domain/models/books.dart';
import 'package:librarychuv/domain/models/gerion.dart';
import 'package:librarychuv/domain/models/libriry.dart';
import 'package:librarychuv/domain/models/news.dart';
import 'package:librarychuv/main.dart';

/// репо для различных сущностей
class MainRepository extends GetxController {
  List<News> news = [];
  List<Book> recommendations = [];
  List<Libriry> libriries = [];
  List<Region> regionies = [];
  List<Ads> ads = [];

  static final MainRepository _instance = MainRepository._internal();

  MainRepository._internal();

  factory MainRepository() => _instance;

  /// Начальная загрузка данных из Api или локальных данных

  Future init() async {
    loadListApi(LocalDataKey.news); // загрузка новостей
    loadListApi(LocalDataKey.recomend); // загрузка рекомендованных
    loadListApi(LocalDataKey.libriry); // загрузка библиотек
    loadListApi(LocalDataKey.regionies); // загрузка регионов
    loadListApi(LocalDataKey.ads); // загрузка объявлений
  }

  Future<void> loadListApi(LocalDataKey key) async {
    Future<void> loadApi(
        List<Map<String, dynamic>> mock, List<ParentModels> list) async {
      List<Map<String, dynamic>> answer = [{}];
      if (isMock) {
        list = mock.map((org) => News.fromJson(org)).toList();
        await saveListToLocal(key);
      } else {
        answer = await Api().getListMainRepository(key);
        if (answer.first['error'] != null) {
          list = answer.map((item) => News.fromJson(item)).toList();
          await saveListToLocal(key);
        } else {
          await loadListFromLocal(key);
        }
      }
    }

    switch (key) {
      case LocalDataKey.user:
        break;
      case LocalDataKey.news:
        await loadApi(newsMock, news);
        break;
      case LocalDataKey.recomend:
        await loadApi(recommendationsMock, recommendations);
        break;
      case LocalDataKey.libriry:
        await loadApi(libririesMock, libriries);
        break;
      case LocalDataKey.regionies:
        await loadApi(regionsMock, regionies);
        break;
      case LocalDataKey.ads:
        await loadApi(adsMock, ads);
        break;
    }
  }

  Future<void> loadListFromLocal(LocalDataKey key) async {
    Future loadListJson(List<ParentModels> list) async {
      final List<Map<String, dynamic>> data =
          await LocalData.loadListJson(key: LocalDataKey.news);
      if (data.first['error'] != null) {
        list = data.map((item) => News.fromJson(item)).toList();
      } else {
        await saveListToLocal(key);
      }
    }

    switch (key) {
      case LocalDataKey.user:
        break;
      case LocalDataKey.news:
        await loadListJson(news);
        break;
      case LocalDataKey.recomend:
        await loadListJson(recommendations);
        break;
      case LocalDataKey.libriry:
        await loadListJson(libriries);
        break;
      case LocalDataKey.regionies:
        await loadListJson(regionies);
        break;
      case LocalDataKey.ads:
        await loadListJson(ads);
        break;
    }
  }

  Future<void> saveListToLocal(LocalDataKey key) async {
    Future saveListJson(List<ParentModels> list) async {
      await LocalData.saveListJson(
          json: list.map((item) => item.toJson()).toList(), key: key);
    }

    switch (key) {
      case LocalDataKey.user:
        break;
      case LocalDataKey.news:
        await saveListJson(news);
        break;
      case LocalDataKey.recomend:
        await saveListJson(recommendations);
        break;
      case LocalDataKey.libriry:
        await saveListJson(libriries);
        break;
      case LocalDataKey.regionies:
        await saveListJson(regionies);
        break;
      case LocalDataKey.ads:
        await saveListJson(ads);
        break;
    }
  }
}
