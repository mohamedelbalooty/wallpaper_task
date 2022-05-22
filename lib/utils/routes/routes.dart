import 'package:flutter/material.dart';
import '../../src/view/layout_view/layout_view.dart';
import '../../src/view/layout_view/wallpaper_details_view/wallpaper_details_view.dart';

class Routes{
  static const String initialRoute = LayoutView.id;
  static final Map<String, WidgetBuilder> routes = {
    LayoutView.id: (_) => const LayoutView(),
    WallpaperDetailsView.id: (_) => const WallpaperDetailsView(),
  };

}