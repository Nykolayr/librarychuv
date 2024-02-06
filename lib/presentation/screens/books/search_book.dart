import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:librarychuv/data/local_data.dart';
import 'package:librarychuv/domain/models/books.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/screens/main/pages.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';
import 'package:librarychuv/presentation/widgets/search.dart';

/// страница поиска книги
class BooksSearchPage extends StatefulWidget {
  const BooksSearchPage({Key? key}) : super(key: key);

  @override
  State<BooksSearchPage> createState() => _BooksSearchPageState();
}

class _BooksSearchPageState extends State<BooksSearchPage> {
  TextEditingController searchController = TextEditingController();
  MainBloc bloc = Get.find<MainBloc>();
  List<String> hystoryZapBooks = Get.find<MainRepository>().hystoryZapBooks;
  List<Book> books = [];
  List<Book> newsBooks = [];
  bool isNotSearch = false;

  goSearch(String text, isSearch) {
    newsBooks = books
        .where((item) => item.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
    if (newsBooks.isNotEmpty) {
      isNotSearch = false;
      if (isSearch && !hystoryZapBooks.contains(searchController.text)) {
        hystoryZapBooks.add(searchController.text);
        Get.find<MainRepository>().saveListToLocal(
          LocalDataKey.hystoryZapBooks,
        );
        searchController.text = '';
      }
      Get.find<MainBloc>().add(
          AddPageEvent(typePage: SecondPageType.bookResult, items: newsBooks));
    } else {
      isNotSearch = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    books = bloc.state.items.isNotEmpty
        ? bloc.state.items as List<Book>
        : Get.find<MainRepository>().books;
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
            SearchFieldSimple(
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
                text: 'Искать книгу'),
            const Gap(20),
            if (hystoryZapBooks.isNotEmpty)
              Text('История запросов:', style: AppText.text12b),
            const Gap(20),
            ...hystoryZapBooks
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
            if (hystoryZapBooks.isNotEmpty)
              GestureDetector(
                onTap: () {
                  hystoryZapBooks = [];
                  Get.find<MainRepository>().hystoryZapNews = [];
                  Get.find<MainRepository>()
                      .saveListToLocal(LocalDataKey.hystoryZapNews);
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
