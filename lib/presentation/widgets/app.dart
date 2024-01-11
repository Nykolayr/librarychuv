import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:librarychuv/presentation/screens/main/pages.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// общий класс для AppBar
class AppBarWithBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool isShow;
  final MainPageType? typePage;
  final Function()? onSearch;
  const AppBarWithBackButton(
      {super.key,
      this.isShow = true,
      this.title = 'Назад',
      this.onSearch,
      this.typePage});

  @override
  Widget build(BuildContext context) {
    MainBloc bloc = Get.find<MainBloc>();
    return AppBar(
        backgroundColor: AppColor.fon,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Get.find<MainBloc>().state.isSecondPage
            ? GestureDetector(
                onTap: () {
                  if (bloc.state.isSecondPage) {
                    bloc.add(DeletePageEvent());
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
        actions: [
          if (bloc.state.isSecondPage) ...[
            ...bloc.state.typePages.last.page.actions,
            const Gap(2),
          ],
          if (typePage != null) ...[
            ...typePage!.actions,
            const Gap(2),
          ],
        ]);
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
