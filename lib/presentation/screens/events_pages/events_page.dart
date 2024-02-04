import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/events.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/events_pages/add_events_done.dart';
import 'package:librarychuv/presentation/screens/events_pages/delete_events_done.dart';
import 'package:librarychuv/presentation/screens/events_pages/item_event.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';

/// страница одного объявления
class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    EventsLib item = Get.find<MainBloc>().state.chooseItem as EventsLib;
    bool isInMyEvents = Get.find<MainRepository>()
            .myEvents
            .firstWhereOrNull((element) => element.id == item.id) !=
        null;
    return Container(
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height - 120,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: AppColor.fon,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: EventItem(item: item, isOne: true),
          ),
          Positioned(
            bottom: 100,
            child: Center(
              child: Container(
                alignment: Alignment.topCenter,
                width: context.mediaQuerySize.width - 20,
                child: isInMyEvents
                    ? Buttons.buttonOut(
                        onPressed: () async {
                          Get.find<MainRepository>().deleteMyEvents(item);
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const DeleteEventDone());
                          Get.find<MainBloc>().add(DeletePageEvent());
                        },
                        text: 'Удалить из календаря')
                    : Buttons.buttonFull(
                        onPressed: () async {
                          Get.find<MainRepository>().addMyEvents(item);
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const AddEventDone());
                          Get.find<MainBloc>().add(DeletePageEvent());
                        },
                        text: 'Добавить в календарь'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
