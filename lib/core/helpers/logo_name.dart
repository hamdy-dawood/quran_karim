import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/theming/assets.dart';

import '../theming/colors.dart';

class LogoName extends StatelessWidget {
  const LogoName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Qur\'an',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.orangeColor,
                  letterSpacing: 1.2,
                  fontFamily: 'amiri',
                ),
              ),
              Text(
                'Karim',
                style: TextStyle(
                  fontSize: 35,
                  color: AppColors.yellowColor,
                  letterSpacing: 1.2,
                  fontFamily: 'amiri',
                ),
              ),
            ],
          ),
          Image.asset(
            ImageManager.quranLogoImg,
            height: 100.h,
          ),
        ],
      ),
    );
  }
}
