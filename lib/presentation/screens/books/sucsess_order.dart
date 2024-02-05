import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:librarychuv/presentation/widgets/fon_picture.dart';

import '../../theme/theme.dart';

/// при добавление заказа книги вызывается этот экран
class AddOrderDone extends StatelessWidget {
  const AddOrderDone({Key? key}) : super(key: key);

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
                  Text('КНИГА ЗАКАЗАНА',
                      style: AppText.captionText36Com.copyWith(fontSize: 28),
                      textAlign: TextAlign.center),
                  const Gap(35),
                  Text('ДЛЯ ОТСЛЕЖИВАНИЯ \nЗАЙДИТЕ В КАБИНЕТ',
                      style: AppText.captionText36Com.copyWith(fontSize: 28),
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
