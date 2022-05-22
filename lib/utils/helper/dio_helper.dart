import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {'Authorization': apiKey},
      ),
    );
  }

  static Future<Response> getData({required String url, Options? options}) async {
    return await dio.get(url, options: options);
  }

  static Future<void> downloadData(
      {required String url, required String fileName}) async {
    dio.download(url, fileName);
  }
}
