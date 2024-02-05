import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/books.dart';
import 'package:librarychuv/presentation/screens/account/account_page.dart';
import 'package:librarychuv/presentation/screens/ads/ads_all.dart';
import 'package:librarychuv/presentation/screens/ads/ads_page.dart';
import 'package:librarychuv/presentation/screens/ads/ads_result.dart';
import 'package:librarychuv/presentation/screens/ads/ads_search.dart';
import 'package:librarychuv/presentation/screens/books/book_info.dart';
import 'package:librarychuv/presentation/screens/books/book_order.dart';
import 'package:librarychuv/presentation/screens/books/book_show.dart';
import 'package:librarychuv/presentation/screens/books/books_page.dart';
import 'package:librarychuv/presentation/screens/books/events_results.dart';
import 'package:librarychuv/presentation/screens/books/search_book.dart';
import 'package:librarychuv/presentation/screens/events_pages/event_search.dart';
import 'package:librarychuv/presentation/screens/events_pages/events_all_page.dart';
import 'package:librarychuv/presentation/screens/events_pages/events_page.dart';
import 'package:librarychuv/presentation/screens/events_pages/events_result.dart';
import 'package:librarychuv/presentation/screens/libriry/libriry_map.dart';
import 'package:librarychuv/presentation/screens/main/main_content.dart';
import 'package:librarychuv/presentation/screens/news/news_all_page.dart';
import 'package:librarychuv/presentation/screens/news/news_result.dart';
import 'package:librarychuv/presentation/screens/news/news_search.dart';
import 'package:librarychuv/presentation/screens/news/subscribe_news.dart';
import 'package:librarychuv/presentation/screens/recommend/recommend_page.dart';

import 'bloc/main_bloc.dart';

/// Виджеты главной страницы
/// [ChoosePage] - страница выбора дальнейших действий
/// [ProfilePage] - страница профиля пользователя
/// [MainPageType] - тип страницы
/// [MainPageType.main] - страница выбора дальнейших действий
/// [MainPageType.profile] - страница профиля пользователя
/// также применяется для DefaultTabController

enum MainPageType {
  main,
  news,
  events,
  books,
  account;

  String get pageName {
    switch (this) {
      case MainPageType.main:
        return 'Главная';
      case MainPageType.news:
        return 'Новости';
      case MainPageType.events:
        return 'События';
      case MainPageType.books:
        return 'Книги';
      case MainPageType.account:
        return 'Кабинет';
    }
  }

  String get pageIcon => 'assets/svg/$name.svg';

  Widget get getPage {
    switch (this) {
      case MainPageType.main:
        return const MainContent();
      case MainPageType.news:
        return const NewsAllPage();
      case MainPageType.events:
        return const EventsAllPage();
      case MainPageType.books:
        return const BooksPage();
      case MainPageType.account:
        return const AccountPage();
    }
  }

  List<Widget> get actions {
    switch (this) {
      case MainPageType.main:
        return [];
      case MainPageType.news:
        return [
          iconButtonActions(
            'assets/svg/mail_plus.svg',
            () => Get.find<MainBloc>().add(
                const AddPageEvent(typePage: SecondPageType.subscribeNews)),
          ),
          iconButtonActions(
            'assets/svg/search.svg',
            () => Get.find<MainBloc>()
                .add(const AddPageEvent(typePage: SecondPageType.newsSearch)),
          ),
        ];
      case MainPageType.events:
        return [
          iconButtonActions(
            'assets/svg/search.svg',
            () => Get.find<MainBloc>()
                .add(const AddPageEvent(typePage: SecondPageType.eventsSearch)),
          ),
        ];
      case MainPageType.books:
        return [
          iconButtonActions(
            'assets/svg/search.svg',
            () => Get.find<MainBloc>()
                .add(const AddPageEvent(typePage: SecondPageType.bookSearch)),
          ),
        ];
      case MainPageType.account:
        return [];
    }
  }
}

/// все вторичные страницы
enum SecondPageType {
  mapLibriry,
  recomend,
  adsAll,
  ads,
  news,
  events,
  adsSearch,
  newsSearch,
  eventsSearch,
  resultSearchAds,
  resultSearchNews,
  resultSearchEvents,
  subscribeNews,
  bookInfo,
  bookShow,
  bookSearch,
  bookResult,
  bookOrder,
  ;

