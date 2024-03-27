// ignore_for_file: avoid_catches_without_on_clauses
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:get/get.dart';
import 'package:librarychuv/data/api/api.dart';
import 'package:librarychuv/data/api/response_api.dart';
import 'package:librarychuv/data/local_data.dart';
import 'package:librarychuv/data/mock/issue_address.dart';
import 'package:librarychuv/data/mock/ads_mock.dart';
import 'package:librarychuv/data/mock/book_mock.dart';
import 'package:librarychuv/data/mock/help_mosk.dart';
import 'package:librarychuv/data/mock/librires_mock.dart';
import 'package:librarychuv/data/mock/my_answers.dart';
import 'package:librarychuv/data/mock/subject_mock.dart';
import 'package:librarychuv/domain/models/abstract.dart';
import 'package:librarychuv/domain/models/ads.dart';
import 'package:librarychuv/domain/models/book_order.dart';
import 'package:librarychuv/domain/models/books.dart';
import 'package:librarychuv/domain/models/events.dart';
import 'package:librarychuv/domain/models/help.dart';
import 'package:librarychuv/domain/models/issue_address.dart';
import 'package:librarychuv/domain/models/my_events.dart';
import 'package:librarychuv/domain/models/qustion.dart';
import 'package:librarychuv/domain/models/region.dart';
import 'package:librarychuv/domain/models/libriry.dart';
import 'package:librarychuv/domain/models/news.dart';
import 'package:librarychuv/main.dart';

/// репо для различных сущностей
class MainRepository extends GetxController {
  NewsForPage news = NewsForPage.init();
  EventsLibPage events = EventsLibPage.init();
  List<Book> recommendations = [];
  List<Book> books = [];
  List<Libriry> libriries = [];
  List<Region> regions = [];
  List<Ads> ads = [];
  List<SubjectNews> subjectNews = [];

  List<MyEvents> myEvents = [];
  List<IssueAddress> issueAddress = [];
  List<BookOrder> bookOrders = [];
  List<Question> questions = [];
  List<Help> helps = [];

  List<String> hystoryZapAds = [''];
  List<String> hystoryZapNews = [''];
  List<String> hystoryZapEvents = [''];
  List<String> hystoryZapBooks = [''];

  static final MainRepository _instance = MainRepository._internal();

  MainRepository._internal();

  factory MainRepository() => _instance;

  /// Начальная загрузка данных из Api или локальных данных

  Future init() async {
    await loadListApi(LocalDataKey.news); // загрузка новостей
    await loadListApi(LocalDataKey.recomend); // загрузка рекомендованных
    await loadListApi(LocalDataKey.books); // загрузка книг
    await loadListApi(LocalDataKey.libriry); // загрузка библиотек
    for (int k = 0; k < libriries.length; k++) {
      bool regionExists =
          regions.any((region) => region.id == libriries[k].region);
      if (!regionExists) {
        regions.add(Region(id: k.toString(), name: libriries[k].region));
      }
    }
    await loadListApi(LocalDataKey.ads); // загрузка объявлений
    await loadListApi(LocalDataKey.subjectNews); // загрузка тематик новостей
    await loadListApi(
        LocalDataKey.issueAddress); // загрузка адресов получение заказов
    await loadListApi(LocalDataKey.bookOrders); // загрузка заказов
    await loadListFromLocal(
        LocalDataKey.hystoryZapAds); // загрузка истории запросов объявлений
    await loadListFromLocal(
        LocalDataKey.hystoryZapNews); // загрузка истории запросов новостей
    await loadListApi(LocalDataKey.events); // загрузка событий
    await loadListFromLocal(
        LocalDataKey.hystoryZapEvents); // загрузка истории запросов событий
    await loadListFromLocal(
        LocalDataKey.hystoryZapBooks); // загрузка истории запросов событий
    await loadListFromLocal(LocalDataKey.hystoryZapBooks); // загрузка  событий
    await loadListApi(LocalDataKey.helps); // загрузка справочника
    await loadListApi(LocalDataKey.questions); // загрузка моих вопросов
    addBookOrderMock();
  }

  /// добавление моковых заказов
  addBookOrderMock() {
    bookOrders.add(BookOrder(
      adress: issueAddress[0],
      book: books[0],
      id: '0',
      name: '',
      comment: '',
      type: TypeOrder.readyIssued,
      date: DateTime.now(),
    ));

    bookOrders.add(BookOrder(
      adress: issueAddress[1],
      book: books[1],
      id: '1',
      name: '',
      comment: '',
      type: TypeOrder.refused,
      date: DateTime.now(),
    ));
    bookOrders.add(
      BookOrder(
        adress: issueAddress[2],
        book: books[2],
        id: '2',
        name: '',
        comment: '',
        type: TypeOrder.inDelivery,
        date: DateTime.now(),
      ),
    );
    saveListToLocal(LocalDataKey.bookOrders);
  }

  /// добавление вопроса пользователя
  Future<void> addQuestion(Question item) async {
    // имитация api
    await Future.delayed(const Duration(seconds: 1));
    item.id = (questions.length + 1).toString();
    questions.add(item);
    await saveListToLocal(LocalDataKey.questions);
  }

