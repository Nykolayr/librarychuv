import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
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
      title: Get.find<MainBloc>().state.pages.isNotEmpty
          ? GestureDetector(
              onTap: () {
                if (Get.find<MainBloc>().state.pages.isNotEmpty) {
                  Get.find<MainBloc>().add(const DeletePageEvent());
                } else {
                  context.pop();
                }
              },
              child: Row(
                children: [
                  SvgPicture.asset('assets/svg/left.svg', width: 15),
                  const Gap(7),
                  Text(title, style: AppText.text24rCom),
                ],
              ),
            )
          : Text(title, style: AppText.text24rCom),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
