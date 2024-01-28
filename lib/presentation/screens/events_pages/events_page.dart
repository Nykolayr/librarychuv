import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/events.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/events_pages/item_event.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';

/// страница событий
class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  ScrollController controller = ScrollController();
  int indexEvents = 0;
  List<EventsLib> events = Get.find<MainRepository>().events;
  List<EventsLib> filteredList = Get.find<MainRepository>().events;
  TypeEvents type = TypeEvents.all;

  /// нажатие на кнопку выбора типа события
  void changePage(int index) {
    controller.animateTo(
      index * 60,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    indexEvents = index;
    type = TypeEvents.values[index];
    filteredList = type == TypeEvents.all
        ? events
        : events.where((event) => event.type == type).toList();
    setState(() {});
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
          const Gap(10),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 200,
            child: SingleChildScrollView(
              child: Column(
                children: [
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
