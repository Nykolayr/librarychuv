part of 'events_bloc.dart';

class EventsState {
  final String error;
  final bool isLoading;
  final EventsLibPage events;
  final List<EventsLib> filteredList;
  final EventsLibPage searchEvents;
  final String searchText;

  const EventsState({
    required this.error,
    required this.isLoading,
    required this.events,
    required this.filteredList,
    required this.searchEvents,
    required this.searchText,
  });

  factory EventsState.initial() => EventsState(
        error: '',
        isLoading: false,
        events: Get.find<MainRepository>().events,
        filteredList: Get.find<MainRepository>().events.events,
        searchEvents: EventsLibPage.init(),
        searchText: '',
      );

  EventsState copyWith({
    String? error,
    bool? isLoading,
    EventsLibPage? events,
    List<EventsLib>? filteredList,
    EventsLibPage? searchEvents,
    String? searchText,
  }) {
    return EventsState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      events: events ?? this.events,
      filteredList: filteredList ?? this.filteredList,
      searchEvents: searchEvents ?? this.searchEvents,
      searchText: searchText ?? this.searchText,
    );
  }
}
