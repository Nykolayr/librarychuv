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
}
