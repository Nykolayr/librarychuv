part of 'events_bloc.dart';

sealed class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => [];
}

class LoadNewsEvent extends EventsEvent {}

class LoadNewsSearchEvent extends EventsEvent {}

class AddSearchTextEvent extends EventsEvent {
  final String searchText;
  const AddSearchTextEvent({required this.searchText});
}

class ClearSearchEvent extends EventsEvent {}
