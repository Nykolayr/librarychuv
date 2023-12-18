import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:librarychuv/presentation/theme/colors.dart';
import 'package:librarychuv/presentation/theme/text.dart';
import 'package:go_router/go_router.dart';

/// общий класс для AppBar
class AppBarWithBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool isShow;

  const AppBarWithBackButton(
      {super.key, this.isShow = true, this.title = 'Назад'});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.fon,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: isShow
          ? GestureDetector(
              onTap: () => context.pop(),
              child: Row(
                children: [
                  SvgPicture.asset('assets/svg/left.svg', width: 15),
                  const Gap(7),
                  Text(title, style: AppText.text24rCom),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
