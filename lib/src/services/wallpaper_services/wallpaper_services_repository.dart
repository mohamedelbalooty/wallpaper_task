import 'package:dartz/dartz.dart';
import 'package:photos_app/src/model/error_result.dart';
import '../../model/wallpaper.dart';

abstract class WallpaperServicesRepository {
  Future<Either<List<Wallpaper>, ErrorResult>> getHomeWallpapers({required int page});

  Future<Either<List<Wallpaper>, ErrorResult>> getSearchWallpapers({required String searchQuery});

  Future<Either<Wallpaper, ErrorResult>> getWallpaperDetails({required String wallpaperId});

  Future<Either<String, String>> downloadWallpaper({required String url, required String id});
}
