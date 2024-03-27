part of 'events_bloc.dart';

class EventsState {
  final String error;
  final bool isLoading;
  final EventsLibPage events;
  final List<EventsLib> filteredList;
  const EventsState({
    required this.error,
    required this.isLoading,
    required this.events,
    required this.filteredList,
  });

  factory EventsState.initial() => EventsState(
        error: '',
        isLoading: false,
        events: Get.find<MainRepository>().events,
        filteredList: Get.find<MainRepository>().events.events,
      );

  EventsState copyWith({
    String? error,
    bool? isLoading,
    EventsLibPage? events,
    List<EventsLib>? filteredList,
  }) {
    return EventsState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      events: events ?? this.events,
      filteredList: filteredList ?? this.filteredList,
    );
  }
}
