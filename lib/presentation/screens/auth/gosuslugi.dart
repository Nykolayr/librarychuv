import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/theme/different.dart';
import 'package:librarychuv/presentation/widgets/app.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthGosuslugiPage extends StatefulWidget {
  const AuthGosuslugiPage({super.key});

  @override
  State<AuthGosuslugiPage> createState() => _AuthGosuslugiPageState();
}

class _AuthGosuslugiPageState extends State<AuthGosuslugiPage> {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.gosuslugi.ru/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://www.gosuslugi.ru/'));
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWithBackButton(),
        body: Stack(alignment: AlignmentDirectional.topCenter, children: [
          Positioned(
            bottom: 0,
            child: SvgPicture.asset(
              'assets/svg/fon.svg',
              width: context.mediaQuerySize.width,
            ),
          ),
          Container(
            width: context.mediaQuerySize.width,
            height: context.mediaQuerySize.height,
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
              child: WebViewWidget(controller: controller),
            ),
          ),
        ]),
      ),
    );
  }
}
