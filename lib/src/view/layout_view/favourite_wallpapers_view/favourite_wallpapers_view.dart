import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import '../../../../utils/theme/colors.dart';
import '../../../view_model/favourite_wallpapers_view_model/favourite_wallpapers_view_model.dart';
import '../../../view_model/wallpaper_details_view_model.dart/wallpaper_details_view_model.dart';
import '../../shared_components/shared_components.dart';
import '../wallpaper_details_view/wallpaper_details_view.dart';

class FavouriteWallpapersView extends StatefulWidget {
  const FavouriteWallpapersView({Key? key}) : super(key: key);

  @override
  State<FavouriteWallpapersView> createState() =>
      _FavouriteWallpapersViewState();
}

class _FavouriteWallpapersViewState extends State<FavouriteWallpapersView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<FavouriteWallpaperViewModel>().getFavouriteWallpapers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('favourite_wallpapers'.tr()),
      ),
      body: Stack(
        children: [
          const BackgroundUtil(),
          Consumer<FavouriteWallpaperViewModel>(
            builder: (context, provider, child) {
              if (provider.favouriteWallpapers!.isNotEmpty) {
                return StaggeredGridView.countBuilder(
                  padding: const EdgeInsetsDirectional.only(
                      start: 15, end: 15, top: 10),
                  crossAxisCount: 4,
                  itemCount: provider.favouriteWallpapers!.length,
                  itemBuilder: (BuildContext context, int index) =>
                      WallpaperCardUtil(
                    wallpaper: provider.favouriteWallpapers![index],
                    onClick: () async {
                      await context
                          .read<WallpaperDetailsViewModel>()
                          .getWallpaperDetails(
                              wallpaperId:
                                  (provider.favouriteWallpapers![index].id)
                                      .toString());
                      onNamedNavigate(
                        context,
                        route: WallpaperDetailsView.id,
                        arguments: {
                          "wallpapers": provider.favouriteWallpapers!,
                          "selectedId": provider.favouriteWallpapers![index].id
                        },
                      );
                    },
                  ),
                  staggeredTileBuilder: (int index) =>
                      StaggeredTile.count(2, index.isEven ? 2 : 1),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                );
              } else {
                return Center(
                  child: Icon(
                    Icons.dangerous,
                    color: whiteClr,
                    size: 150.sp,
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
