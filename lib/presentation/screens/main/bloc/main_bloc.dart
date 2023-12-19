import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState.initial()) {
    on<AddPageEvent>(_onAddPageEvent);

    on<ClearPageEvent>(_onClearPageEvent);
  }

  Future<void> _onClearPageEvent(
      ClearPageEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(page: null, isPage: false));
  }

  Future<void> _onAddPageEvent(
      AddPageEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(page: event.page, isPage: true));
  }
}
