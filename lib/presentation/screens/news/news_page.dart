import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/screens/news/item_news_page.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// страница одного объявления
class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height - 120,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: AppColor.fon,
      child: SingleChildScrollView(
        child:
            NewsItem(item: Get.find<MainBloc>().state.chooseItem, isOne: true),
      ),
    );
  }
}
