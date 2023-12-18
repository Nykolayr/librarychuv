// ignore_for_file: avoid_catches_without_on_clauses

import 'package:get/get.dart';
import 'package:librarychuv/data/api.dart';
import 'package:librarychuv/data/local_data.dart';
import 'package:librarychuv/data/mock/book_mock.dart';
import 'package:librarychuv/data/mock/news_mock.dart';
import 'package:librarychuv/domain/models/books.dart';
import 'package:librarychuv/domain/models/news.dart';
import 'package:librarychuv/main.dart';

/// репо для юзера
class MainRepository extends GetxController {
  List<News> news = [];
  List<Book> recommendations = [];

  static final MainRepository _instance = MainRepository._internal();

  MainRepository._internal();

  factory MainRepository() => _instance;

  /// Начальная загрузка данных из Api или локальных данных
  Future init() async {
    await loadNewsApi();
    await loadRecomendApi();
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
        await saveNewsToLocal();
      } else {
        await loadNewsFromLocal();
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
