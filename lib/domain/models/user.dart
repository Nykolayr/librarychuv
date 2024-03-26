import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:intl/intl.dart';
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
  factory User.fromJson(Map<String, dynamic> data) {
    Logger.w('data == $data');
    DateFormat formatter = DateFormat('dd.MM.yyyy');
    return User(
      id: data['ID'] ?? '',
      email: data['LOGIN'] ?? '',
      password: data['password'] ?? '',
      token: data['token'] ?? 'test',
      firstName: data['NAME'] ?? '',
      lastName: data['LAST_NAME'] ?? '',
      pathImage: data['pathImage'] ?? '',
      birthDate: data['PERSONAL_BIRTHDAY'] == null
          ? DateTime.now()
          : formatter.parse(data['PERSONAL_BIRTHDAY']),
      role: data['role'] ?? '',
      ticket: data['ticket'] == null
          ? Ticket.initial()
          : Ticket.fromJson(data['ticket']),
      ticketDate: data['ticketDate'] == null
          ? DateTime.now()
          : DateTime.parse(data['ticketDate']),
    );
  }

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