  /// добавление заказа
  Future<void> addBookOrder(BookOrder item) async {
    // имитация api
    await Future.delayed(const Duration(seconds: 1));
    item.id = (bookOrders.length + 1).toString();
    bookOrders.add(item);
    await saveListToLocal(LocalDataKey.bookOrders);
  }

  /// добавление события в календарь
  Future<void> addMyEvents(EventsLib item) async {
    // имитация api
    await Future.delayed(const Duration(seconds: 1));
    myEvents.add(MyEvents(
        id: (myEvents.length + 1).toString(), name: item.name, event: item));
    await saveListToLocal(LocalDataKey.myEvents);
  }

  /// удаления события из календарь
  Future<void> deleteMyEvents(EventsLib item) async {
    // имитация api
    await Future.delayed(const Duration(seconds: 1));
    myEvents.removeWhere((element) => element.id == item.id);
    await saveListToLocal(LocalDataKey.myEvents);
  }

  Future<String> loadListApi(LocalDataKey key, {int page = 1}) async {
    Future<String> loadDataApi(
      Function(Map<String, dynamic> data) getList,
    ) async {
      final answer = await Api().getListApi(key, page);
      if (answer is ResSuccess) {
        getList(answer.data);
        await saveListToLocal(key);
        return '';
      } else if (answer is ResError) {
        String error = 'answer error == ${answer.errorMessage}';
        Logger.e(error);
        await loadListFromLocal(key);
        return error;
      }
      return '';
    }

    Future<String> loadApi(
      List<Map<String, dynamic>> mock,
      Function(List<Map<String, dynamic>> data) getList,
    ) async {
      if (isMock &&
          key != LocalDataKey.news &&
          key != LocalDataKey.libriry &&
          key != LocalDataKey.events) {
        getList(mock);
        await saveListToLocal(key);
      } else {
        final answer = await Api().getListApi(key, page);
        if (answer is ResSuccess) {
          List<Map<String, dynamic>> mappedList = [];
          if (key == LocalDataKey.libriry) {
            answer.data.forEach((id, data) {
              Map<String, dynamic> item = Map.from(data);
              item['id'] = id;
              if (data['COORDINATES'] != null && data['COORDINATES'] != '') {
                mappedList.add(item);
              }
            });
          } else {
            mappedList = List<Map<String, dynamic>>.from(answer.data);
          }
          getList(mappedList);
          await saveListToLocal(key);
          return '';
        } else if (answer is ResError) {
          String error = 'answer error == ${answer.errorMessage}';
          Logger.e(error);
          await loadListFromLocal(key);
          return error;
        }
      }
      return '';
    }

    switch (key) {
      case LocalDataKey.user:
        break;
      case LocalDataKey.news:
        return await loadDataApi((data) {
          news = NewsForPage.fromJsonApi(data, news);
        });
      case LocalDataKey.events:
        return await loadDataApi((data) {
          events = EventsLibPage.fromJsonApi(data, events);
        });

      case LocalDataKey.books:
        return await loadApi(recommendationsMock, (data) {
          books = data.map((item) => Book.fromJson(item)).toList();
        });
      case LocalDataKey.recomend:
        return await loadApi(recommendationsMock, (data) {
          recommendations = data.map((item) => Book.fromJson(item)).toList();
        });

      case LocalDataKey.libriry:
        return await loadApi(libririesMock, (data) {
          libriries = data.map((item) => Libriry.fromJson(item)).toList();
        });

      case LocalDataKey.ads:
        return await loadApi(adsMock, (data) {
          ads = data.map((item) => Ads.fromJson(item)).toList();
        });

      case LocalDataKey.hystoryZapAds:
        return await loadApi(adsMock, (data) {
          ads = data.map((item) => Ads.fromJson(item)).toList();
        });

      case LocalDataKey.hystoryZapNews:
        return await loadDataApi((data) {
          news = NewsForPage.fromJsonApi(data, news);
        });

      case LocalDataKey.subjectNews:
        return await loadApi(subjectNewsMock, (data) {
          subjectNews = data.map((item) => SubjectNews.fromJson(item)).toList();
        });

      case LocalDataKey.issueAddress:
        return await loadApi(issueAddressMock, (data) {
          issueAddress =
              data.map((item) => IssueAddress.fromJson(item)).toList();
        });
      case LocalDataKey.hystoryZapBooks:
      case LocalDataKey.hystoryZapEvents:
        break;
      case LocalDataKey.myEvents:
        return await loadApi([], (data) {
          myEvents = data.map((item) => MyEvents.fromJson(item)).toList();
        });

      case LocalDataKey.bookOrders:
        return await loadApi([], (data) {
          bookOrders = data.map((item) => BookOrder.fromJson(item)).toList();
        });

      case LocalDataKey.helps:
        return await loadApi(helpMock, (data) {
          helps = data.map((item) => Help.fromJson(item)).toList();
        });

      case LocalDataKey.questions:
        return await loadApi(questionsMock, (data) {
          questions = data.map((item) => Question.fromJson(item)).toList();
        });
    }
    return '';
  }

