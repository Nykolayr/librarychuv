import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:librarychuv/domain/injects.dart';

import 'package:librarychuv/domain/routers/routers.dart';
import 'package:librarychuv/presentation/theme/colors.dart';
import 'package:surf_logger/surf_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMaint();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Lib',
      debugShowCheckedModeBanner: false,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      theme: ThemeData(
          scaffoldBackgroundColor: AppColor.fon,
          useMaterial3: false,
          textTheme: GoogleFonts.robotoTextTheme(),
          fontFamily: GoogleFonts.roboto().fontFamily,
          appBarTheme: const AppBarTheme(color: AppColor.white),
          canvasColor: AppColor.fon,
          dialogBackgroundColor: Colors.white),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('en', ''),
        Locale('ru', ''),
      ],
      locale: const Locale('ru', ''),
      builder: (context, child) {
        // добавил логирование для отладки
        Logger.addStrategy(DebugLogStrategy());
        final mq = MediaQuery.of(context);
        final fontScale =
            mq.textScaler.clamp(minScaleFactor: 0.9, maxScaleFactor: 1.1);
        mq.textScaler.clamp(minScaleFactor: 0.9, maxScaleFactor: 1.1);
        return Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: mq.copyWith(textScaler: fontScale),
            // child: MultiBlocProvider(
            //   providers: [
            //     BlocProvider(
            //       create: (_) => AuthBloc(),
            //     ),
            //   ],
            child: child!,
          ),
          // ),
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
