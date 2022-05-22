import 'package:dio/dio.dart';
import '../src/model/error_result.dart';
import 'server_exception_handling.dart';

ErrorResult returnResponse({required Response response}) {
  switch (response.statusCode) {
    case 400:
      return BadRequestException().errorResult();
    case 401:
    case 403:
      return UnauthorisedException().errorResult();
    case 404:
    case 500:
    case 503:
    default:
      return FetchDataException().errorResult();
  }
}