import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:get/get.dart';
import 'package:librarychuv/common/constants.dart';
import 'package:librarychuv/data/api/dio_exception.dart';
import 'package:librarychuv/data/api/response_api.dart';
import 'package:librarychuv/domain/repository/user_repository.dart';

class DioClient {
  final Dio dio;

  final options = Options(
    headers: {
      'Content-type': 'application/json',
      if (Get.isRegistered<UserRepository>() &&
          Get.find<UserRepository>().token.isNotEmpty)
        'Authorization': 'Bearer ${Get.find<UserRepository>().token}',
    },
  );
  DioClient(this.dio) {
    dio
      ..options.baseUrl = apiUrl
      ..options.connectTimeout = const Duration(seconds: 35)
      ..options.receiveTimeout = const Duration(seconds: 35);
  }

  Future<ResponseApi> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return processResponse(response.data, url);
    } catch (e) {
      return errorHandling(e);
    }
  }

  Future<ResponseApi> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.post(
        url,
        data: data,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return processResponse(response.data, url);
    } catch (e) {
      return errorHandling(e);
    }
  }

  Future<ResponseApi> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return processResponse(response.data, url);
    } catch (e) {
      return errorHandling(e);
    }
  }

  Future<ResponseApi> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return processResponse(response.data, url);
    } catch (e) {
      return errorHandling(e);
    }
  }
}

ResponseApi errorHandling(Object e) {
  Logger.e('error: $e');
  if (e is DioException) {
    DioExceptions dioException = DioExceptions.fromDioError(e);
    return ResError(errorMessage: dioException.errorText);
  } else {
    return ResError(errorMessage: 'Unexpected error occurred: ${e.toString()}');
  }
}

ResponseApi processResponse(dynamic resOut, String path) {
  Map res = {};
  if (resOut is String) {
    res = jsonDecode(resOut);
  } else {
    res = resOut;
  }

  /// для news, events, ads
  if (path.contains('/news') || path.contains('/events')
      //  || path.contains('/ads')
      ) {
    if (res['error'] == null) {
      ResSuccess resSuccess = ResSuccess({
        "Items": res['Items'],
        "pagination": res['Pagination'],
      });
      resSuccess.consoleRes(path);
      return resSuccess;
    } else {
      ResError resError =
          ResError(errorMessage: 'path == $path ${res['message']}');
      resError.consoleRes(path);
      return resError;
    }
  }

  /// для входа в систему при авторизации юзера
  if (res['status'] != null) {
    if (res['status'] == "success") {
      ResSuccess resSuccess = ResSuccess(res['data']);
      resSuccess.consoleRes(path);
      return resSuccess;
    } else {
      ResError resError =
          ResError(errorMessage: 'path == $path  ${res['message']}');
      resError.consoleRes(path);
      return resError;
    }
  }

  /// для остальных запросов
  if (res['Items'] != null) {
    ResSuccess resSuccess = ResSuccess(res['Items']);
    resSuccess.consoleRes(path);
    return resSuccess;
  } else if (res['error'] == null) {
    ResSuccess resSuccess = ResSuccess(res);
    resSuccess.consoleRes(path);
    return resSuccess;
  } else {
    ResError resError =
        ResError(errorMessage: 'path == $path ${res['message']}');
    resError.consoleRes(path);
    return resError;
  }
}
