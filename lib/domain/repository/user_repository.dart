// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:convert';

import 'package:get/get.dart';
import 'package:librarychuv/data/api.dart';
import 'package:librarychuv/data/local_data.dart';
import 'package:librarychuv/domain/models/user.dart';
import 'package:surf_logger/surf_logger.dart';

class UserRepository extends GetxController {
  User user = User.initial();

  static final UserRepository _instance = UserRepository._internal();

  UserRepository._internal();

  factory UserRepository() {
    // LocalData().clear();
    _instance.loadUserFromLocal();

    return _instance;
  }

  Future<bool> deleteUser() async {
    return false;
  }

  Future<bool> getUser() async {
    return false;
  }

  Future<bool> authUser({
    required String login,
    required String pass,
  }) async {
    final answer = await Api().postAuthUser(
      login: login,
      pass: pass,
    );
    if (answer != null) {
      user = user.copyWith(
        token: answer['access'].toString(),
        refresh: answer['refresh'].toString(),
      );
      return getUser();
    } else {
      return false;
    }
  }

  Future<bool> userEdit() async {
    return false;
  }

  Future<void> loadUserFromLocal() async {
    final data = await LocalData().loadJsonUser();
    if (data.isNotEmpty) {
      try {
        final json = jsonDecode(data) as Map<String, dynamic>;
        user = User.fromJson(json);
      } catch (e) {
        Logger.d('ошибка загрузки юзера из локалки ==$e');
      }
    } else {
      await saveUserToLocal();
    }
  }

  Future<void> saveUserToLocal() async {
    await LocalData().saveJsonUser(user.toJson());
  }
}
