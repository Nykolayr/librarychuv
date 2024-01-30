import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:librarychuv/domain/models/events.dart';
import 'package:librarychuv/presentation/screens/events_pages/event_date_show.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarEvents extends StatefulWidget {
  final List<EventsLib> events;

  const CalendarEvents({Key? key, required this.events}) : super(key: key);

  @override
  CalendarEventsState createState() => CalendarEventsState();
}

class CalendarEventsState extends State<CalendarEvents> {
  EventsLib nearestEvents = EventsLib.initial();
  DateTime date = DateTime.now();
  List<EventsLib> selectedEvents = [];
  DateTime selectedDay = DateTime.now();

  /// получаем ближайшее событие
  void findNearestEvent() {
    nearestEvents = EventsLib.initial();
    DateTime now = DateTime.now();
    widget.events.sort((a, b) => a.date.compareTo(b.date));

    for (int i = 0; i < widget.events.length; i++) {
      if (widget.events[i].date.isAfter(now) ||
          widget.events[i].date.isAtSameMomentAs(now)) {
        nearestEvents = widget.events[i];
        break;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    findNearestEvent();
    selectedDay = nearestEvents.date;
    getEventsForDay(selectedDay);
    super.initState();
  }

  List<EventsLib> getEventsForDay(DateTime day) {
    selectedEvents =
        widget.events.where((event) => _isSameDay(event.date, day)).toList();

    return selectedEvents;
  }

  void onDaySelected(DateTime selectDay, DateTime focusDay) {
    selectedDay = selectDay;
    getEventsForDay(selectDay);

    setState(() {});
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 200,
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(10),
            Text('События которые будут проходить в этом месяце',
                style: AppText.captionText14r),
            const Gap(5),
            TableCalendar(
              locale: 'ru',
              availableCalendarFormats: const {
                CalendarFormat.month: 'месяц',
                CalendarFormat.week: 'все события',
              },
              selectedDayPredicate: (day) {
                return selectedDay.year == day.year &&
                    selectedDay.month == day.month &&
                    selectedDay.day == day.day;
              },
              calendarFormat: CalendarFormat.month,
              currentDay: selectedDay,
              focusedDay: selectedDay,
              firstDay: DateTime.utc(date.year, date.month, 1),
              lastDay: DateTime.utc(date.year, date.month + 24, 0),
              eventLoader: getEventsForDay,
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: AppColor.green,
                  shape: BoxShape.circle,
                ),
                outsideDaysVisible: true,
              ),
              onDaySelected: onDaySelected,
              calendarBuilders: CalendarBuilders(markerBuilder: (
                context,
                date,
                events,
              ) {
                if (events.isNotEmpty) {
                  return Center(
                    child: Container(
                      width: 32,
                      height: 32,
                      // padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: AppColor.redMain,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(date.day.toString(),
                            style: AppText.text14b
                                .copyWith(color: AppColor.white)),
                      ),
                    ),
                  );
                }
                return null;
              }),
            ),
            const Gap(10),
            for (var item in selectedEvents) EventDateShow(event: item),
          ],
        ),
      ),
    );
  }
}
