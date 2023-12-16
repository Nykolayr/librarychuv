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

  /// авторизация по логину и паролю
  Future<Map<dynamic, dynamic>?> postAuthUser(
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
      return body as Map<dynamic, dynamic>;
    } on DioException catch (e) {
      logDioException(e, path);
    } on Exception catch (e) {
      logSimpleError(e, path);
    }
    return null;
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
    // fToast.showToast(
    //   child: Text('Ошибка path: $path  ${e.response!.data}'),
    //   gravity: ToastGravity.BOTTOM,
    //   toastDuration: const Duration(seconds: 10),
    // );

    // Get.dialog(Text('Ошибка path: $path  ${e.response!.data}'));
    // Get.snackbar('Ошибка path: $path', '${e.response!.data}');
  } else {
    error = 'request path: $path data:  ${e.message}';
    Logger.e('Error DioException request ${e.message}');
    Logger.e('Error DioException  path ${e.requestOptions.path}');
    Logger.e('Error DioException  path: $path data: ${e.requestOptions.data}');
    // Get.dialog(Text('Ошибка path: $path  ${e.message}'));
    // Get.snackbar('Ошибка path: $path', e.message ?? 'нераспознанная ошибка');
  }
  if (error.isNotEmpty && context != null) {
    if (error.contains('Token is invalid')) {
    } else {}
  }
}
