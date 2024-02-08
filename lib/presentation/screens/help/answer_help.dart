import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/help.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// страница ответа на справку
class AnswerHelpPage extends StatelessWidget {
  const AnswerHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    MainBloc bloc = Get.find<MainBloc>();
    return Container(
      padding: const EdgeInsets.only(bottom: 70, left: 12, right: 12),
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height - 120,
      color: AppColor.fon,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Вопрос:', style: AppText.text16g),
            const Gap(10),
            getContainer((bloc.state.parentItem as Help).name, true, context),
            const Gap(25),
            Text('Ответ:', style: AppText.text16g),
            const Gap(10),
            getContainer(
                (bloc.state.parentItem as Help).answer, false, context),
          ],
        ),
      ),
    );
  }

  Widget getContainer(String text, bool isQuest, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: context.mediaQuerySize.width - 20,
      decoration: BoxDecoration(
        color: isQuest ? AppColor.white : AppColor.fonBaner,
        borderRadius: AppDif.borderRadius10,
      ),
      child: Text(text,
          style: AppText.text14r.copyWith(
              color: isQuest ? AppColor.redMain : AppColor.blackText)),
    );
  }
}
