part of 'news_bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class LoadNewsEvent extends NewsEvent {}

class LoadNewsSearchEvent extends NewsEvent {}

class AddSearchTextEvent extends NewsEvent {
  final String searchText;
  const AddSearchTextEvent({required this.searchText});
}

class ClearSearchEvent extends NewsEvent {}
