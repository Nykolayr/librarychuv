import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/ads/ads_item.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// страница объявлений
class AdsAllPage extends StatelessWidget {
  const AdsAllPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height - 120,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: AppColor.fon,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...Get.find<MainRepository>()
                .ads
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
