import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../utils/constants/cache_constants.dart';
import '../../../utils/helper/cache_helper.dart';
import '../../model/wallpaper.dart';

class FavouriteWallpaperViewModel extends ChangeNotifier {
  final List<Wallpaper>? _favouriteWallpapers = [];

  List<Wallpaper>? get favouriteWallpapers => _favouriteWallpapers;

  void getFavouriteWallpapers() {
    String? localData = CacheHelper.getStringData(key: favouriteKey);
    if(localData != null){
      List<dynamic> jsonData = jsonDecode(localData);
      List<Wallpaper> localFavouriteWallpapers =
      jsonData.map((element) => Wallpaper.fromLocalMap(element)).toList();
      _favouriteWallpapers!.addAll(localFavouriteWallpapers);
    }
    notifyListeners();
  }

  Future<void> addWallpaperToFavourite(
      {required List<Wallpaper> wallpapers, required int id}) async{
    int selectedWallpaper =
        _favouriteWallpapers!.indexWhere((element) => element.id == id);
    if (selectedWallpaper >= 0) {
      _favouriteWallpapers!.removeAt(selectedWallpaper);
      await CacheHelper.removeData(key: favouriteKey);
    } else {
      _favouriteWallpapers!
          .add(wallpapers.firstWhere((element) => element.id == id));
      await CacheHelper.setStringData(
          key: favouriteKey,
          value: jsonEncode(
              _favouriteWallpapers!.map((element) => element.toMap()).toList()));
    }
    notifyListeners();
  }

  bool isFavourite({required int id}) =>
      _favouriteWallpapers!.any((element) => element.id == id);
}
