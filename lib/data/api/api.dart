import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:get/get.dart';
import 'package:librarychuv/common/constants.dart';
import 'package:librarychuv/data/api/response_api.dart';
import 'package:librarychuv/data/local_data.dart';
import 'package:dio/dio.dart' as form;

import 'dio_client.dart';

class Api {
  final DioClient dio = Get.find<DioClient>();

  /// загрузка  списка новостей,
  Future<ResponseApi> getListApi(LocalDataKey key, int page) async {
    final path = '${key.url}$page&token=$token';
    Logger.e('loadListApi ${key.name} $page == $path');
    return await dio.get(path);
  }

  /// загрузка  списка для MainRepository,
  Future<ResponseApi> getListMainRepository(LocalDataKey key) async {
    final path = '/${key.name}/';
    return await dio.get(path);
  }

  /// авторизация по логину и паролю
  Future<ResponseApi> authUser(
      {required String login, required String pass}) async {
    form.FormData formData = form.FormData.fromMap({
      'login': login,
      'password': pass,
    });

    const path = '/check_auth.php?token=$token';
    return await dio.post(path, data: formData);
  }
}
