import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:photos_app/src/view_model/search_view_model/search_view_model.dart';
import 'package:photos_app/utils/theme/colors.dart';
import 'package:provider/provider.dart';
import '../../../view_model/search_view_model/states.dart';
import '../../../view_model/wallpaper_details_view_model.dart/wallpaper_details_view_model.dart';
import '../../shared_components/shared_components.dart';
import '../wallpaper_details_view/wallpaper_details_view.dart';
import 'components.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('search_wallpapers'.tr()),
      ),
      body: Stack(
        children: [
          const BackgroundUtil(),
          Column(
            children: [
              const SizedBox(height: 10),
              SearchTextFieldWidget(
                controller: _searchController,
                onChanged: (String? value) => context
                    .read<SearchViewModel>()
                    .getWallpaperDetails(searchQuery: value!),
              ),
              const SizedBox(height: 10),
              Consumer<SearchViewModel>(
                builder: (context, provider, child) {
                  if (provider.states == WallpaperSearchStates.initialState ||
                      provider.states == WallpaperSearchStates.emptyState) {
                    return Expanded(
                      child: Center(
                        child: Icon(
                          Icons.search_off_rounded,
                          color: whiteClr,
                          size: 150.sp,
                        ),
                      ),
                    );
                  } else if (provider.states ==
                      WallpaperSearchStates.loadingState) {
                    return const Expanded(child: LoadingUtil());
                  } else if (provider.states ==
                      WallpaperSearchStates.loadedState) {
                    return Expanded(
                      child: StaggeredGridView.countBuilder(
                        padding: const EdgeInsetsDirectional.only(
                            start: 15, end: 15),
                        crossAxisCount: 4,
                        itemCount: provider.wallpapers!.length,
                        itemBuilder: (BuildContext context, int index) =>
                            WallpaperCardUtil(
                          wallpaper: provider.wallpapers![index],
                          onClick: () async {
                            await context
                                .read<WallpaperDetailsViewModel>()
                                .getWallpaperDetails(
                                    wallpaperId:
                                        (provider.wallpapers![index].id)
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
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
