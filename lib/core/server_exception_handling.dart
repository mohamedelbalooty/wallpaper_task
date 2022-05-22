import 'package:localize_and_translate/localize_and_translate.dart';
import '../src/model/error_result.dart';

abstract class ServerException {
  ErrorResult errorResult();
}

class BadRequestException extends ServerException {
  @override
  ErrorResult errorResult() {
    return ErrorResult(
        message: 'badRequest'.tr(), image: 'assets/icons/data_error.png');
  }
}

class UnauthorisedException extends ServerException {
  @override
  ErrorResult errorResult() {
    return ErrorResult(
        message: 'unauthorised'.tr(), image: 'assets/icons/data_error.png');
  }
}

class FetchDataException extends ServerException {
  @override
  ErrorResult errorResult() {
    return ErrorResult(
        message: 'format'.tr(), image: 'assets/icons/server_error.png');
  }
}
