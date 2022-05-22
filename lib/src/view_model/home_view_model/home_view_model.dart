import 'package:flutter/material.dart';
import 'package:photos_app/src/model/error_result.dart';
import 'package:photos_app/src/model/wallpaper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../services/wallpaper_services/wallpaper_services_implementation.dart';
import 'states.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    service = WallpaperServicesImplementation();
    states = HomeWallpaperStates.initialState;
    onRefreshStates = HomeOnRefreshStates.initialState;
    onLoadStates = HomeOnLoadStates.initialState;
  }

  late WallpaperServicesImplementation service;
  late HomeWallpaperStates states;
  late HomeOnRefreshStates onRefreshStates;
  late HomeOnLoadStates onLoadStates;
  int page = 1;

  List<Wallpaper>? _wallpapers;

  List<Wallpaper>? get wallpapers => _wallpapers;

  ErrorResult? _errorResult;

  ErrorResult? get errorResult => _errorResult;

  String? _onRefreshError;

  String? get onRefreshError => _onRefreshError;

  String? _onLoadError;

  String? get onLoadError => _onLoadError;

  Future<void> getHomeWallpapers() async {
    states = HomeWallpaperStates.loadingState;
    await service.getHomeWallpapers(page: page).then((value) {
      value.fold((left) {
        _wallpapers = left;
        states = HomeWallpaperStates.loadedState;
      }, (right) {
        _errorResult = right;
        states = HomeWallpaperStates.errorState;
      });
    });
    notifyListeners();
  }

  Future<void> onRefresh({required RefreshController controller}) async {
    await Future.delayed(const Duration(seconds: 2));
    await service.getHomeWallpapers(page: 1).then((value) {
      value.fold((left) {
        page = 1;
        _wallpapers!.clear();
        _wallpapers = left;
        controller.refreshCompleted();
        onRefreshStates = HomeOnRefreshStates.successState;
      }, (right) {
        _errorResult = right;
        _onRefreshError = right.message;
        controller.refreshFailed();
        onRefreshStates = HomeOnRefreshStates.errorState;
      });
    });
    notifyListeners();
  }

  Future<void> onLoad({required RefreshController controller}) async {
    page += 1;
    await service.getHomeWallpapers(page: page).then((value) {
      value.fold((left) {
        _wallpapers?.addAll(left);
        controller.loadComplete();
        onLoadStates = HomeOnLoadStates.successState;
      }, (right) {
        _errorResult = right;
        _onLoadError = right.message;
        controller.loadFailed();
        onLoadStates = HomeOnLoadStates.errorState;
      });
    });
    notifyListeners();
  }
}
