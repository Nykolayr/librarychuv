import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:surf_logger/surf_logger.dart';

class DioExceptions implements Exception {
  late String errorText;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        errorText = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        errorText = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        errorText = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badCertificate:
        errorText = "Неправильный сертификат";
        break;
      case DioExceptionType.badResponse:
        errorText = handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        errorText = "Send timeout in connection with API server";
        break;
      case DioExceptionType.unknown:
        if (dioError.message != null &&
            dioError.message!.contains("SocketException")) {
          errorText = 'No Internet';
          break;
        }
        errorText = "Unexpected error occurred";
        break;
      default:
        errorText =
            "path:  ${dioError.requestOptions.uri}  message:  ${dioError.message}";
        break;
    }

    Logger.e('Ошибка fromDioError  $errorText');
    showErrorDialog(errorText);
  }

  String handleError(int? statusCode, dynamic error) {
    Logger.e('Ошибка handleError statusCode $statusCode error $error');
    String errorText = 'Ошибка handleError statusCode $statusCode error $error';

    switch (statusCode) {
      case 400:
        errorText = 'Bad request error 400';
      case 401:
        errorText = 'Unauthorized error 401';
      case 403:
        errorText = 'Forbidden error 403';
      case 404:
        errorText = 'ошибка 404, страница не найдена';
      case 500:
        errorText = 'Internal server error error 500';
      case 502:
        errorText = 'Bad gateway error 502';
      default:
        errorText = 'Oops something went wrong';
    }
    showErrorDialog(errorText);
    return errorText;
  }

  @override
  String toString() => errorText;
}

void showErrorDialog(String errorMessage) async {
  if (Get.context != null) {
    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ошибка при работе с сервером',
              style: AppText.captionText14r.copyWith(color: AppColor.redMain)),
          content: Text(errorMessage, style: AppText.text12b),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
