import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/events.dart';
import 'package:librarychuv/presentation/screens/events_pages/item_event.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// страница одного объявления
class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height - 120,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: AppColor.fon,
      child: SingleChildScrollView(
        child: EventItem(
            item: Get.find<MainBloc>().state.items.first as EventsLib,
            isOne: true),
      ),
    );
  }
}
