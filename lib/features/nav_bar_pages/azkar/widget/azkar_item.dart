import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/navigate.dart';

class AzkarItem extends StatelessWidget {
  const AzkarItem({
    Key? key,
    required this.page,
    required this.text,
    required this.containerColor,
    required this.textColor,
    required this.image,
  }) : super(key: key);
  final Widget page;
  final String text;
  final Color containerColor;
  final Color textColor;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MagicRouter.navigateTo(
          page: page,
        );
      },
      child: Container(
        height: 100.h,
        width: 1.sw,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: textColor,
                fontFamily: 'cairo',
              ),
            ),
            Image.asset(
              image,
              height: 100.h,
            ),
          ],
        ),
      ),
    );
  }
}
