import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/books.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/screens/main/pages.dart';
import 'package:librarychuv/presentation/theme/colors.dart';
import 'package:librarychuv/presentation/theme/different.dart';
import 'package:librarychuv/presentation/theme/text.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';

class BookItem extends StatelessWidget {
  final Book book;
  const BookItem({Key? key, required this.book}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 138,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: AppDif.borderRadius10,
              border: AppDif.borderCarusel,
              boxShadow: [AppDif.boxShadowCarusel],
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: AppDif.borderRadius10,
              ),
              child: Image.asset(
                book.pathImage,
              ),
            ),
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
            child: Text(
              book.name,
              maxLines: 2,
              style: AppText.text12r.copyWith(color: AppColor.blackText),
            ),
          ),
          const Gap(10),
          Buttons.buttonPink(
              onPressed: () => Get.find<MainBloc>().add(AddPageEvent(
                  typePage: SecondPageType.bookShow, chooseItem: book)),
              text: 'Посмотреть',
              width: 138)
        ],
      ),
    );
  }
}

class BookItemAll extends StatelessWidget {
  final Book book;
  const BookItemAll({Key? key, required this.book}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2 - 30,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: AppDif.borderRadius10,
            border: AppDif.borderCarusel,
            boxShadow: [AppDif.boxShadowCarusel],
          ),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: AppDif.borderRadius10,
            ),
            child: Image.asset(book.pathImage, fit: BoxFit.fitHeight),
          ),
        ),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: Text(
            book.name,
            maxLines: 2,
            style: AppText.text12r.copyWith(color: AppColor.blackText),
          ),
        ),
        const Gap(10),
        Buttons.buttonPink(
            onPressed: () {
              Get.find<MainBloc>().add(AddPageEvent(
                  typePage: SecondPageType.bookInfo, chooseItem: book));
            },
            text: 'Посмотреть книгу',
            width: MediaQuery.of(context).size.width / 2 - 30)
      ],
    );
  }
}
