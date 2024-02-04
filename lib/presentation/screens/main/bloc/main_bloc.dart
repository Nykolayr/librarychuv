import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/abstract.dart';
import 'package:librarychuv/domain/models/books.dart';
import 'package:librarychuv/domain/models/region.dart';
import 'package:librarychuv/domain/models/libriry.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/main/pages.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState.initial()) {
    on<AddPageEvent>(_onAddPageEvent);
    on<DeletePageEvent>(_onDeletePageEvent);
    on<AddDropEvent>(_onAddDropEvent);
    on<AddSearchEvent>(_onAddSearchEvent);
    on<AddIsSearchEvent>(_onAddIsSearchEvent);
    on<SortDropEvent>(_onSortDropEvent);
    on<SortSearchEvent>(_onSortSearchEvent);
    on<ShooseLibriryEvent>(_onShooseLibriryEvent);
    on<AddPageNameEvent>(_onAddPageNameEvent);
    on<AddChooseItemEvent>(_onAddChooseItemEvent);
  }

  Future<void> _onAddChooseItemEvent(
      AddChooseItemEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(chooseItem: event.item));
  }

  Future<void> _onAddPageNameEvent(
      AddPageNameEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(tempNamePage: event.tempNamePage));
  }

  Future<void> _onShooseLibriryEvent(
      ShooseLibriryEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(curLibriryId: event.index));
  }

  Future<void> _onSortSearchEvent(
      SortSearchEvent event, Emitter<MainState> emit) async {
    List<Libriry> tempSearch = Get.find<MainRepository>().libriries;
    if (event.item.isNotEmpty) {
      try {
        tempSearch = Get.find<MainRepository>()
            .libriries
            .where((element) =>
                element.name.toLowerCase().contains(event.item.toLowerCase()))
            .toList();
      } on StateError {
        tempSearch = [];
      }
    }
    emit(state.copyWith(
      searchLibriryItems: tempSearch,
      isSearch: event.isSearch,
      curLibriryId: -1,
    ));
  }

  Future<void> _onSortDropEvent(
      SortDropEvent event, Emitter<MainState> emit) async {
    List<Libriry> tempSearch = Get.find<MainRepository>().libriries;
    if (event.item.isNotEmpty) {
      try {
        tempSearch = Get.find<MainRepository>()
            .libriries
            .where((element) =>
                element.region.toLowerCase().contains(event.item.toLowerCase()))
            .toList();
      } on StateError {
        tempSearch = [];
      }
    }
    emit(state.copyWith(
      searchLibriryItems: tempSearch,
      curLibriryId: -1,
    ));
  }

  Future<void> _onDeletePageEvent(
      DeletePageEvent event, Emitter<MainState> emit) async {
    List<SecondPageType> typePages = state.typePages;
    if (typePages.isNotEmpty) typePages.removeLast();
    emit(state.copyWith(typePages: typePages, appBarTitle: ''));
  }

  Future<void> _onAddPageEvent(
      AddPageEvent event, Emitter<MainState> emit) async {
    List<SecondPageType> typePages = state.typePages;
    typePages.add(event.typePage);
    emit(state.copyWith(
        typePages: typePages,
        items: event.items,
        chooseItem: event.chooseItem));
  }

  Future<void> _onAddDropEvent(
      AddDropEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(dropItems: event.dropItems, curLibriryId: -1));
  }

  Future<void> _onAddSearchEvent(
      AddSearchEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(
        searchLibriryItems: event.searchItems, curLibriryId: -1));
  }

  Future<void> _onAddIsSearchEvent(
      AddIsSearchEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(isSearch: event.isSearch, curLibriryId: -1));
  }
}
