import 'package:flutter/material.dart';
import 'package:librarychuv/presentation/screens/account/account_page.dart';
import 'package:librarychuv/presentation/screens/books/books_page.dart';
import 'package:librarychuv/presentation/screens/events/events_page.dart';
import 'package:librarychuv/presentation/screens/main/main_content.dart';
import 'package:librarychuv/presentation/screens/news/news_page.dart';

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
