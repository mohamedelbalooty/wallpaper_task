import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photos_app/src/view/shared_components/shared_components.dart';
import 'package:photos_app/utils/theme/colors.dart';
import 'package:provider/provider.dart';
import '../../../view_model/favourite_wallpapers_view_model/favourite_wallpapers_view_model.dart';
import '../../../view_model/wallpaper_details_view_model.dart/states.dart';
import '../../../view_model/wallpaper_details_view_model.dart/wallpaper_details_view_model.dart';
import 'components.dart';

class WallpaperDetailsView extends StatelessWidget {
  const WallpaperDetailsView({Key? key}) : super(key: key);
  static const String id = 'WallpaperDetailsView';

  @override
  Widget build(BuildContext context) {
    dynamic wallpapers = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundUtil(),
          Consumer<WallpaperDetailsViewModel>(
            builder: (context, provider, child) {
              if (provider.states == WallpaperDetailsStates.loadingState) {
                return const LoadingUtil();
              } else if (provider.states ==
                  WallpaperDetailsStates.loadedState) {
                return SizedBox(
                  height: infinityHeight,
                  width: infinityWidth,
                  child: NetworkImageUtil(
                    height: infinityHeight,
                    width: infinityWidth,
                    imageUrl: provider.wallpaper!.originalImage,
                  ),
                );
              } else {
                return ErrorResultUtil(
                  errorResult: provider.errorResult!,
                );
              }
            },
          ),
          const WallpaperDetailsPopNavigateButtonWidget(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: kBottomNavigationBarHeight,
              width: infinityWidth,
              margin: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  Consumer<WallpaperDetailsViewModel>(
                    builder: (context, provider, child) {
                      return ElevatedButton(
                        child: Text(
                          (provider.downloadStates ==
                                  WallpaperDetailsDownloadStates.loadingState)
                              ? 'loading'.tr()
                              : 'download'.tr(),
                          style: TextStyle(
                              color: whiteClr,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(mainClr),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 70.w, vertical: 10.h)),
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)))),
                        ),
                        onPressed: () async {
                          await provider.downloadWallpaper(
                              url: provider.wallpaper!.mediumImage,
                              id: (provider.wallpaper!.id).toString());
                          if (provider.downloadStates ==
                              WallpaperDetailsDownloadStates.successState) {
                            showToast(message: provider.downloadedSuccess!);
                          }
                          if (provider.downloadStates ==
                              WallpaperDetailsDownloadStates.errorState) {
                            showToast(message: provider.downloadedError!);
                          }
                        },
                      );
                    },
                  ),
                  const Spacer(),
                  Consumer<FavouriteWallpaperViewModel>(
                    builder: (context, provider, child) {
                      return CircleButtonUtil(
                        icon: Icons.favorite,
                        iconColor:
                            provider.isFavourite(id: wallpapers['selectedId'])
                                ? Colors.red
                                : Colors.grey,
                        buttonColor: whiteClr,
                        onClick: () => provider.addWallpaperToFavourite(
                          id: wallpapers['selectedId'],
                          wallpapers: wallpapers['wallpapers'],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
