import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:librarychuv/presentation/theme/text.dart';
import 'package:librarychuv/presentation/widgets/app.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWithBackButton(isShow: false),
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Positioned(
              bottom: 0,
              child: SvgPicture.asset(
                'assets/svg/fon.svg',
                width: context.mediaQuerySize.width,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
              width: context.mediaQuerySize.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svg/logo.svg', width: 118),
                  const Gap(120),
                  Text('Авторизация', style: AppText.captionText36Com),
                  const Gap(36),
                  Buttons.buttonFull(
                      onPressed: () => context.goNamed('Авторизация почта'),
                      text: 'Войти'),
                  const Gap(14),
                  Buttons.buttonOut(onPressed: () {}, text: 'Регистрация'),
                  const Gap(20),
                  GestureDetector(
                    onTap: () => context.goNamed('d'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Авторизация через гос. услуги',
                            style: AppText.button16grey),
                        const Gap(15),
                        SvgPicture.asset(
                          'assets/svg/arrow_gosuslugi.svg',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
