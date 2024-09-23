import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/theming/assets.dart';
import 'package:quran_app/core/theming/colors.dart';

class ReturnBasmalah extends StatelessWidget {
  const ReturnBasmalah({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AssetsStrings.basmalahImg,
        height: 90.h,
        color: ColorManager.black,
        width: 0.7.sw,
      ),
    );
  }
}
