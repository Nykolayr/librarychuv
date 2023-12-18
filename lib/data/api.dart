import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, Response;
import 'package:librarychuv/common/constants.dart';
import 'package:librarychuv/domain/routers/routers.dart';
import 'package:surf_logger/surf_logger.dart';

class Api {
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(milliseconds: 30000),
    baseUrl: apiUrl,
    // contentType: ContentType.json.toString(),
  ));

  /// загрузка  списка рекомендаций,
  /// если ошибки нет возвращается  map для user
  Future<List<Map<String, dynamic>>> loadRecomend() async {
    const path = '/recomend/';
    Response<dynamic> response;
    try {
      response = await dio.get(path);
      final body = response.data;
      Logger.w('body $path ==  $body');
      return body;
    } on DioException catch (e) {
      logDioException(e, path);
      return [
        {'error': '$e'}
      ];
    } on Exception catch (e) {
      logSimpleError(e, path);
      return [
        {'error': '$e'}
      ];
    }
  }

  /// загрузка  списка новостей,
  /// если ошибки нет возвращается  map для user
  Future<List<Map<String, dynamic>>> getNews() async {
    const path = '/news/';
    Response<dynamic> response;
    try {
      response = await dio.get(path);
      final body = response.data;
      Logger.w('body $path ==  $body');
      return body;
    } on DioException catch (e) {
      logDioException(e, path);
      return [
        {'error': '$e'}
      ];
    } on Exception catch (e) {
      logSimpleError(e, path);
      return [
        {'error': '$e'}
      ];
    }
  }

  /// авторизация по логину и паролю, возвращает map ошибки,
  /// если ошибки нет возвращается  map для user
  Future<Map<String, dynamic>> authUser(
      {required String login, required String pass}) async {
    const path = '/login/';
    Response<dynamic> response;
    try {
      response = await dio.post(path, data: {
        'email': login,
        'password': pass,
      });
      final body = response.data;
      Logger.w('body $path ==  $body');
      return body as Map<String, dynamic>;
    } on DioException catch (e) {
      logDioException(e, path);
      return {'error': '$e'};
    } on Exception catch (e) {
      logSimpleError(e, path);
      return {'error': '$e'};
    }
  }
}

void logSimpleError(Exception e, String path) {
  Logger.e('Error path: $path  причина: $e');
  Get.snackbar('Ошибка path: $path', '$e');
}

void logDioException(DioException e, String path) {
  final context = router.configuration.navigatorKey.currentContext;
  var error = '';
  if (e.response != null) {
    error = 'response $path data:  ${e.response!.data}';
    Logger.e('Error  DioException path: $path data:  ${e.response!.data}');
    Logger.e('Error DioException path: $path headers: ${e.response!.headers}');
    Logger.e(
        'Error DioException path: $path requestOptions: ${e.response!.requestOptions.data}');
  } else {
    error = 'request path: $path data:  ${e.message}';
    Logger.e('Error DioException request ${e.message}');
    Logger.e('Error DioException  path ${e.requestOptions.path}');
    Logger.e('Error DioException  path: $path data: ${e.requestOptions.data}');
  }
  if (error.isNotEmpty && context != null) {
    if (error.contains('Token is invalid')) {
    } else {}
  }
}
