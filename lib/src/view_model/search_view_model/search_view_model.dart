import 'package:flutter/material.dart';
import 'package:photos_app/src/model/error_result.dart';
import 'package:photos_app/src/model/wallpaper.dart';
import '../../services/wallpaper_services/wallpaper_services_implementation.dart';
import 'states.dart';

class SearchViewModel extends ChangeNotifier {
  SearchViewModel() {
    service = WallpaperServicesImplementation();
    states = WallpaperSearchStates.initialState;
  }

  late WallpaperServicesImplementation service;
  late WallpaperSearchStates states;

  List<Wallpaper>? _wallpapers;

  List<Wallpaper>? get wallpapers => _wallpapers;

  ErrorResult? _errorResult;

  ErrorResult? get errorResult => _errorResult;

  Future<void> getWallpaperDetails({required String searchQuery}) async {
    states = WallpaperSearchStates.loadingState;
    notifyListeners();
    if(searchQuery.isNotEmpty){
      await service.getSearchWallpapers(searchQuery: searchQuery).then((value) {
        value.fold((left) {
          _wallpapers = left;
          states = WallpaperSearchStates.loadedState;
        }, (right) {
          _errorResult = right;
          states = WallpaperSearchStates.errorState;
        });
      });
    }else{
      states = WallpaperSearchStates.emptyState;
    }
    notifyListeners();
  }
}
