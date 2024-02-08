import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/help.dart';
import 'package:librarychuv/domain/models/help_item.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
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
          return Container(
            padding: const EdgeInsets.only(bottom: 70, left: 12, right: 12),
            width: context.mediaQuerySize.width,
            height: context.mediaQuerySize.height - 120,
            color: AppColor.fon,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(15),
                  Text('Виртуальный справочник', style: AppText.captionText16b),
                  const Gap(25),
                  SearchFieldHelp(searchController: searchController),
                  const Gap(25),
                  if (filterHelps.isEmpty)
                    Text('Ничего не найдено', style: AppText.captionText14r),
                  for (var item in filterHelps) HelpItem(item: item),
                ],
              ),
            ),
          );
        });
  }
}
