import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// табуляторы для AppBar
class TabAppHelp extends StatefulWidget {
  const TabAppHelp({super.key});

  @override
  State<TabAppHelp> createState() => _TabAppHelpState();
}

class _TabAppHelpState extends State<TabAppHelp> {
  MainBloc bloc = Get.find<MainBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
        bloc: bloc,
        builder: (context, state) {
          return Row(
            children: [
              getTab('Справочник', false),
              const Gap(20),
              getTab('Мои вопросы', true),
            ],
          );
        });
  }

  Widget getTab(String title, bool isHelp) {
    return GestureDetector(
      onTap: () {
        bloc.add(ChangeTabEvent(isHelp: isHelp));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color:
                bloc.state.isHelp == isHelp ? AppColor.redMain : AppColor.fon,
          )),
        ),
        child: Text(title,
            style: AppText.text16g.copyWith(
                fontSize: 17,
                color: bloc.state.isHelp == isHelp
                    ? AppColor.blackText
                    : AppColor.greyText2)),
      ),
    );
  }
}
