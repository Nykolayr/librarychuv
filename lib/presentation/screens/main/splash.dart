import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:librarychuv/domain/repository/user_repository.dart';
import 'package:librarychuv/presentation/theme/colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      context.goNamed(Get.find<UserRepository>().user.token.isEmpty
          ? 'Авторизация'
          : 'Основная');
    });
    return Scaffold(
      backgroundColor: AppColor.fon,
      body: Align(
        alignment: Alignment
            .bottomCenter, // Или Alignment.bottomLeft или Alignment.bottomRight
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset('assets/svg/logo_full.svg'),
            const Gap(50),
            SvgPicture.asset('assets/svg/fon.svg',
                width: context.mediaQuerySize.width),
          ],
        ),
      ),
    );
  }
}
