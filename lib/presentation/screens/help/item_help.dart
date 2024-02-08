import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/help.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/screens/main/pages.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/lines_dot.dart';

class HelpItem extends StatelessWidget {
  final Help item;

  const HelpItem({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainBloc bloc = Get.find<MainBloc>();
    return GestureDetector(
      onTap: () => bloc.add(AddPageEvent(
        typePage: SecondPageType.answerhelp,
        parentItem: item,
      )),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
            color: AppColor.greyText3,
          )),
        ),
        child: LinesWithDot(
          text: item.name,
          isRed: item.isRed,
        ),
      ),
    );
  }
}
