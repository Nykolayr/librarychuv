import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/news/bloc/bloc/news_bloc.dart';
import 'package:librarychuv/presentation/screens/news/item_news_page.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// страница новостей
class NewsAllPage extends StatefulWidget {
  const NewsAllPage({Key? key}) : super(key: key);

  @override
  State<NewsAllPage> createState() => _NewsAllPageState();
}

class _NewsAllPageState extends State<NewsAllPage> {
  final ScrollController scrollController = ScrollController();
  NewsBloc newsBloc = NewsBloc();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.position.extentAfter < 500) {
      Get.find<NewsBloc>().add(LoadNewsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
        bloc: newsBloc,
        builder: (context, state) => Container(
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
                        .news
                        .map(
                          (item) => NewsItem(item: item),
                        )
                        .toList(),
                    const Gap(75),
                  ],
                ),
              ),
            ));
  }
}
