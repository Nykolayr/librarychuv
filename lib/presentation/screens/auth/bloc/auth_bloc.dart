import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<AuthUserEvent>(_onAuthEvent);
  }

  Future<void> _onAuthEvent(
      AuthUserEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    final answer = await Get.find<UserRepository>()
        .authUser(login: event.login, pass: event.pass);
    emit(state.copyWith(isLoading: false));

    if (answer) {
      emit(state.copyWith(isAuth: true));
    }
    emit(state.copyWith(isAuth: false));
  }
}
