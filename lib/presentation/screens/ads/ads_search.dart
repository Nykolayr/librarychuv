import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:librarychuv/data/local_data.dart';
import 'package:librarychuv/domain/models/ads.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/screens/main/pages.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';
import 'package:librarychuv/presentation/widgets/search.dart';

/// страница объявлений
class AdsSearchPage extends StatefulWidget {
  const AdsSearchPage({Key? key}) : super(key: key);

  @override
  State<AdsSearchPage> createState() => _AdsSearchPageState();
}

class _AdsSearchPageState extends State<AdsSearchPage> {
  TextEditingController searchController = TextEditingController();
  MainBloc bloc = Get.find<MainBloc>();
  List<String> hystoryZapAds = Get.find<MainRepository>().hystoryZapAds;
  List<Ads> ads = Get.find<MainRepository>().ads;
  List<Ads> adsSearch = [];
  bool isNotSearch = false;

  goSearch(String text, isSearch) {
    adsSearch = ads
        .where((item) => item.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
    if (adsSearch.isNotEmpty) {
      isNotSearch = false;
      if (isSearch && !hystoryZapAds.contains(searchController.text)) {
        hystoryZapAds.add(searchController.text);
        Get.find<MainRepository>().saveListToLocal(
          LocalDataKey.hystoryZapAds,
        );
        searchController.text = '';
      }
      Get.find<MainBloc>().add(AddPageEvent(
          typePage: SecondPageType.resultSearchAds, items: adsSearch));
    } else {
      isNotSearch = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height - 120,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: AppDif.borderRadius10,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Text('Чувашские символы для поиска: Ӑ ӑ Ӗ ӗ Ӳ ӳ Ҫ ҫ',
                style: AppText.text12b),
            const Gap(15),
            SearchFieldHelp(
              searchController: searchController,
            ),
            const Gap(15),
            if (isNotSearch) Text('Ничего не найдено', style: AppText.text12r),
            if (isNotSearch) const Gap(15),
            Buttons.buttonFull(
                onPressed: () {
                  if (searchController.text.isNotEmpty) {
                    goSearch(searchController.text, true);
                  }
                },
                text: 'Искать объявление'),
            const Gap(20),
            if (hystoryZapAds.isNotEmpty)
              Text('История запросов:', style: AppText.text12b),
            const Gap(20),
            ...hystoryZapAds
                .map(
                  (item) => GestureDetector(
                    onTap: () => goSearch(item, false),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        item,
                        style: AppText.text12r,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                )
                .toList(),
            const Gap(10),
            if (hystoryZapAds.isNotEmpty)
              GestureDetector(
                onTap: () {
                  hystoryZapAds = [];
                  Get.find<MainRepository>().hystoryZapAds = [];
                  Get.find<MainRepository>().saveListToLocal(
                    LocalDataKey.hystoryZapAds,
                  );
                  setState(() {});
                },
                child: Center(
                  child: AppText.textUnder('Очистить историю поиска',
                      isSearch: true),
                ),
              ),
            const Gap(70),
          ],
        ),
      ),
    );
  }
}
