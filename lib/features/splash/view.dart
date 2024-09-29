import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/navigate.dart';
import 'package:quran_app/core/theming/assets.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/features/bottom_nav_bar/view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _goNext();
  }

  _goNext() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    MagicRouter.navigateTo(page: const NavBarView(), withHistory: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 0.05.sh),
              SizedBox(
                height: 250.h,
                width: 250.h,
                child: const Image(
                  image: AssetImage(ImageManager.quranLogoImg),
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding:  EdgeInsets.only(bottom: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'القُرْآنُ ',
              style: TextStyle(
                fontSize: 35.sp,
                color: AppColors.orangeColor,
                letterSpacing: 1.2,
                fontFamily: 'amiri',
              ),
            ),
            Text(
              'الكَرِيمُ',
              style: TextStyle(
                fontSize: 30.sp,
                color: AppColors.yellowColor,
                letterSpacing: 1.2,
                fontFamily: 'amiri',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
