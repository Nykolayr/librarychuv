part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

/// обновление первого в списке items
class AddFirstItemEvent extends MainEvent {
  final AllModels item;
  const AddFirstItemEvent({required this.item});
}

/// если нужно изменить название страницы
class AddPageNameEvent extends MainEvent {
  final String tempNamePage;
  const AddPageNameEvent({required this.tempNamePage});
}

/// добавление страниц
class AddPageEvent extends MainEvent {
  final SecondPageType typePage;
  final List<AllModels>? items;
  const AddPageEvent({
    required this.typePage,
    this.items,
  });
}

/// удаление страниц
class DeletePageEvent extends MainEvent {}

/// добавление выпадающего списка
class AddDropEvent extends MainEvent {
  final List<String> dropItems;
  const AddDropEvent({required this.dropItems});
}

/// добавление списка для поиска
class AddSearchEvent extends MainEvent {
  final List<Libriry> searchItems;
  const AddSearchEvent({required this.searchItems});
}

/// добавление состояния поиска
class AddIsSearchEvent extends MainEvent {
  final bool isSearch;
  const AddIsSearchEvent({required this.isSearch});
}

/// сортировка выпадающего списка
class SortDropEvent extends MainEvent {
  final String item;
  const SortDropEvent({required this.item});
}

/// сортировка поиска
class SortSearchEvent extends MainEvent {
  final String item;
  final bool isSearch;
  const SortSearchEvent({required this.item, required this.isSearch});
}

/// выбор библиотеки
class ShooseLibriryEvent extends MainEvent {
  final int index;
  const ShooseLibriryEvent({required this.index});
}
