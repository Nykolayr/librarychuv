import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:librarychuv/data/local_data.dart';
import 'package:librarychuv/domain/models/events.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc() : super(EventsState.initial()) {
    on<LoadNewsEvent>(_onLoadNewsEvent);
    on<LoadNewsSearchEvent>(_onLoadNewsSearchEvent);
    on<AddSearchTextEvent>(_onAddSearchEvent);
    on<ClearSearchEvent>(_onClearSearchEvent);
  }

  void _onAddSearchEvent(AddSearchTextEvent event, Emitter<EventsState> emit) {
    emit(state.copyWith(searchText: event.searchText));
  }

  void _onClearSearchEvent(ClearSearchEvent event, Emitter<EventsState> emit) {
    emit(state.copyWith(searchText: ''));
  }

  void _onLoadNewsEvent(LoadNewsEvent event, Emitter<EventsState> emit) async {
    if (state.events.isLastPage) return;
    emit(state.copyWith(isLoading: true, error: ''));
    String answer = await Get.find<MainRepository>().loadListApi(
        LocalDataKey.events,
        page: state.events.pagination.currentPage + 1);
    emit(state.copyWith(isLoading: false));
    if (answer.isEmpty) {
      EventsLibPage events = Get.find<MainRepository>().events;
      emit(state.copyWith(events: events, filteredList: events.events));
    } else {
      emit(state.copyWith(error: answer));
    }
  }

  void _onLoadNewsSearchEvent(
      LoadNewsSearchEvent event, Emitter<EventsState> emit) async {
    if (state.searchEvents.isLastPage) return;
    emit(state.copyWith(isLoading: true));
    String answer = await Get.find<MainRepository>().loadListApi(
        LocalDataKey.searchEvents,
        page: state.searchEvents.pagination.currentPage + 1,
        search: state.searchText);
    emit(state.copyWith(isLoading: false));
    if (answer.isEmpty) {
      EventsLibPage searchEvents = Get.find<MainRepository>().searchEvents;
      if (searchEvents.events.isNotEmpty) {
        emit(state.copyWith(searchEvents: searchEvents));
      } else {
        emit(state.copyWith(error: 'Ничего не найдено'));
      }
    } else {
      emit(state.copyWith(error: answer));
    }
  }
}
