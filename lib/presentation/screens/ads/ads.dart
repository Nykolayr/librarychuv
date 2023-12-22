import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/common/utils.dart';
import 'package:librarychuv/domain/models/abstract.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/screens/main/pages.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/card.dart';

/// карточка ads
class AdsItem extends StatelessWidget {
  final AllModels item;
  final bool isOne;
  const AdsItem({required this.item, this.isOne = false, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isOne
          ? null
          : Get.find<MainBloc>()
              .add(AddPageEvent(typePage: SecondPageType.ads, items: [item])),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 13),
        child: RoundedCardWidget(
          isFix: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.pathImage.isNotEmpty) Image.asset(item.pathImage),
              if (item.pathImage.isNotEmpty) const Gap(10),
              Text(
                Utils.getFormatDateFull(item.date),
                style: AppText.text16gCom,
              ),
              const Gap(10),
              Text(
                item.name,
                style: AppText.text14b.copyWith(fontWeight: FontWeight.normal),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(10),
              Text(
                item.description,
                style: AppText.text12g,
                maxLines: isOne ? 100 : 3,
                overflow: isOne ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
