import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/theming/colors.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.controller,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 8.h),
      child: SizedBox(
        width: 70,
        child: TextFormField(
          controller: controller,
          onFieldSubmitted: onFieldSubmitted,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18.sp,
          ),
          decoration: InputDecoration(
            hintText: "الصفحة",
            hintStyle: TextStyle(
              color: AppColors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: "cairo",
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.yellowColor,
                ),
                borderRadius: BorderRadius.circular(10.r)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.orangeColor,
                ),
                borderRadius: BorderRadius.circular(10.r)),
          ),
        ),
      ),
    );
  }
}
