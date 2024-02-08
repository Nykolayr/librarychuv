import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/help.dart';
import 'package:librarychuv/domain/models/qustion.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/help/item_help.dart';
import 'package:librarychuv/presentation/screens/help/item_question.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';
import 'package:librarychuv/presentation/widgets/search.dart';

import '../main/bloc/main_bloc.dart';

/// страница справки и вопросов
class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  TextEditingController searchController = TextEditingController();
  List<Help> helps = Get.find<MainRepository>().helps;
  List<Question> questions = Get.find<MainRepository>().questions;
  List<Help> filterHelps = [];
  MainBloc bloc = Get.find<MainBloc>();

  @override
  initState() {
    filterHelps = helps;
    searchController.addListener(() {
      filterHelps = helps
          .where((element) => element.name
              .toUpperCase()
              .contains(searchController.text.toUpperCase()))
          .toList();
      setState(() {});
    });
    super.initState();
  }

  @override
  dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
        bloc: bloc,
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 70, left: 12, right: 12),
                width: context.mediaQuerySize.width,
                height: context.mediaQuerySize.height - 120,
                color: AppColor.fon,
                child: SingleChildScrollView(
                  child: state.isHelp
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (var item in questions)
                              QuestionHelpItem(item: item, isShow: true),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Gap(15),
                            Text('Виртуальный справочник',
                                style: AppText.captionText16b),
                            const Gap(25),
                            SearchFieldHelp(searchController: searchController),
                            const Gap(25),
                            if (filterHelps.isEmpty)
                              Text('Ничего не найдено',
                                  style: AppText.captionText14r),
                            for (var item in filterHelps) HelpItem(item: item),
                          ],
                        ),
                ),
              ),
              Positioned(
                bottom: 90,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Buttons.buttonFull(
                    width: context.mediaQuerySize.width - 20,
                    onPressed: () async {},
                    text: 'Задать вопрос',
                  ),
                ),
              ),
            ],
          );
        });
  }
}
