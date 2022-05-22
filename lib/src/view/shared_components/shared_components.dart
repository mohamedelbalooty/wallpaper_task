import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photos_app/src/model/wallpaper.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../utils/theme/colors.dart';
import '../../model/error_result.dart';

const double infinityHeight = double.infinity;
const double infinityWidth = double.infinity;

class BackgroundUtil extends StatelessWidget {
  const BackgroundUtil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: infinityHeight,
      width: infinityWidth,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff43096E), Color(0xffCA32AB), Color(0xffFF927E)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
    );
  }
}

class WallpaperCardUtil extends StatelessWidget {
  const WallpaperCardUtil(
      {Key? key, required this.wallpaper, required this.onClick})
      : super(key: key);
  final Wallpaper wallpaper;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 5,
        color: mainClr.withOpacity(0.6),
        shape: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: transparent),
        ),
        child: NetworkImageUtil(
            height: infinityHeight,
            width: infinityWidth,
            radius: 10,
            imageUrl: wallpaper.mediumImage),
      ),
    );
  }
}

class NetworkImageUtil extends StatelessWidget {
  final String imageUrl;
  final double height, width, radius;

  const NetworkImageUtil(
      {Key? key,
      required this.imageUrl,
      required this.height,
      required this.width,
      this.radius = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Image.asset(
            'assets/images/loading.png',
            color: Colors.grey.shade300,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: FadeInImage.memoryNetwork(
            height: height,
            width: width,
            image: imageUrl,
            fit: BoxFit.cover,
            placeholder: kTransparentImage,
            placeholderErrorBuilder: (_, value, error) {
              return SizedBox(
                height: height,
                width: width,
                child: const Center(
                  child: Icon(
                    Icons.error,
                    size: 28.0,
                    color: Colors.red,
                  ),
                ),
              );
            },
            imageErrorBuilder: (_, value, error) {
              return SizedBox(
                height: height,
                width: width,
                child: const Center(
                  child: Icon(
                    Icons.error,
                    size: 28.0,
                    color: Colors.red,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class LoadingUtil extends StatelessWidget {
  const LoadingUtil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class ErrorResultUtil extends StatelessWidget {
  const ErrorResultUtil({Key? key, required this.errorResult})
      : super(key: key);
  final ErrorResult errorResult;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              errorResult.image,
              height: 200,
              width: MediaQuery.of(context).size.width * 0.8,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: Text(
                  errorResult.message,
                  style: const TextStyle(
                    color: whiteClr,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleButtonUtil extends StatelessWidget {
  const CircleButtonUtil(
      {Key? key,
      required this.icon,
      required this.iconColor,
      required this.buttonColor,
      required this.onClick})
      : super(key: key);
  final IconData icon;
  final Color iconColor, buttonColor;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 40.h,
        width: 40.h,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: buttonColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            size: 26.sp,
            color: iconColor,
          ),
        ),
      ),
      onTap: onClick,
    );
  }
}

void showToast({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.black87.withOpacity(0.5),
      fontSize: 16.sp);
}

void onNamedNavigate(BuildContext context,
        {required String route, dynamic arguments}) =>
    Navigator.pushNamed(context, route, arguments: arguments);

void onPop(BuildContext context) => Navigator.pop(context);
