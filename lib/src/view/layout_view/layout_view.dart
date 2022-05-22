import 'package:flutter/material.dart';
import 'package:photos_app/src/view/layout_view/home_view/home_view.dart';
import 'package:photos_app/src/view/layout_view/search_view/search_view.dart';
import 'package:photos_app/src/view_model/layout_view_model/layout_view_model.dart';
import 'package:provider/provider.dart';
import '../../../utils/helper/size_configuration_helper.dart';
import 'components.dart';
import 'favourite_wallpapers_view/favourite_wallpapers_view.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({Key? key}) : super(key: key);
  static const String id = 'LayoutView';

  final List<Widget> _pages = const [
    HomeView(),
    SearchView(),
    FavouriteWallpapersView(),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfigurationHelper.initSizeConfiguration(context);
    return Scaffold(
      body: Stack(
        children: _pages
            .asMap()
            .map(
              (index, page) => MapEntry(
                index,
                Offstage(
                  offstage: context.select<LayoutViewModel, int>(
                          (value) => value.currentPage) !=
                      index,
                  child: page,
                ),
              ),
            )
            .values
            .toList(),
      ),
      bottomNavigationBar: LayoutBottomNavigationBarWidget(
        currentPage:
            context.select<LayoutViewModel, int>((value) => value.currentPage),
        onTap: (int? page) {
          context.read<LayoutViewModel>().onPageChanged(page: page!);
        },
      ),
    );
  }
}
