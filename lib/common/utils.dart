// import 'dart:convert';
// import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class Utils {
  // static String hashPassword(String password) {
  //   var bin = utf8.encode(password);
  //   return sha256.convert(bin).toString();
  // }

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
