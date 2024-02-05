import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/books.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/books/item_book.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// страница справки и вопросов
class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Book> booksAll = Get.find<MainRepository>().books;
    booksAll = [...booksAll];
    return Container(
      padding: const EdgeInsets.only(bottom: 70),
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height - 220,
      color: AppColor.fon,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: false,
        itemCount: booksAll.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 2 - 10,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.61,
        ),
        itemBuilder: (context, index) {
          return BookItemAll(
            book: booksAll[index],
          );
        },
      ),
    );
  }
}
