import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/screens/ads/ads_item.dart';
import 'package:librarychuv/presentation/screens/news/bloc/bloc/news_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// страница результата поиска новостей
class NewsResultSearchPage extends StatefulWidget {
  const NewsResultSearchPage({Key? key}) : super(key: key);

  @override
  NewsResultSearchPageState createState() => NewsResultSearchPageState();
}

class NewsResultSearchPageState extends State<NewsResultSearchPage> {
  bool isNext = true;
  final ScrollController scrollController = ScrollController();
  NewsBloc newsBloc = Get.find<NewsBloc>();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.position.extentAfter < 500) {
      if (isNext) {
        newsBloc.add(LoadNewsSearchEvent());
        isNext = false;
        Future.delayed(const Duration(seconds: 2), () {
          isNext = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      bloc: newsBloc,
      builder: (context, state) => Stack(
        children: [
          Container(
            width: context.mediaQuerySize.width,
            height: context.mediaQuerySize.height - 120,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: AppColor.fon,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...newsBloc.state.searchNews.news
                      .map(
                        (item) => AdsItem(item: item),
                      )
                      .toList()
                ],
              ),
            ),
          ),
          if (state.isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
