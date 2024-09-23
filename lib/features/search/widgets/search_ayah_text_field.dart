import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/theming/colors.dart';

class SearchAyahTextField extends StatelessWidget {
  const SearchAyahTextField({super.key, this.onChanged});
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: TextInputType.text,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge?.color,
        fontSize: 16.sp,
        fontFamily: 'amiri',
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(16.h),
        hintText: "ابحث عن الآية",
        hintStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontSize: 16.sp,
          fontFamily: "cairo",
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.orangeColor,
            ),
            borderRadius: BorderRadius.circular(10.r)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.orangeColor,
            ),
            borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }
}
