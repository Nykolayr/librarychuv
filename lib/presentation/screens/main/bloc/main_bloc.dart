import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/gerion.dart';
import 'package:librarychuv/domain/models/libriry.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState.initial()) {
    on<AddPageEvent>(_onAddPageEvent);
    on<ClearPageEvent>(_onClearPageEvent);
    on<AddDropEvent>(_onAddDropEvent);
    on<AddSearchEvent>(_onAddSearchEvent);
    on<AddIsSearchEvent>(_onAddIsSearchEvent);
    on<SortDropEvent>(_onSortDropEvent);
    on<SortSearchEvent>(_onSortSearchEvent);
    on<ShooseLibriryEvent>(_onShooseLibriryEvent);
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

  Future<void> _onClearPageEvent(
      ClearPageEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(page: null, isPage: false));
  }

  Future<void> _onAddPageEvent(
      AddPageEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(page: event.page, isPage: true));
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
