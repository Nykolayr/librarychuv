import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/news/item_news_page.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// страница новостей
class NewsAllPage extends StatelessWidget {
  const NewsAllPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height - 120,
      color: AppColor.fon,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...Get.find<MainRepository>()
                .news
                .map(
                  (item) => NewsItem(item: item),
                )
                .toList(),
            const Gap(75),
          ],
        ),
      ),
    );
  }
}