  Future<void> loadListFromLocal(LocalDataKey key) async {
    Future loadListJson(
      List<ParentModels> list,
      Function(List<Map<String, dynamic>> data) getList,
    ) async {
      final List<Map<String, dynamic>> data =
          await LocalData.loadListJson(key: key);
      if (data.isNotEmpty && data.first['error'] == null) {
        getList(data);
      } else {
        await saveListToLocal(key);
      }
    }

    Future loadListString(List<String> list, LocalDataKey key) async {
      final List<String> data = await LocalData.loadListString(key: key);
      list = data;
    }

    switch (key) {
      case LocalDataKey.user:
      case LocalDataKey.news:
      case LocalDataKey.events:
        break;
      case LocalDataKey.recomend:
        await loadListJson(recommendations, (data) {
          recommendations = data.map((item) => Book.fromJson(item)).toList();
        });
        break;
      case LocalDataKey.books:
        await loadListJson(books, (data) {
          books = data.map((item) => Book.fromJson(item)).toList();
        });
        break;
      case LocalDataKey.libriry:
        await loadListJson(libriries, (data) {
          libriries = data.map((item) => Libriry.fromJson(item)).toList();
        });
        break;
      case LocalDataKey.ads:
        await loadListJson(ads, (data) {
          ads = data.map((item) => Ads.fromJson(item)).toList();
        });
        break;
      case LocalDataKey.issueAddress:
        await loadListJson(ads, (data) {
          issueAddress =
              data.map((item) => IssueAddress.fromJson(item)).toList();
        });
        break;
      case LocalDataKey.hystoryZapAds:
        await loadListString(hystoryZapAds, LocalDataKey.hystoryZapAds);
        break;
      case LocalDataKey.hystoryZapNews:
        await loadListString(hystoryZapNews, LocalDataKey.hystoryZapNews);
        break;
      case LocalDataKey.subjectNews:
        await loadListJson(subjectNews, (data) {
          subjectNews = data.map((item) => SubjectNews.fromJson(item)).toList();
        });
        break;
      case LocalDataKey.bookOrders:
        await loadListJson(bookOrders, (data) {
          bookOrders = data.map((item) => BookOrder.fromJson(item)).toList();
        });
        break;
      case LocalDataKey.hystoryZapEvents:
        await loadListString(hystoryZapEvents, LocalDataKey.hystoryZapEvents);
        break;
      case LocalDataKey.myEvents:
        await loadListJson(myEvents, (data) {
          myEvents = data.map((item) => MyEvents.fromJson(item)).toList();
        });
        break;
      case LocalDataKey.hystoryZapBooks:
        await loadListString(hystoryZapBooks, LocalDataKey.hystoryZapBooks);
        break;
      case LocalDataKey.helps:
        await loadListJson(helps, (data) {
          helps = data.map((item) => Help.fromJson(item)).toList();
        });
        break;
      case LocalDataKey.questions:
        await loadListJson(questions, (data) {
          questions = data.map((item) => Question.fromJson(item)).toList();
        });
        break;
    }
  }

  Future<void> saveListToLocal(LocalDataKey key) async {
    Future saveListJson(List<ParentModels> list) async {
      await LocalData.saveListJson(
          json: list.map((item) => item.toJson()).toList(), key: key);
    }

    Future saveListString(List<String> list) async {
      await LocalData.saveListString(list: list, key: key);
    }

    switch (key) {
      case LocalDataKey.user:
        break;
      case LocalDataKey.news:
        await LocalData.saveJson(json: news.toJson(), key: LocalDataKey.news);
        break;
      case LocalDataKey.events:
        await LocalData.saveJson(json: events.toJson(), key: LocalDataKey.news);
        break;
      case LocalDataKey.recomend:
        await saveListJson(recommendations);
        break;
      case LocalDataKey.books:
        await saveListJson(books);
        break;
      case LocalDataKey.libriry:
        await saveListJson(libriries);
        break;
      case LocalDataKey.ads:
        await saveListJson(ads);
        break;
      case LocalDataKey.hystoryZapAds:
        await saveListString(hystoryZapAds);
        break;
      case LocalDataKey.hystoryZapNews:
        await saveListString(hystoryZapNews);
        break;
      case LocalDataKey.subjectNews:
        await saveListJson(subjectNews);
        break;

      case LocalDataKey.hystoryZapEvents:
        await saveListString(hystoryZapEvents);
        break;
      case LocalDataKey.myEvents:
        await saveListJson(myEvents);
        break;
      case LocalDataKey.hystoryZapBooks:
        await saveListString(hystoryZapBooks);
        break;
      case LocalDataKey.issueAddress:
        await saveListJson(issueAddress);
        break;
      case LocalDataKey.bookOrders:
        await saveListJson(bookOrders);
        break;
      case LocalDataKey.helps:
        await saveListJson(helps);
        break;
      case LocalDataKey.questions:
        await saveListJson(questions);
        break;
    }
  }
}
