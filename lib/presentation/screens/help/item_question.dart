import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/common/utils.dart';
import 'package:librarychuv/domain/models/qustion.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/screens/main/pages.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

class QuestionHelpItem extends StatelessWidget {
  final Question item;
  final bool isShow;
  const QuestionHelpItem({required this.item, Key? key, required this.isShow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainBloc bloc = Get.find<MainBloc>();
    return GestureDetector(
      onTap: () {
        if (isShow) {
          bloc.add(AddPageEvent(
            typePage: SecondPageType.answerMy,
            parentItem: item,
          ));
        }
      },
      child: Container(
        width: context.mediaQuerySize.width - 20,
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: AppDif.borderRadius10,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Utils.getFormatDate(item.date), style: AppText.text16gCom),
                item.typeQuestion.baner,
              ],
            ),
            const Gap(10),
            Text(item.question, style: AppText.text14b),
          ],
        ),
      ),
    );
  }
}
