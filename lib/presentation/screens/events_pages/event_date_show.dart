import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/events.dart';
import 'package:librarychuv/presentation/screens/events_pages/widgets.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

class EventDateShow extends StatelessWidget {
  final EventsLib event;
  const EventDateShow({required this.event, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: context.mediaQuerySize.width,
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        color: AppColor.creamy,
        borderRadius: AppDif.borderRadius10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.name,
            overflow: TextOverflow.ellipsis,
            style: AppText.text12b.copyWith(fontWeight: FontWeight.w600),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            DateHourInRounted(date: event.date),
            Text(
              'Предстоящее событие',
              style: AppText.text12r,
            ),
          ]),
        ],
      ),
    );
  }
}
