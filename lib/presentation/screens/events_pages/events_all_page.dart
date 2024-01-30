import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/common/utils.dart';
import 'package:librarychuv/domain/models/events.dart';
import 'package:librarychuv/domain/models/my_events.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/events_pages/calendar_events.dart';
import 'package:librarychuv/presentation/screens/events_pages/event_date_show.dart';
import 'package:librarychuv/presentation/screens/events_pages/item_event.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';

/// страница событий
class EventsAllPage extends StatefulWidget {
  const EventsAllPage({Key? key}) : super(key: key);

  @override
  State<EventsAllPage> createState() => _EventsAllPageState();
}

class _EventsAllPageState extends State<EventsAllPage> {
  bool isMyEvents = false;
  ScrollController controller = ScrollController();
  int indexEvents = 0;
  List<EventsLib> events = Get.find<MainRepository>().events;
  List<MyEvents> myEvents = Get.find<MainRepository>().myEvents;
  List<EventsLib> filteredList = Get.find<MainRepository>().events;
  MainBloc bloc = Get.find<MainBloc>();
  TypeEvents type = TypeEvents.all;
  EventsLib nearestEvents = EventsLib.initial();

  /// получаем ближайшее событие
  void findNearestEvent() {
    nearestEvents = EventsLib.initial();
    DateTime now = DateTime.now();
    filteredList.sort((a, b) => a.date.compareTo(b.date));

    for (int i = 0; i < filteredList.length; i++) {
      if (filteredList[i].date.isAfter(now) ||
          filteredList[i].date.isAtSameMomentAs(now)) {
        nearestEvents = filteredList[i];
        break;
      }
    }
    setState(() {});
  }

  /// нажатие на кнопку выбора типа события
  void changePage(int index) {
    controller.animateTo(
      index * 60,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    indexEvents = index;
    type = TypeEvents.values[index];
    setFilter(isMyEvents);
  }

  /// переключение между моими и всеми событиями
  setFilter(bool isMyEvents) {
    this.isMyEvents = isMyEvents;
    filteredList = type == TypeEvents.all
        ? events
        : events.where((event) => event.type == type).toList();
    if (isMyEvents) {
      bloc.add(const AddPageNameEvent(tempNamePage: 'Мои события'));
      filteredList = filteredList
          .where((event) =>
              myEvents.any((myEvent) => myEvent.event.id == event.id))
          .toList();
    } else {
      bloc.add(const AddPageNameEvent(tempNamePage: ''));
    }

    findNearestEvent();
  }

  @override
  initState() {
    findNearestEvent();
    super.initState();
  }

  @override
  dispose() {
    controller.dispose();
    bloc.add(const AddPageNameEvent(tempNamePage: ''));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height - 120,
      color: AppColor.fon,
      child: Column(
        children: [
          SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  for (int k = 0; k < TypeEvents.values.length; k++)
                    ButtonRow(
                      text: TypeEvents.values[k].title,
                      onPressed: () {
                        changePage(k);
                      },
                      isTransporant: k != indexEvents,
                    ),
                ],
              ),
            ),
          ),
          if (nearestEvents != EventsLib.initial() && filteredList.isNotEmpty)
            EventDateShow(event: nearestEvents),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 200,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (filteredList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ButtonSelfWithIcon(
                            width: MediaQuery.of(context).size.width / 2 - 12,
                            text: Utils.getMonthYear(nearestEvents.date),
                            pathImage: 'assets/svg/events.svg',
                            onPressed: () async {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return CalendarEvents(events: filteredList);
                                },
                              );
                            },
                          ),
                          ButtonSelfWithIcon(
                            width: MediaQuery.of(context).size.width / 2 - 12,
                            text:
                                isMyEvents ? 'Все мероприятия' : 'Moи события',
                            pathImage: 'assets/svg/myevents.svg',
                            onPressed: () => setFilter(!isMyEvents),
                          ),
                        ],
                      ),
                    ),
                  if (filteredList.isEmpty) ...[
                    const Gap(200),
                    Center(
                      child: Text('В разделе "${type.title}" пока нет событий'),
                    ),
                  ] else
                    ...filteredList
                        .map((event) => EventItem(item: event))
                        .toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
