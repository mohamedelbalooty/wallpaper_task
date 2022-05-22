import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photos_app/src/model/error_result.dart';
import 'package:photos_app/src/model/wallpaper.dart';
import 'package:photos_app/utils/helper/dio_helper.dart';
import '../../../core/dio_exception_handling.dart';
import '../../../core/status_code_error_handling.dart';
import 'wallpaper_services_repository.dart';

class WallpaperServicesImplementation extends WallpaperServicesRepository {
  @override
  Future<Either<List<Wallpaper>, ErrorResult>> getHomeWallpapers(
      {required int page}) async {
    try {
      var response =
          await DioHelper.getData(url: 'curated?page=$page&per_page=20');
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        List<dynamic> data = jsonData['photos'];
        List<Wallpaper> wallpapers =
            data.map((element) => Wallpaper.fromRemoteMap(element)).toList();
        return Left(wallpapers);
      } else {
        return Right(returnResponse(response: response));
      }
    } on DioError catch (exception) {
      return Right(
        DioException.dioExceptionHandling(
            exceptionType: exception.type, response: exception.response),
      );
    }
  }

  @override
  Future<Either<List<Wallpaper>, ErrorResult>> getSearchWallpapers(
      {required String searchQuery}) async {
    try {
      var response = await DioHelper.getData(url: 'search?query=$searchQuery');
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        List<dynamic> data = jsonData['photos'];
        List<Wallpaper> wallpapers =
            data.map((element) => Wallpaper.fromRemoteMap(element)).toList();
        return Left(wallpapers);
      } else {
        return Right(returnResponse(response: response));
      }
    } on DioError catch (exception) {
      return Right(
        DioException.dioExceptionHandling(
            exceptionType: exception.type, response: exception.response),
      );
    }
  }

  @override
  Future<Either<Wallpaper, ErrorResult>> getWallpaperDetails(
      {required String wallpaperId}) async {
    try {
      var response = await DioHelper.getData(url: 'photos/$wallpaperId');
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        Wallpaper wallpaper = Wallpaper.fromRemoteMap(jsonData);
        return Left(wallpaper);
      } else {
        return Right(returnResponse(response: response));
      }
    } on DioError catch (exception) {
      return Right(
        DioException.dioExceptionHandling(
            exceptionType: exception.type, response: exception.response),
      );
    }
  }

  @override
  Future<Either<String, String>> downloadWallpaper(
      {required String url, required String id}) async {
    try {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        var response = await DioHelper.getData(
            url: url, options: Options(responseType: ResponseType.bytes));
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data),
            quality: 60, name: id);
        return Left('image_downloaded'.tr());
      } else {
        return Left('image_not_downloaded'.tr());
      }
    } on DioError catch (exception) {
      return Right(
        DioException.dioExceptionHandling(
                exceptionType: exception.type, response: exception.response)
            .message,
      );
    }
  }
}
