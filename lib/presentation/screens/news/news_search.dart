import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:librarychuv/data/local_data.dart';
import 'package:librarychuv/domain/models/news.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/screens/main/pages.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';
import 'package:librarychuv/presentation/widgets/search.dart';

/// страница поиска новостей
class NewsSearchPage extends StatefulWidget {
  const NewsSearchPage({Key? key}) : super(key: key);

  @override
  State<NewsSearchPage> createState() => _NewsSearchPageState();
}

class _NewsSearchPageState extends State<NewsSearchPage> {
  TextEditingController searchController = TextEditingController();
  MainBloc bloc = Get.find<MainBloc>();
  List<String> hystoryZapNews = Get.find<MainRepository>().hystoryZapNews;
  List<News> news = Get.find<MainRepository>().news.news;
  List<News> newsSearch = [];
  bool isNotSearch = false;

  goSearch(String text, isSearch) {
    newsSearch = news
        .where((item) => item.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
    if (newsSearch.isNotEmpty) {
      isNotSearch = false;
      if (isSearch && !hystoryZapNews.contains(searchController.text)) {
        hystoryZapNews.add(searchController.text);
        Get.find<MainRepository>().saveListToLocal(
          LocalDataKey.hystoryZapNews,
        );
        searchController.text = '';
      }
      Get.find<MainBloc>().add(AddPageEvent(
          typePage: SecondPageType.resultSearchNews, items: newsSearch));
    } else {
      isNotSearch = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height - 120,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: AppDif.borderRadius10,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Text('Чувашские символы для поиска: Ӑ ӑ Ӗ ӗ Ӳ ӳ Ҫ ҫ',
                style: AppText.text12b),
            const Gap(15),
            SearchFieldHelp(
              searchController: searchController,
            ),
            const Gap(15),
            if (isNotSearch) Text('Ничего не найдено', style: AppText.text12r),
            if (isNotSearch) const Gap(15),
            Buttons.buttonFull(
                onPressed: () {
                  if (searchController.text.isNotEmpty) {
                    goSearch(searchController.text, true);
                  }
                },
                text: 'Искать новость'),
            const Gap(20),
            if (hystoryZapNews.isNotEmpty)
              Text('История запросов:', style: AppText.text12b),
            const Gap(20),
            ...hystoryZapNews
                .map(
                  (item) => GestureDetector(
                    onTap: () => goSearch(item, false),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        item,
                        style: AppText.text12r,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                )
                .toList(),
            const Gap(10),
            if (hystoryZapNews.isNotEmpty)
              GestureDetector(
                onTap: () {
                  hystoryZapNews = [];
                  Get.find<MainRepository>().hystoryZapNews = [];
                  Get.find<MainRepository>().saveListToLocal(
                    LocalDataKey.hystoryZapNews,
                  );
                  setState(() {});
                },
                child: Center(
                  child: AppText.textUnder('Очистить историю поиска',
                      isSearch: true),
                ),
              ),
            const Gap(70),
          ],
        ),
      ),
    );
  }
}
