// import 'dart:convert';
// import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  // static String hashPassword(String password) {
  //   var bin = utf8.encode(password);
  //   return sha256.convert(bin).toString();
  // }

/// преобразуем из строки вида 30.07.1990 в дату
  static DateTime parseDate(String dateString) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    return formatter.parse(dateString);
  }

  static String getFormatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(date);
  }

  static String getFormatDateFull(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy г.', 'ru');
    return formatter.format(date);
  }

  static String getFormatDateFullWithHour(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy г.  HH:mm', 'ru');
    return formatter.format(date);
  }

  static String getDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy', 'ru');
    return formatter.format(date);
  }

  static String getHour(DateTime date) {
    final DateFormat formatter = DateFormat('HH:mm', 'ru');
    return formatter.format(date);
  }

  static String getMonthYear(DateTime date) {
    final DateFormat formatter = DateFormat('MMMM yyyy', 'ru');
    return formatter.format(date);
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Поле не может быть пустым';
    }

    final errors = <String>[];

    if (!RegExp('^(?=.*?[a-z])').hasMatch(password)) {
      errors.add('Хотя бы 1 строчная буква');
    }

    if (!RegExp('^(?=.*?[A-Z])').hasMatch(password)) {
      errors.add('Хотя бы 1 заглавная буква');
    }

    if (!RegExp('^(?=.*?[0-9])').hasMatch(password)) {
      errors.add('Хотя бы 1 цифра');
    }

    if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(password)) {
      errors.add('Хотя бы 1 символ');
    }

    if (!RegExp(r'^.{8,}$').hasMatch(password)) {
      errors.add('Минимум 8 символов');
    }

    if (errors.isNotEmpty) return 'Требования к паролю:\n${errors.join('\n')}';

    return null;
  }

  static String normalizePhone(String phone) {
    return phone
        .replaceAll(' ', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('-', '')
        .replaceAll('+', '');
  }

  static String? validateNotEmpty(String? value, String message) {
    return (value == null || value.isEmpty) ? message : null;
  }

  static String? validatePhone(String? value, String message) {
    return (value == null || value.isEmpty || value.length != 15)
        ? message
        : null;
  }

  static String? validateEmail(String? value, String message) {
    final re = RegExp(r'.+@.+\..+');
    return (value == null || value.isEmpty || !re.hasMatch(value))
        ? message
        : null;
  }

  static String? validateCompareValues(
      String? value1, String? value2, String message) {
    return (value1 == null ||
            value1.isEmpty ||
            value2 == null ||
            value2.isEmpty ||
            value1 != value2)
        ? message
        : null;
  }

  static Widget circularProgressIndicator() {
    return const Center(child: CircularProgressIndicator());
  }
}
