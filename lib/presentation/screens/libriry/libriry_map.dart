import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/libriry.dart';
import 'package:librarychuv/presentation/screens/libriry/map.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';
import 'package:librarychuv/presentation/widgets/card.dart';
import 'package:librarychuv/presentation/widgets/drop_dawn.dart';
import 'package:librarychuv/presentation/widgets/lines_dot.dart';
import 'package:librarychuv/presentation/widgets/search.dart';

/// страница библиотек на карте apiKeyYandex
class LybraryPage extends StatefulWidget {
  const LybraryPage({Key? key}) : super(key: key);

  @override
  State<LybraryPage> createState() => _LybraryPageState();
}

class _LybraryPageState extends State<LybraryPage> {
  TextEditingController searchController = TextEditingController();
  FocusNode myFocusNode = FocusNode();

  MainBloc bloc = Get.find<MainBloc>();

  @override
  initState() {
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        bloc.add(SortSearchEvent(item: searchController.text, isSearch: true));
      } else {
        if (searchController.text.isEmpty) {
          bloc.add(const SortSearchEvent(item: '', isSearch: false));
        }
      }
    });
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    bloc.add(const SortSearchEvent(item: '', isSearch: false));
    searchController.dispose();
    myFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
        bloc: bloc,
        builder: (context, state) {
          return Container(
            width: context.mediaQuerySize.width,
            height: context.mediaQuerySize.height - 120,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: AppColor.fon,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Buttons.buttonFullWitImage(
                isPadding: false,
                text: 'Библиотеки',
                pathImage: 'assets/svg/map_sign.svg',
                onPressed: () {},
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!bloc.state.isSearch) const DropdownButtons(),
                  if (!bloc.state.isSearch) const Gap(16),
                  Expanded(
                    child: SearchField(
                        searchController: searchController,
                        myFocusNode: myFocusNode),
                  )
                ],
              ),
              const Gap(20),
              RoundedCardWidget(
                subChild: bloc.state.isSearch &&
                        searchController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          searchController.text = '';
                          FocusScope.of(context).unfocus();
                          bloc.add(
                              const SortSearchEvent(item: '', isSearch: false));
                        },
                        child: Text('Очистить поиск', style: AppText.text14g),
                      )
                    : null,
                child: Column(
                  children: [
                    if (bloc.state.searchLibriryItems.isNotEmpty)
                      ...bloc.state.searchLibriryItems
                          .map((e) => getLinesLibrary(e))
                          .toList(),
                    if (bloc.state.searchLibriryItems.isEmpty)
                      Center(
                        child: Text(
                          'По вашему запросу ничего не найдено',
                          style: AppText.text14r,
                        ),
                      ),
                    const Gap(40),
                  ],
                ),
              ),
              const Gap(20),
              Text(
                'Библиотеки на карте',
                style: AppText.text14b.copyWith(fontWeight: FontWeight.w600),
              ),
              const Gap(10),
              const Expanded(child: MapScreen()),
              const Gap(50),
            ]),
          );
        });
  }
}

Widget getLinesLibrary(Libriry libriry) {
  return GestureDetector(
    onTap: () {
      Get.find<MainBloc>().add(ShooseLibriryEvent(index: libriry.id));
    },
    child: LinesWithDot(text: libriry.name),
  );
}
