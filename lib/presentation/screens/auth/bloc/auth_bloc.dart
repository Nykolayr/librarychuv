import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<AuthLoginEvent>(_onAuthLoginEvent);
    on<AuthPassEvent>(_onPassEvent);
  }

  Future<void> _onAuthLoginEvent(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(login: event.login, error: ''));
  }

  Future<void> _onPassEvent(
      AuthPassEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, error: ''));
    final answer = await Get.find<UserRepository>()
        .authUser(email: state.login, password: event.pass);
    emit(state.copyWith(
      isLoading: false,
    ));
    if (answer.isEmpty) {
      emit(state.copyWith(isSucsess: true));
    } else {
      emit(state.copyWith(error: answer));
    }
  }
}
