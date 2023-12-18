import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/books.dart';
import 'package:librarychuv/domain/models/news.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/books/item_book.dart';
import 'package:librarychuv/presentation/theme/text.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';
import 'package:librarychuv/presentation/widgets/carusel.dart';

/// контент главной страницы
class MainContent extends StatefulWidget {
  const MainContent({Key? key}) : super(key: key);

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  int maxNews = 5; // максимальное количество новостей
  List<News> newsAll = Get.find<MainRepository>().news;
  List<News> news = [];
  List<Book> recommendationsAll = Get.find<MainRepository>().recommendations;
  List<Book> recommendations = [];

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
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
              onTap: () {},
              child: AppText.TextUnder('Подробнее'),
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
          onPressed: () {}),
      const Gap(15),
      Buttons.buttonFullWitImage(
          text: 'Объявления',
          pathImage: 'assets/svg/ads.svg',
          onPressed: () {}),
      const Gap(90),
    ]);
  }
}
