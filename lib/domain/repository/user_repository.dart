// ignore_for_file: avoid_catches_without_on_clauses

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:librarychuv/data/api/api.dart';
import 'package:librarychuv/data/api/response_api.dart';
import 'package:librarychuv/data/local_data.dart';
import 'package:librarychuv/domain/models/user.dart';

/// репо для юзера
class UserRepository extends GetxController {
  User user = User.initial();
  String get token => user.token;
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
    await loadUserFromLocal();
  }

  /// загрузка фото пользователя на сервер
  Future upLoadImage(XFile image) async {
    // List<int> imageBytes = await image.readAsBytes();
    /// имитация сохранение на сервере
    await Future.delayed(const Duration(seconds: 1));
    await saveUserToLocal();
  }

  /// обновление пароля
  Future updatePass() async {
    /// имитация сохранение на сервере
    await Future.delayed(const Duration(seconds: 1));
    await saveUserToLocal();
  }

  /// сохранение пользователя
  Future saveUser() async {
    /// имитация сохранение на сервере
    await Future.delayed(const Duration(seconds: 1));
    await saveUserToLocal();
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
    final answer = await Api().authUser(
      login: email,
      pass: password,
    );
    if (answer is ResSuccess) {
      user = User.fromJson(answer.data);
      await saveUserToLocal();
      return '';
    } else if (answer is ResError) {
      return answer.errorMessage;
    }
    return '';
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
