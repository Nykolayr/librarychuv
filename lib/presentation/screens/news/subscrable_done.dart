import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:librarychuv/presentation/widgets/fon_picture.dart';

import '../../theme/theme.dart';

/// при удачной подписке на новости вызывается этот экран
class SubscrableDone extends StatelessWidget {
  const SubscrableDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Container(
        width: context.mediaQuerySize.width,
        height: context.mediaQuerySize.height,
        color: AppColor.fon,
        child: Stack(
          children: [
            const FonPicture(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('НОВОСТНАЯ \nПОДПИСКА \nОФОРМЛЕНА',
                      style: AppText.captionText36Com,
                      textAlign: TextAlign.center),
                  Gap(context.mediaQuery.size.height / 3),
                  Text('Нажмите по экрану, чтобы продолжить',
                      style:
                          AppText.text14r.copyWith(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center),
                  const Gap(40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
