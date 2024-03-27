import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:librarychuv/data/local_data.dart';
import 'package:librarychuv/domain/models/events.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/events_pages/bloc/bloc/events_bloc.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/screens/main/pages.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';
import 'package:librarychuv/presentation/widgets/search.dart';

/// страница поиска событий
class EventsSearchPage extends StatefulWidget {
  const EventsSearchPage({Key? key}) : super(key: key);

  @override
  State<EventsSearchPage> createState() => _EventsSearchPageState();
}

class _EventsSearchPageState extends State<EventsSearchPage> {
  TextEditingController searchController = TextEditingController();
  MainBloc bloc = Get.find<MainBloc>();
  EventsBloc eventsBloc = Get.find<EventsBloc>();
  List<String> hystoryZapEvents = Get.find<MainRepository>().hystoryZapEvents;
  List<EventsLib> events = Get.find<MainRepository>().events.events;

  goSearch(String text, isSearch) {
    Get.find<MainRepository>().searchEvents.events.clear();
    Get.find<MainRepository>().searchEvents.pagination.currentPage = 0;
    eventsBloc.add(AddSearchTextEvent(searchText: text));
    eventsBloc.add(LoadNewsSearchEvent());
    if (isSearch && !hystoryZapEvents.contains(searchController.text)) {
      hystoryZapEvents.add(searchController.text);
      Get.find<MainRepository>().saveListToLocal(
        LocalDataKey.hystoryZapEvents,
      );
      searchController.text = '';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      bloc: eventsBloc,
      buildWhen: (previous, current) {
        if (previous.searchEvents != current.searchEvents) {
          if (current.searchEvents.events.isNotEmpty) {
            Get.find<MainBloc>().add(AddPageEvent(
                typePage: SecondPageType.resultSearchEvents,
                items: current.searchEvents.events));
          }
        }
        return true;
      },
      builder: (context, state) => Stack(
        children: [
          Container(
            width: context.mediaQuerySize.width,
            height: context.mediaQuerySize.height - 120,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: AppColor.white,
              borderRadius: AppDif.borderRadius10,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  Text('Чувашские символы для поиска: Ӑ ӑ Ӗ ӗ Ӳ ӳ Ҫ ҫ',
                      style: AppText.text12b),
                  const Gap(15),
                  SearchFieldHelp(
                    searchController: searchController,
                  ),
                  const Gap(15),
                  if (state.error.isNotEmpty)
                    Text('Ничего не найдено', style: AppText.text12r),
                  if (state.error.isNotEmpty) const Gap(15),
                  Buttons.buttonFull(
                      onPressed: () {
                        if (searchController.text.isNotEmpty) {
                          goSearch(searchController.text, true);
                        }
                      },
                      text: 'Искать событие'),
                  const Gap(20),
                  if (hystoryZapEvents.isNotEmpty)
                    Text('История запросов:', style: AppText.text12b),
                  const Gap(20),
                  ...hystoryZapEvents
                      .map(
                        (item) => GestureDetector(
                          onTap: () => goSearch(item, false),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              item,
                              style: AppText.text12r,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  const Gap(10),
                  if (hystoryZapEvents.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        hystoryZapEvents = [];
                        Get.find<MainRepository>().hystoryZapNews = [];
                        Get.find<MainRepository>().saveListToLocal(
                          LocalDataKey.hystoryZapNews,
                        );
                        setState(() {});
                      },
                      child: Center(
                        child: AppText.textUnder('Очистить историю поиска',
                            isSearch: true),
                      ),
                    ),
                  const Gap(70),
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
