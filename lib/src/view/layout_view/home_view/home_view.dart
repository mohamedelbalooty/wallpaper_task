import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:photos_app/src/view_model/home_view_model/home_view_model.dart';
import 'package:photos_app/src/view_model/wallpaper_details_view_model.dart/wallpaper_details_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../view_model/home_view_model/states.dart';
import '../../shared_components/shared_components.dart';
import '../wallpaper_details_view/wallpaper_details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late GlobalKey _refreshKey;
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home_wallpapers'.tr()),
      ),
      body: Stack(
        children: [
          const BackgroundUtil(),
          Consumer<HomeViewModel>(
            builder: (context, provider, child) {
              if (provider.states == HomeWallpaperStates.initialState) {
                provider.getHomeWallpapers();
                return const LoadingUtil();
              } else if (provider.states == HomeWallpaperStates.loadingState) {
                return const LoadingUtil();
              } else if (provider.states == HomeWallpaperStates.loadedState) {
                return SmartRefresher(
                  key: _refreshKey,
                  controller: _refreshController,
                  enablePullUp: true,
                  physics: const BouncingScrollPhysics(),
                  footer: const ClassicFooter(
                    loadStyle: LoadStyle.ShowWhenLoading,
                  ),
                  onRefresh: () {
                    provider.onRefresh(controller: _refreshController);
                    if (provider.onRefreshStates ==
                        HomeOnRefreshStates.errorState) {
                      showToast(message: provider.onRefreshError!);
                    }
                  },
                  onLoading: () {
                    provider.onLoad(controller: _refreshController);
                    if (provider.onLoadStates == HomeOnLoadStates.errorState) {
                      showToast(message: provider.onLoadError!);
                    }
                  },
                  child: StaggeredGridView.countBuilder(
                    padding: const EdgeInsetsDirectional.only(
                        start: 15, end: 15, top: 10),
                    crossAxisCount: 4,
                    itemCount: provider.wallpapers!.length,
                    itemBuilder: (BuildContext context, int index) =>
                        WallpaperCardUtil(
                      wallpaper: provider.wallpapers![index],
                      onClick: () async {
                        await context
                            .read<WallpaperDetailsViewModel>()
                            .getWallpaperDetails(
                                wallpaperId: (provider.wallpapers![index].id)
                                    .toString());
                        onNamedNavigate(
                          context,
                          route: WallpaperDetailsView.id,
                          arguments: {
                            "wallpapers": provider.wallpapers!,
                            "selectedId": provider.wallpapers![index].id
                          },
                        );
                      },
                    ),
                    staggeredTileBuilder: (int index) =>
                        StaggeredTile.count(2, index.isEven ? 2 : 1),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                );
              } else {
                return ErrorResultUtil(
                  errorResult: provider.errorResult!,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
