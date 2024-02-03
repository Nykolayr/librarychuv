import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/data/local_data.dart';
import 'package:librarychuv/domain/models/books.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/books/text_url_pdf.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';

/// информация о книге, переход с кнопки посмотреть книгу
class BookInfo extends StatefulWidget {
  const BookInfo({Key? key}) : super(key: key);

  @override
  State<BookInfo> createState() => _BookInfoState();
}

class _BookInfoState extends State<BookInfo> {
  MainBloc bloc = Get.find<MainBloc>();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
        bloc: bloc,
        buildWhen: (previous, current) {
          return true;
        },
        builder: (context, state) {
          Book book = bloc.state.items.first as Book;
          return Container(
            width: context.mediaQuerySize.width,
            height: context.mediaQuerySize.height - 120,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: AppColor.fon,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(10),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12.0),
                        decoration: const BoxDecoration(
                          borderRadius: AppDif.borderRadius10,
                        ),
                        child: Image.asset(
                          book.pathImage,
                        ),
                      ),
                      Text(book.name, style: AppText.captionText16b),
                      const Gap(15),
                      RedLinkWidget(text: book.description, onTap: (url) {}),
                      const Gap(15),
                      Text(book.preface, style: AppText.text12b),
                      const Gap(210),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 75,
                  left: 0,
                  child: Container(
                    color: AppColor.fon,
                    width: context.mediaQuerySize.width - 20,
                    padding: const EdgeInsets.only(top: 15, bottom: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Buttons.buttonOut(
                                width: context.mediaQuerySize.width * 0.65 - 15,
                                onPressed: () {
                                  book.isFavorite = !book.isFavorite;
                                  Get.find<MainRepository>()
                                      .books
                                      .firstWhere((item) => item.id == book.id)
                                      .isFavorite = book.isFavorite;
                                  Get.find<MainRepository>()
                                      .saveListToLocal(LocalDataKey.books);
                                  bloc.add(AddFirstItemEvent(item: book));
                                },
                                text: book.isFavorite
                                    ? 'Удалить из избранного'
                                    : 'Добавить в избранное'),
                            Buttons.buttonOut(
                                width: context.mediaQuerySize.width * 0.35 - 15,
                                onPressed: () {},
                                text: 'Заказать'),
                          ],
                        ),
                        const Gap(10),
                        Buttons.buttonFull(
                            width: context.mediaQuerySize.width - 20,
                            onPressed: () {},
                            text: 'Открыть книгу'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
