// ignore_for_file: avoid_catches_without_on_clauses

import 'package:get/get.dart';
import 'package:librarychuv/data/api.dart';
import 'package:librarychuv/data/local_data.dart';
import 'package:librarychuv/data/mock/user_mock.dart';
import 'package:librarychuv/domain/models/user.dart';
import 'package:librarychuv/main.dart';

/// репо для юзера
class UserRepository extends GetxController {
  User user = User.initial();

  static final UserRepository _instance = UserRepository._internal();

  UserRepository._internal();

  factory UserRepository() => _instance;

  Future<bool> deleteUser() async {
    return false;
  }

  Future<bool> getUser() async {
    return false;
  }

  /// Начальная загрузка пользователя из локального хранилища
  Future init() async {
    // LocalData().clear();
    await loadUserFromLocal();
  }

  /// Удаление пользователя из локального хранилища и инициализация
  Future clearUser() async {
    await LocalData().clear();
    user = User.initial();
  }

  /// авторизация по логину и паролю, возвращает строку ошибки,
  /// если ошибки нет возвращается пустая строка
  Future<String> authUser({
    required String email,
    required String password,
  }) async {
    if (isMock) {
      await Future.delayed(const Duration(seconds: 1));
      Map<String, dynamic> userAuth = {};
      for (Map<String, dynamic> item in userMock) {
        if (item['password'] == password && item['email'] == email) {
          userAuth = item;
          break;
        }
      }
      if (userAuth.isEmpty) {
        return 'Неверный логин или пароль';
      } else {
        user = User.fromJson(userAuth);
        await saveUserToLocal();
        return '';
      }
    } else {
      final answer = await Api().authUser(
        login: email,
        pass: password,
      );
      if (answer['error'] == null) {
        user = User.fromJson(answer);
        return '';
      } else {
        return answer['error'];
      }
    }
  }

  Future<bool> userEdit() async {
    return false;
  }

  Future<void> loadUserFromLocal() async {
    final data = await LocalData.loadJson(key: LocalDataKey.user);
    if (data['error'] == null) {
      user = User.fromJson(data);
    } else {
      await saveUserToLocal();
    }
  }

  Future<void> saveUserToLocal() async {
    await LocalData.saveJson(json: user.toJson(), key: LocalDataKey.user);
  }
}
