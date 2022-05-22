import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class LayoutBottomNavigationBarWidget extends StatelessWidget {
  const LayoutBottomNavigationBarWidget(
      {Key? key, required this.currentPage, required this.onTap})
      : super(key: key);
  final int currentPage;
  final Function(int?) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentPage,
      onTap: onTap,
      items: [
        _bottomNavigationBarItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'home'.tr()),
        _bottomNavigationBarItem(
            icon: Icons.search_rounded,
            activeIcon: Icons.search_rounded,
            label: 'search'.tr()),
        _bottomNavigationBarItem(
            icon: Icons.favorite_border,
            activeIcon: Icons.favorite,
            label: 'favourite'.tr()),
      ],
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
          {required IconData icon,
          required IconData activeIcon,
          required String label}) =>
      BottomNavigationBarItem(
        icon: Icon(
          icon,
          size: 30.sp,
        ),
        label: label,
        activeIcon: Icon(
          activeIcon,
          size: 30.sp,
        ),
      );
}
