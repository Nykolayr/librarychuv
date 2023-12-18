part of 'auth_bloc.dart';

class AuthState {
  final String pass;
  final String login;
  final bool isSucsess;
  final bool isLoading;

  const AuthState({
    required this.pass,
    required this.isSucsess,
    required this.isLoading,
    required this.login,
  });

  factory AuthState.initial() => const AuthState(
        pass: '',
        isSucsess: false,
        isLoading: false,
        login: '',
      );
  AuthState copyWith({
    String? pass,
    String? login,
    bool? isSucsess,
    bool? isLoading,
  }) {
    return AuthState(
      pass: pass ?? this.pass,
      login: login ?? this.login,
      isSucsess: isSucsess ?? this.isSucsess,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
