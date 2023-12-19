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
