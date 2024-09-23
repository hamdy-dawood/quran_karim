import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/theming/colors.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: ColorManager.orangeColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.h),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: ColorManager.white,
                fontSize: 20.sp,
                fontFamily: 'cairo',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
