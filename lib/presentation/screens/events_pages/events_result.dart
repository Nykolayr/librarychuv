import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/screens/events_pages/bloc/bloc/events_bloc.dart';
import 'package:librarychuv/presentation/screens/events_pages/item_event.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// страница результата поиска событий
class EventsResultSearchPage extends StatefulWidget {
  const EventsResultSearchPage({Key? key}) : super(key: key);

  @override
  State<EventsResultSearchPage> createState() => EventsResultSearchPageState();
}

class EventsResultSearchPageState extends State<EventsResultSearchPage> {
  bool isNext = true;
  final ScrollController scrollController = ScrollController();
  EventsBloc eventsBloc = Get.find<EventsBloc>();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.position.extentAfter < 500) {
      if (isNext) {
        eventsBloc.add(LoadNewsSearchEvent());
        isNext = false;
        Future.delayed(const Duration(seconds: 2), () {
          isNext = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      bloc: eventsBloc,
      builder: (context, state) => Stack(
        children: [
          Container(
            width: context.mediaQuerySize.width,
            height: context.mediaQuerySize.height - 120,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: AppColor.fon,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...state.searchEvents.events
                      .map(
                        (item) => EventItem(item: item),
                      )
                      .toList()
                ],
              ),
            ),
          ),
          if (state.isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
