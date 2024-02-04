import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/screens/ads/ads_item.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// страница одного объявления
class AdsPage extends StatelessWidget {
  const AdsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height - 120,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: AppColor.fon,
      child: SingleChildScrollView(
        child:
            AdsItem(item: Get.find<MainBloc>().state.chooseItem, isOne: true),
      ),
    );
  }
}
