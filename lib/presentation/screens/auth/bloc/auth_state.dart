part of 'auth_bloc.dart';

class AuthState {
  final String phone;
  final String pass;
  final String code;
  final String error;
  final String id;
  final DateTime next;
  final bool isSucsess;
  final bool isRecovery;
  final bool isAuth;
  final bool isLoading;

  const AuthState({
    required this.phone,
    required this.pass,
    required this.code,
    required this.error,
    required this.id,
    required this.next,
    required this.isSucsess,
    required this.isRecovery,
    required this.isLoading,
    required this.isAuth,
  });

  factory AuthState.initial() => AuthState(
        phone: '',
        pass: '',
        code: '',
        error: '',
        id: '',
        next: DateTime.now(),
        isSucsess: false,
        isRecovery: false,
        isLoading: false,
        isAuth: false,
      );
  AuthState copyWith({
    String? phone,
    String? pass,
    String? code,
    String? error,
    String? id,
    DateTime? next,
    bool? isSucsess,
    bool? isRecovery,
    bool? isLoading,
    bool? isAuth,
  }) {
    return AuthState(
      phone: phone ?? this.phone,
      pass: pass ?? this.pass,
      code: code ?? this.code,
      error: error ?? this.error,
      id: id ?? this.id,
      next: next ?? this.next,
      isSucsess: isSucsess ?? this.isSucsess,
      isRecovery: isRecovery ?? this.isRecovery,
      isLoading: isLoading ?? this.isLoading,
      isAuth: isAuth ?? this.isAuth,
    );
  }
}
