import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/books.dart';
import 'package:librarychuv/presentation/screens/books/item_book.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// страница результата поиска книг
class BooksResultSearchPage extends StatelessWidget {
  const BooksResultSearchPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 70),
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height - 220,
      color: AppColor.fon,
      child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: false,
          itemCount: Get.find<MainBloc>().state.items.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 2 - 10,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.61,
          ),
          itemBuilder: (context, index) {
            return BookItemAll(
              book: Get.find<MainBloc>().state.items[index] as Book,
            );
          }),
    );
  }
}
