import 'package:librarychuv/domain/models/ticker.dart';

class User {
  String id;
  String email;
  String password;
  String token;
  String firstName;
  String lastName;
  String pathImage;
  DateTime birthDate;
  String role;
  DateTime ticketDate;
  Ticket ticket;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.token,
    required this.firstName,
    required this.lastName,
    required this.pathImage,
    required this.birthDate,
    required this.role,
    required this.ticketDate,
    required this.ticket,
  });
  factory User.fromJson(Map<String, dynamic> data) => User(
        id: data['id'] as String,
        email: data['email'] as String,
        password: data['password'] as String,
        token: data['token'] as String,
        firstName: data['firstName'] as String,
        lastName: data['lastName'] as String,
        pathImage: data['pathImage'] as String,
        birthDate: DateTime.parse(data['birthDate'] as String),
        role: data['role'] as String,
        ticket: Ticket.fromJson(data['ticket'] as Map<String, dynamic>),
        ticketDate: DateTime.parse(data['ticketDate'] as String),
      );

  factory User.initial() {
    return User(
      id: '',
      email: '',
      password: '',
      token: '',
      firstName: '',
      lastName: '',
      pathImage: '',
      birthDate: DateTime.now(),
      role: '',
      ticket: Ticket.initial(),
      ticketDate: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'token': token,
      'firstName': firstName,
      'lastName': lastName,
      'pathImage': pathImage,
      'birthDate': birthDate.toIso8601String(),
      'role': role,
      'ticket': ticket.toJson(),
      'ticketDate': ticketDate.toIso8601String(),
    };
  }
}
