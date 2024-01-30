import 'package:flutter/material.dart';
import 'package:librarychuv/common/utils.dart';
import 'package:librarychuv/domain/models/events.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// тип события в карточке события
class ItemEventsType extends StatelessWidget {
  final EventsLib item;
  const ItemEventsType({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: AppDif.borderRadius20,
        border: AppDif.borderSearcch,
      ),
      child: Center(
        child: Text(item.type.title, style: AppText.text12g),
      ),
    );
  }
}

/// Upcoming event
class UpcomingEvent extends StatelessWidget {
  final EventsLib item;
  const UpcomingEvent({required this.item, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: AppDif.borderRadius20,
        border: AppDif.borderSearcch,
        color: Colors.white,
      ),
      child: Center(
        child: Text(item.type.title, style: AppText.text12g),
      ),
    );
  }
}

/// дата и часы в контейнерах
class DateHourInRounted extends StatelessWidget {
  final DateTime date;
  const DateHourInRounted({required this.date, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StringInRountedContainer(text: Utils.getDate(date)),
        StringInRountedContainer(text: Utils.getHour(date)),
      ],
    );
  }
}

/// даты в округленном контейнере
class StringInRountedContainer extends StatelessWidget {
  final String text;
  const StringInRountedContainer({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        color: AppColor.fon,
        borderRadius: AppDif.borderRadius30,
      ),
      child: Text(text, style: AppText.text12g),
    );
  }
}
