import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:librarychuv/domain/injects.dart';
import 'package:librarychuv/domain/routers/routers.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

bool isMock = true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await initMain();

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
        final mq = MediaQuery.of(context);
        final fontScale =
            mq.textScaler.clamp(minScaleFactor: 0.9, maxScaleFactor: 1.1);
        mq.textScaler.clamp(minScaleFactor: 0.9, maxScaleFactor: 1.1);
        // AppBar? bar = AppBar(
        //   toolbarHeight: 40,
        //   centerTitle: true,
        //   title: Text('состояние:  ${error.isEmpty ? 'Ошибки нет' : error}',
        //       style: AppText.button15b),
        // );
        // Future.delayed(const Duration(seconds: 1), () {
        //   bar = null;
        // });
        return Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: mq.copyWith(textScaler: fontScale),
            child: Scaffold(
              // appBar: bar,
              body: child!,
            ),
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
