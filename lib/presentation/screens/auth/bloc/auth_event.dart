part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final String login;

  const AuthLoginEvent({required this.login});
}

class AuthPassEvent extends AuthEvent {
  final String pass;

  const AuthPassEvent({required this.pass});
}
