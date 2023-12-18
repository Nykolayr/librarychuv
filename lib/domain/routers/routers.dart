import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:librarychuv/common/function.dart';
import 'package:librarychuv/domain/repository/user_repository.dart';
import 'package:librarychuv/presentation/screens/auth/auth.dart';
import 'package:librarychuv/presentation/screens/auth/auth_mail.dart';
import 'package:librarychuv/presentation/screens/auth/auth_pass.dart';
import 'package:librarychuv/presentation/screens/main/main_page.dart';
import 'package:librarychuv/presentation/screens/main/splash.dart';
import 'package:page_transition/page_transition.dart';

final GoRouter router = GoRouter(
  // observers: [GoNavigatorObserver()],
  debugLogDiagnostics: true,
  initialLocation: '/splash',
  // getInitialPath(),
  routes: <GoRoute>[
    GoRoute(
      name: 'splash',
      path: '/splash',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        type: PageTransitionType.fade,
        context: context,
        state: state,
        child: const SplashPage(),
      ),
    ),
    GoRoute(
      name: 'Авторизация',
      path: '/auth',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        type: PageTransitionType.rightToLeft,
        context: context,
        state: state,
        child: const AuthPage(),
      ),
      routes: [
        GoRoute(
          name: 'Авторизация почта',
          path: 'authmail',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            type: PageTransitionType.rightToLeft,
            context: context,
            state: state,
            child: const AuthMailPage(),
          ),
          routes: [
            GoRoute(
              name: 'Авторизация пароль',
              path: 'authpass',
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                type: PageTransitionType.rightToLeft,
                context: context,
                state: state,
                child: const AuthPassPage(),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: 'Главная',
      path: '/main',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        type: PageTransitionType.fade,
        context: context,
        state: state,
        child: MainPage(widget: Container()),
      ),
    ),
  ],
);

enum AccountPageType {
  edit,
  yourCashBack,
  qrCode;

  String get pageName {
    switch (this) {
      case AccountPageType.edit:
        return 'Общие настройки';
      case AccountPageType.qrCode:
        return 'QR-код пользователя';
      case AccountPageType.yourCashBack:
        return 'Ваш счет';
    }
  }

  Widget get getPage {
    switch (this) {
      case AccountPageType.edit:
        return Container();
      case AccountPageType.qrCode:
        return Container();
      case AccountPageType.yourCashBack:
        return Container();
    }
  }

  GoRoute get getRouter => getGoRoutersAccount(this);
}

GoRoute getGoRoutersAccount(AccountPageType type) {
  return GoRoute(
    name: type.pageName,
    path: type.name,
    pageBuilder: (context, state) => buildPageWithDefaultTransition(
      type: PageTransitionType.fade,
      context: context,
      state: state,
      child: MainPage(
        widget: type.getPage,
      ),
    ),
  );
}

/// функция возращает путь для первоначальной страницы
/// в зависимости от  пользователь авторизирован или нет
String getInitialPath() {
  if (Get.find<UserRepository>().user.token.isEmpty) {
    return '/auth';
  } else {
    return '/main';
  }
}
