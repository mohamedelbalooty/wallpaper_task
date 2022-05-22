import 'package:flutter/material.dart';
import 'package:photos_app/src/model/error_result.dart';
import 'package:photos_app/src/model/wallpaper.dart';
import '../../services/wallpaper_services/wallpaper_services_implementation.dart';
import 'states.dart';

class WallpaperDetailsViewModel extends ChangeNotifier {
  WallpaperDetailsViewModel() {
    service = WallpaperServicesImplementation();
    downloadStates = WallpaperDetailsDownloadStates.initialState;
  }

  late WallpaperServicesImplementation service;
  late WallpaperDetailsStates states;
  late WallpaperDetailsDownloadStates downloadStates;

  Wallpaper? _wallpaper;

  Wallpaper? get wallpaper => _wallpaper;

  ErrorResult? _errorResult;

  ErrorResult? get errorResult => _errorResult;

  String? _downloadedSuccess;

  String? get downloadedSuccess => _downloadedSuccess;

  String? _downloadedError;

  String? get downloadedError => _downloadedError;

  Future<void> getWallpaperDetails({required String wallpaperId}) async {
    states = WallpaperDetailsStates.loadingState;
    notifyListeners();
    await service.getWallpaperDetails(wallpaperId: wallpaperId).then((value) {
      value.fold((left) {
        _wallpaper = left;
        states = WallpaperDetailsStates.loadedState;
      }, (right) {
        _errorResult = right;
        states = WallpaperDetailsStates.errorState;
      });
    });
    notifyListeners();
  }

  Future<void> downloadWallpaper(
      {required String url, required String id}) async {
    downloadStates = WallpaperDetailsDownloadStates.loadingState;
    notifyListeners();
    await service.downloadWallpaper(url: url, id: id).then((value) {
      value.fold((left) {
        _downloadedSuccess = left;
        downloadStates = WallpaperDetailsDownloadStates.successState;
      }, (right) {
        _downloadedError = right;
        downloadStates = WallpaperDetailsDownloadStates.errorState;
      });
    });
    notifyListeners();
  }
}
