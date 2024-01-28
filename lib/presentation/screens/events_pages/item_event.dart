import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/common/utils.dart';
import 'package:librarychuv/domain/models/events.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/events_pages/widgets.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/screens/main/pages.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/card.dart';

/// карточка события
class EventItem extends StatelessWidget {
  final EventsLib item;
  final bool isOne;
  const EventItem({required this.item, this.isOne = false, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isInMyEvents = Get.find<MainRepository>()
            .myEvents
            .firstWhereOrNull((element) => element.id == item.id) !=
        null;
    return GestureDetector(
      onTap: () => isOne
          ? null
          : Get.find<MainBloc>().add(
              AddPageEvent(typePage: SecondPageType.events, items: [item])),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 13),
        child: Stack(
          children: [
            RoundedCardWidget(
              isFix: false,
              pathImage: item.pathImage,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Utils.getFormatDateFullWithHour(item.date),
                        style: isOne ? AppText.text16rCom : AppText.text16gCom,
                      ),
                      const Gap(10),
                      isOne
                          ? Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset('assets/svg/map_point.svg',
                                      width: 12),
                                  const Gap(5),
                                  Expanded(
                                    child: Text(
                                      item.adress,
                                      maxLines: 3,
                                      softWrap: true,
                                      style: AppText.text16rCom,
                                      // overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ItemEventsType(item: item),
                    ],
                  ),
                  const Gap(10),
                  Text(
                    item.name,
                    style: AppText.text16g.copyWith(
                        fontWeight: FontWeight.normal,
                        color: AppColor.blackText),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(10),
                  Text(
                    item.description,
                    style: AppText.text12g,
                    maxLines: isOne ? 100 : 3,
                    overflow:
                        isOne ? TextOverflow.visible : TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (isInMyEvents)
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(
                    color: AppColor.redMain,
                    borderRadius: AppDif.borderRadius30,
                  ),
                  child: Text(
                    'В календаре',
                    style: AppText.text12b.copyWith(color: AppColor.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
