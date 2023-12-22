import 'package:go_router/go_router.dart';
import 'package:librarychuv/common/function.dart';
import 'package:librarychuv/presentation/screens/auth/auth.dart';
import 'package:librarychuv/presentation/screens/auth/auth_mail.dart';
import 'package:librarychuv/presentation/screens/auth/auth_pass.dart';
import 'package:librarychuv/presentation/screens/auth/gosuslugi.dart';
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
          name: 'Авторизация госуслуги',
          path: 'authgosuslugi',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            type: PageTransitionType.rightToLeft,
            context: context,
            state: state,
            child: const AuthGosuslugiPage(),
          ),
        ),
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
      name: 'Основная',
      path: '/basic',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        type: PageTransitionType.fade,
        context: context,
        state: state,
        child: const MainPage(),
      ),
    ),
  ],
);
