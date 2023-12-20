part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class AddPageEvent extends MainEvent {
  final Widget page;
  const AddPageEvent({required this.page});
}

class ClearPageEvent extends MainEvent {
  const ClearPageEvent();
}

class AddDropEvent extends MainEvent {
  final List<String> dropItems;
  const AddDropEvent({required this.dropItems});
}

class AddSearchEvent extends MainEvent {
  final List<Libriry> searchItems;
  const AddSearchEvent({required this.searchItems});
}

class AddIsSearchEvent extends MainEvent {
  final bool isSearch;
  const AddIsSearchEvent({required this.isSearch});
}

class SortDropEvent extends MainEvent {
  final String item;
  const SortDropEvent({required this.item});
}

class SortSearchEvent extends MainEvent {
  final String item;
  final bool isSearch;
  const SortSearchEvent({required this.item, required this.isSearch});
}

class ShooseLibriryEvent extends MainEvent {
  final int index;
  const ShooseLibriryEvent({required this.index});
}
