import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/common/utils.dart';
import 'package:librarychuv/domain/models/book_order.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// страница заказов
class OrdersTrashPage extends StatelessWidget {
  const OrdersTrashPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<BookOrder> ordersAll = Get.find<MainRepository>().bookOrders;

    return Container(
      padding: const EdgeInsets.only(bottom: 70, left: 12, right: 12),
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height - 120,
      color: AppColor.fon,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (BookOrder order in ordersAll) OrderItem(order: order),
          ],
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final BookOrder order;
  const OrderItem({Key? key, required this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: context.mediaQuerySize.width,
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 110,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: AppColor.white,
              borderRadius: AppDif.borderRadius10,
            ),
            child: Image.asset(order.book.pathImage, fit: BoxFit.fitHeight),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        order.book.name,
                        style: AppText.text12b,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    order.type.baner,
                  ],
                ),
                Text(
                  'Адресс получения: ${order.adress.adress}',
                  style: AppText.text12b.copyWith(color: AppColor.greyText),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Дата заказа: ${Utils.getFormatDate(order.date)}',
                  style: AppText.text12b.copyWith(color: AppColor.greyText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
