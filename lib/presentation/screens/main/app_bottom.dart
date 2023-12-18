import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:librarychuv/presentation/screens/main/pages.dart';
import 'package:librarychuv/presentation/theme/colors.dart';
import 'package:librarychuv/presentation/theme/different.dart';
import 'package:librarychuv/presentation/theme/text.dart';

/// табы в виде виджета для переходов между страницами на главной

class AppBottom extends StatelessWidget {
  final TabController tabController;
  final PageController pageController;
  const AppBottom(
      {required this.tabController, required this.pageController, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: AppDif.radius20,
          topRight: AppDif.radius20,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.greyText.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      alignment: Alignment.center,
      height: 75,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            indicatorColor: Colors.transparent,
            onTap: (index) {
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            controller: tabController,
            unselectedLabelColor: AppColor.greyText3,
            labelColor: AppColor.redMain,
            labelStyle: AppText.text10r,
            tabs: [
              for (int i = 0; i < MainPageType.values.length; i++)
                Tab(
                  text: MainPageType.values[i].pageName,
                  icon: SvgPicture.asset(MainPageType.values[i].pageIcon,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                          i == tabController.index
                              ? AppColor.redMain
                              : AppColor.greyText3,
                          BlendMode.srcIn)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
