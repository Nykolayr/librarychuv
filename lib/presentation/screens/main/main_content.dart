import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/books.dart';
import 'package:librarychuv/domain/models/news.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/books/item_book.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/screens/main/pages.dart';
import 'package:librarychuv/presentation/theme/text.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';
import 'package:librarychuv/presentation/widgets/carusel.dart';

/// контент главной страницы
class MainContent extends StatefulWidget {
  const MainContent({super.key});
  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  int maxNews = 5; // максимальное количество новостей
  List<News> newsAll = Get.find<MainRepository>().news;
  List<News> news = [];
  List<Book> recommendationsAll = Get.find<MainRepository>().recommendations;
  List<Book> recommendations = [];
  MainBloc bloc = Get.find<MainBloc>();

  @override
  initState() {
    super.initState();
    news = newsAll.length > maxNews ? newsAll.sublist(0, maxNews) : newsAll;
    recommendations = recommendationsAll.length > maxNews
        ? recommendationsAll.sublist(0, maxNews)
        : recommendationsAll;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Carusel(items: news),  
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Рекомендации',
                style: AppText.text24rCom,
              ),
              GestureDetector(
                onTap: () => bloc.add(
                  const AddPageEvent(typePage: SecondPageType.recomend),
                ),
                child: AppText.textUnder('Подробнее'),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              recommendations.length,
              (index) => BookItem(book: recommendations[index]),
            ),
          ),
        ),
        const Gap(15),
        Buttons.buttonFullWitImage(
          text: 'Библиотеки на карте',
          pathImage: 'assets/svg/map_sign.svg',
          onPressed: () =>
              bloc.add(const AddPageEvent(typePage: SecondPageType.mapLibriry)),
        ),
        const Gap(15),
        Buttons.buttonFullWitImage(
          text: 'Объявления',
          pathImage: 'assets/svg/ads.svg',
          onPressed: () =>
              bloc.add(const AddPageEvent(typePage: SecondPageType.adsAll)),
        ),
        const Gap(90),
      ]),
    );
  }
}