  ChoosePage get page {
    switch (this) {
      case SecondPageType.mapLibriry:
        return ChoosePage(page: const LybraryPage(), appBarTitle: 'Назад');
      case SecondPageType.recomend:
        return ChoosePage(
            page: const RecommendPage(), appBarTitle: 'Рекомендации');
      case SecondPageType.adsAll:
        return ChoosePage(
          page: const AdsAllPage(),
          appBarTitle: 'Объявления',
          actions: [
            iconButtonActions(
              'assets/svg/search.svg',
              () => Get.find<MainBloc>()
                  .add(const AddPageEvent(typePage: SecondPageType.adsSearch)),
            ),
          ],
        );
      case SecondPageType.ads:
        return ChoosePage(page: const AdsPage(), appBarTitle: 'Назад');

      case SecondPageType.adsSearch:
        return ChoosePage(page: const AdsSearchPage(), appBarTitle: 'Назад');
      case SecondPageType.resultSearchAds:
        return ChoosePage(
            page: const AdsResultSearchPage(), appBarTitle: 'Результат поиска');
      case SecondPageType.news:
        return ChoosePage(page: const AdsPage(), appBarTitle: 'Назад');
      case SecondPageType.newsSearch:
        return ChoosePage(page: const NewsSearchPage(), appBarTitle: 'Назад');
      case SecondPageType.resultSearchNews:
        return ChoosePage(
            page: const NewsResultSearchPage(),
            appBarTitle: 'Результат поиска');
      case SecondPageType.subscribeNews:
        return ChoosePage(
            page: const NewsSubscribePage(), appBarTitle: 'Назад');
      case SecondPageType.events:
        return ChoosePage(page: const EventsPage(), appBarTitle: 'Назад');
      case SecondPageType.eventsSearch:
        return ChoosePage(page: const EventsSearchPage(), appBarTitle: 'Назад');

      case SecondPageType.resultSearchEvents:
        return ChoosePage(
            page: const EventsResultSearchPage(),
            appBarTitle: 'Результат поиска');
      case SecondPageType.bookInfo:
        return ChoosePage(
          page: const BookInfo(),
          appBarTitle: 'Назад',
          actions: [
            iconButtonActions(
              (Get.find<MainBloc>().state.chooseItem as Book).isFavorite
                  ? 'assets/svg/star_fill.svg'
                  : 'assets/svg/star.svg',
              () => Get.find<MainBloc>()
                  .add(const AddPageEvent(typePage: SecondPageType.bookInfo)),
            ),
          ],
        );
      case SecondPageType.bookShow:
        return ChoosePage(
          page: const BookShow(),
          appBarTitle: 'Назад',
          actions: [
            iconButtonActions(
              'assets/svg/burger.svg',
              () => {},
              //  Get.find<MainBloc>()
              //     .add(const AddPageEvent(typePage: SecondPageType.bookInfo)),
            ),
            iconButtonActions(
              (Get.find<MainBloc>().state.chooseItem as Book).isFavorite
                  ? 'assets/svg/star_fill.svg'
                  : 'assets/svg/star.svg',
              () => Get.find<MainBloc>()
                  .add(const AddPageEvent(typePage: SecondPageType.bookInfo)),
            ),
          ],
        );
      case SecondPageType.bookSearch:
        return ChoosePage(page: const BooksSearchPage(), appBarTitle: 'Назад');
      case SecondPageType.bookResult:
        return ChoosePage(
            page: const BooksResultSearchPage(),
            appBarTitle: 'Результат поиска');
      case SecondPageType.bookOrder:
        return ChoosePage(
            page: const BookOrderPage(), appBarTitle: 'Форма заказа');
    }
  }
}

///  иконки для AppBar
Widget iconButtonActions(String path, VoidCallback? onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(path),
    ),
  );
}

/// вторичные страницы
class ChoosePage {
  Widget page;
  String appBarTitle;
  List<Widget> actions;

  ChoosePage(
      {required this.page, required this.appBarTitle, this.actions = const []});
}
