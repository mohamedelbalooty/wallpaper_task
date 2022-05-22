import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/theme/colors.dart';

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget(
      {Key? key, required this.controller, required this.onChanged})
      : super(key: key);
  final TextEditingController controller;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
          color: whiteClr,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        cursorColor: whiteClr,
        decoration: InputDecoration(
            label: Text('search'.tr()),
            labelStyle: TextStyle(
              color: whiteClr,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: whiteClr,
              size: 25.sp,
            ),
            enabledBorder: _border,
            errorBorder: _border,
            focusedBorder: _border,
            focusedErrorBorder: _border),
      ),
    );
  }

  final OutlineInputBorder _border = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(color: whiteClr, width: 1.5),
  );
}
