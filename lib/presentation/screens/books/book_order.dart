import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/book_order.dart';
import 'package:librarychuv/domain/models/books.dart';
import 'package:librarychuv/domain/models/issue_address.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/books/sucsess_order.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';
import 'package:librarychuv/presentation/widgets/drop_dawn.dart';
import 'package:librarychuv/presentation/widgets/textfields.dart';

/// заказ книги
class BookOrderPage extends StatefulWidget {
  const BookOrderPage({Key? key}) : super(key: key);

  @override
  State<BookOrderPage> createState() => _BookOrderPageState();
}

class _BookOrderPageState extends State<BookOrderPage> {
  TextEditingController controller = TextEditingController();
  MainBloc bloc = Get.find<MainBloc>();
  Book book = Book.initial();
  List<String> adresses = [];
  IssueAddress? issueAddress;
  bool isError = false;

  @override
  initState() {
    book = bloc.state.chooseItem as Book;
    Get.find<MainRepository>().issueAddress.forEach((element) {
      adresses.add(element.adress);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height - 120,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: AppColor.fon,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              Text(book.name, style: AppText.captionText16b),
              const Gap(25),
              DropdownButtons(
                title: 'Выберите адрес выдачи',
                items: adresses,
                onChanged: (value) {
                  if (value != null) {
                    issueAddress = Get.find<MainRepository>()
                        .issueAddress
                        .firstWhereOrNull((element) => element.adress == value);
                  }
                },
                isFull: true,
                isRed: false,
              ),
              const Gap(15),
              LibFormField(
                controller: controller,
                hint: 'Комментарий',
                maxLines: 3,
              ),
            ],
          ),
          Column(children: [
            if (isError) Text('Выберите адрес выдачи', style: AppText.text12r),
            const Gap(20),
            Buttons.buttonFull(
                width: context.mediaQuerySize.width - 20,
                onPressed: () async {
                  setState(() {
                    isError = issueAddress == null;
                  });
                  if (issueAddress != null) {
                    BookOrder bookOrder = BookOrder(
                      adress: issueAddress!,
                      book: book,
                      comment: controller.text,
                      id: 0,
                      name: '',
                    );
                    Get.find<MainRepository>().addBookOrder(bookOrder);
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            const AddOrderDone());
                    Get.find<MainBloc>().add(DeletePageEvent());
                  }
                },
                text: 'Заказать'),
            const Gap(100),
          ])
        ],
      ),
    );
  }
}
