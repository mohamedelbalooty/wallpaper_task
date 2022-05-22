import 'package:dio/dio.dart';
import '../src/model/error_result.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'status_code_error_handling.dart';

class DioException {
  static ErrorResult dioExceptionHandling(
      {required DioErrorType exceptionType, Response? response}) {
    switch (exceptionType) {
      case DioErrorType.connectTimeout:
        return ErrorResult(
            image: 'assets/images/data_error.png',
            message: 'connectTimeout'.tr());
      case DioErrorType.sendTimeout:
        return ErrorResult(
            image: 'assets/images/data_error.png', message: 'sendTimeout'.tr());
      case DioErrorType.receiveTimeout:
        return ErrorResult(
            image: 'assets/images/data_error.png',
            message: 'receiveTimeout'.tr());
      case DioErrorType.response:
        return returnResponse(response: response!);
      case DioErrorType.cancel:
        return ErrorResult(
            image: 'assets/images/server_error.png', message: 'cancel'.tr());
      case DioErrorType.other:
        return ErrorResult(
            image: 'assets/images/server_error.png', message: 'other'.tr());
    }
  }
}
