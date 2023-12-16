import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:librarychuv/common/function.dart';
import 'package:librarychuv/presentation/screens/auth/auth.dart';
import 'package:librarychuv/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:librarychuv/presentation/screens/main/main_page.dart';
import 'package:page_transition/page_transition.dart';

final GoRouter router = GoRouter(
  // observers: [GoNavigatorObserver()],
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: <GoRoute>[
    GoRoute(
      name: 'авторизация',
      path: 'auth',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        type: PageTransitionType.fade,
        context: context,
        state: state,
        child: BlocProvider(
          create: (BuildContext context) => AuthBloc(),
          child: const AuthPage(),
        ),
      ),
    ),
    GoRoute(
      name: 'Главная',
      path: '/',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        type: PageTransitionType.fade,
        context: context,
        state: state,
        child: MainPage(widget: Container()),
      ),
      routes: [],
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
