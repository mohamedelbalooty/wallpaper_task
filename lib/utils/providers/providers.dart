import 'package:photos_app/src/view_model/search_view_model/search_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../src/view_model/favourite_wallpapers_view_model/favourite_wallpapers_view_model.dart';
import '../../src/view_model/home_view_model/home_view_model.dart';
import '../../src/view_model/layout_view_model/layout_view_model.dart';
import '../../src/view_model/wallpaper_details_view_model.dart/wallpaper_details_view_model.dart';

class Providers {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider<LayoutViewModel>(
      create: (_) => LayoutViewModel(),
    ),
    ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
    ),
    ChangeNotifierProvider<WallpaperDetailsViewModel>(
      create: (_) => WallpaperDetailsViewModel(),
    ),
    ChangeNotifierProvider<SearchViewModel>(
      create: (_) => SearchViewModel(),
    ),
    ChangeNotifierProvider<FavouriteWallpaperViewModel>(
      create: (_) => FavouriteWallpaperViewModel(),
    ),
  ];
}
