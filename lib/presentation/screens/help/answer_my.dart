import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/qustion.dart';
import 'package:librarychuv/presentation/screens/help/item_question.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// страница ответа на справку
class AnswerMyPage extends StatelessWidget {
  const AnswerMyPage({super.key});

  @override
  Widget build(BuildContext context) {
    MainBloc bloc = Get.find<MainBloc>();
    Question item = bloc.state.parentItem as Question;
    bool isAwait = item.typeQuestion == TypeQuestion.resRecive;

    return Container(
      padding: const EdgeInsets.only(bottom: 70, left: 12, right: 12),
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height - 120,
      color: AppColor.fon,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          QuestionHelpItem(item: item, isShow: false),
          getContainer(item.question, '', true, context),
          if (isAwait) getContainer(item.answer, item.operator, false, context),
        ],
      ),
    );
  }

  Widget getContainer(
      String text, String sub, bool isQuest, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: EdgeInsets.only(
        bottom: 10,
        right: isQuest ? 0 : 40,
        left: isQuest ? 40 : 0,
      ),
      width: context.mediaQuerySize.width - 20,
      decoration: BoxDecoration(
        color: isQuest ? AppColor.fonHelp : AppColor.stroke,
        borderRadius: AppDif.borderRadius10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isQuest)
            Text('Оператор: $sub',
                style: AppText.text14r.copyWith(color: AppColor.greyText)),
          Text(text,
              style: AppText.text14r.copyWith(color: AppColor.blackText)),
        ],
      ),
    );
  }
}
