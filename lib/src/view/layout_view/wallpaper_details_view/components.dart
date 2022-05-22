import 'package:flutter/material.dart';
import '../../../../utils/theme/colors.dart';
import '../../shared_components/shared_components.dart';

class WallpaperDetailsPopNavigateButtonWidget extends StatelessWidget {
  const WallpaperDetailsPopNavigateButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomNavigationBarHeight + MediaQuery
          .of(context)
          .padding
          .top,
      width: infinityWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleButtonUtil(
            icon: Icons.adaptive.arrow_back,
            iconColor: mainClr,
            buttonColor: Colors.black26,
            onClick: () => onPop(context),
          ),
        ],
      ),
    );
  }
}