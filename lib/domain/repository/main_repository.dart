// ignore_for_file: avoid_catches_without_on_clauses

import 'package:get/get.dart';
import 'package:librarychuv/data/api.dart';
import 'package:librarychuv/data/local_data.dart';
import 'package:librarychuv/data/mock/book_mock.dart';
import 'package:librarychuv/data/mock/librires_mock.dart';
import 'package:librarychuv/data/mock/news_mock.dart';
import 'package:librarychuv/data/mock/region_mock.dart';
import 'package:librarychuv/domain/models/books.dart';
import 'package:librarychuv/domain/models/gerion.dart';
import 'package:librarychuv/domain/models/libriry.dart';
import 'package:librarychuv/domain/models/news.dart';
import 'package:librarychuv/main.dart';

/// репо для юзера
class MainRepository extends GetxController {
  List<News> news = [];
  List<Book> recommendations = [];
  List<Libriry> libriries = [];
  List<Region> regionies = [];

  static final MainRepository _instance = MainRepository._internal();

  MainRepository._internal();

  factory MainRepository() => _instance;

  /// Начальная загрузка данных из Api или локальных данных

  Future init() async {
    await loadNewsApi();
    await loadRecomendApi();
    await loadLibriryApi();
    await loadRegionApi();
  }

  Future<void> loadRegionApi() async {
    List<Map<String, dynamic>> answer = [{}];
    if (isMock) {
      await Future.delayed(const Duration(seconds: 1));
      regionies = regionsMock.map((item) => Region.fromJson(item)).toList();
      await saveNewsToLocal();
    } else {
      answer = await Api().loadRegions();
      if (answer.first['error'] != null) {
        regionies = answer.map((item) => Region.fromJson(item)).toList();
        await saveRegionToLocal();
      } else {
        await loadNewsFromLocal();
      }
    }
  }

  Future<void> loadRegionFromLocal() async {
    final List<Map<String, dynamic>> data =
        await LocalData.loadListJson(key: LocalDataKey.regionies);
    if (data.first['error'] != null) {
      regionies = data.map((item) => Region.fromJson(item)).toList();
    } else {
      await saveRegionToLocal();
    }
  }

  Future<void> saveRegionToLocal() async {
    await LocalData.saveListJson(
        json: regionies.map((item) => item.toJson()).toList(),
        key: LocalDataKey.regionies);
  }

  Future<void> loadLibriryApi() async {
    List<Map<String, dynamic>> answer = [{}];
    if (isMock) {
      await Future.delayed(const Duration(seconds: 1));
      libriries = libririesMock.map((org) => Libriry.fromJson(org)).toList();
      await saveNewsToLocal();
    } else {
      answer = await Api().loadLibriries();
      if (answer.first['error'] != null) {
        libriries = answer.map((item) => Libriry.fromJson(item)).toList();
        await saveLibriryToLocal();
      } else {
        await loadLibriryFromLocal();
      }
    }
  }

  Future<void> loadLibriryFromLocal() async {
    final List<Map<String, dynamic>> data =
        await LocalData.loadListJson(key: LocalDataKey.libriry);
    if (data.first['error'] != null) {
      libriries = data.map((item) => Libriry.fromJson(item)).toList();
    } else {
      await saveLibriryToLocal();
    }
  }

  Future<void> saveLibriryToLocal() async {
    await LocalData.saveListJson(
        json: libriries.map((item) => item.toJson()).toList(),
        key: LocalDataKey.libriry);
  }

  Future<void> loadRecomendApi() async {
    List<Map<String, dynamic>> answer = [{}];
    if (isMock) {
      await Future.delayed(const Duration(seconds: 1));
      recommendations =
          recommendationsMock.map((org) => Book.fromJson(org)).toList();
      await saveNewsToLocal();
    } else {
      answer = await Api().loadRecomend();
      if (answer.first['error'] != null) {
        recommendations =
            answer.map((itemRecomend) => Book.fromJson(itemRecomend)).toList();
        await saveRecomendsToLocal();
      } else {
        await loadRecomendFromLocal();
      }
    }
  }

  Future<void> loadRecomendFromLocal() async {
    final List<Map<String, dynamic>> data =
        await LocalData.loadListJson(key: LocalDataKey.recomend);
    if (data.first['error'] != null) {
      recommendations =
          data.map((itemRecomend) => Book.fromJson(itemRecomend)).toList();
    } else {
      await saveRecomendsToLocal();
    }
  }

  Future<void> saveRecomendsToLocal() async {
    await LocalData.saveListJson(
        json: recommendations.map((itemRecom) => itemRecom.toJson()).toList(),
        key: LocalDataKey.recomend);
  }

  Future<void> loadNewsApi() async {
    List<Map<String, dynamic>> answer = [{}];
    if (isMock) {
      await Future.delayed(const Duration(seconds: 1));
      news = newsMock.map((org) => News.fromJson(org)).toList();
      await saveNewsToLocal();
    } else {
      answer = await Api().getNews();
      if (answer.first['error'] != null) {
        news = answer.map((itemNews) => News.fromJson(itemNews)).toList();
        await saveNewsToLocal();
      } else {
        await loadNewsFromLocal();
      }
    }
  }

  Future<void> loadNewsFromLocal() async {
    final List<Map<String, dynamic>> data =
        await LocalData.loadListJson(key: LocalDataKey.news);
    if (data.first['error'] != null) {
      news = data.map((itemNews) => News.fromJson(itemNews)).toList();
    } else {
      await saveNewsToLocal();
    }
  }

  Future<void> saveNewsToLocal() async {
    await LocalData.saveListJson(
        json: news.map((itemNews) => itemNews.toJson()).toList(),
        key: LocalDataKey.news);
  }
}
