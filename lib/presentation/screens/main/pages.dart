import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/screens/account/account_page.dart';
import 'package:librarychuv/presentation/screens/ads/ads_all.dart';
import 'package:librarychuv/presentation/screens/ads/ads_page.dart';
import 'package:librarychuv/presentation/screens/ads/ads_result.dart';
import 'package:librarychuv/presentation/screens/ads/ads_search.dart';
import 'package:librarychuv/presentation/screens/books/books_page.dart';
import 'package:librarychuv/presentation/screens/events_pages/events_page.dart';
import 'package:librarychuv/presentation/screens/libriry/libriry_map.dart';
import 'package:librarychuv/presentation/screens/main/main_content.dart';
import 'package:librarychuv/presentation/screens/news/news_page.dart';
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
        return const NewsPage();
      case MainPageType.events:
        return const EventsPage();
      case MainPageType.books:
        return const BooksPage();
      case MainPageType.account:
        return const AccountPage();
    }
  }
}

/// все вторичные страницы
enum SecondPageType {
  mapLibriry,
  recomend,
  adsAll,
  ads,
  adsSearch,
  resultSearchAds;

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
                () => Get.find<MainBloc>().add(
                    const AddPageEvent(typePage: SecondPageType.adsSearch)),
              ),
            ]);
      case SecondPageType.ads:
        return ChoosePage(page: const AdsPage(), appBarTitle: 'Назад');

      case SecondPageType.adsSearch:
        return ChoosePage(page: const AdsSearchPage(), appBarTitle: 'Назад');
      case SecondPageType.resultSearchAds:
        return ChoosePage(
            page: const AdsResultSearchPage(), appBarTitle: 'Результат поиска');
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
