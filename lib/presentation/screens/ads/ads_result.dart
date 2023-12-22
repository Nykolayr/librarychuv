import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/screens/ads/ads.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// страница объявлений
class AdsResultSearchPage extends StatelessWidget {
  const AdsResultSearchPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('item = ${Get.find<MainBloc>().state.items.length}');
    return Container(
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height - 120,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: AppColor.fon,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...Get.find<MainBloc>()
                .state
                .items
                .map(
                  (item) => AdsItem(item: item),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}
