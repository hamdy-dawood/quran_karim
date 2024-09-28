import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/theming/assets.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/core/widgets/app_bar.dart';

import 'pages/azkar_for_evening/view.dart';
import 'pages/azkar_for_morning/view.dart';
import 'pages/azkar_for_pray/view.dart';
import 'pages/azkar_for_sleeping/view.dart';
import 'pages/azkar_for_waking/view.dart';
import 'widget/azkar_item.dart';

class AzkarView extends StatelessWidget {
  const AzkarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        text: "الأذكار",
        withLeading: false,
        withActions: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            SizedBox(height: 10.h),
            AzkarItem(
              page: const AzkarForMorning(title: "أذكار الصباح"),
              text: "اذكار الصباح",
              containerColor: AppColors.orange2,
              textColor: AppColors.orange1,
              image: ImageManager.sunnyImg,
            ),
            SizedBox(height: 10.h),
            AzkarItem(
              page: const AzkarForEvening(title: "أذكار المساء"),
              text: "اذكار المساء",
              containerColor: AppColors.purple2,
              textColor: AppColors.purple1,
              image: ImageManager.eveningImg,
            ),
            SizedBox(height: 10.h),
            AzkarItem(
              page: const AzkarForWaking(title: "أذكار الاستيقاظ"),
              text: "أذكار الاستيقاظ",
              containerColor: AppColors.blue2,
              textColor: AppColors.blue1,
              image: ImageManager.morningImg,
            ),
            SizedBox(height: 10.h),
            AzkarItem(
              page: const AzkarForSleeping(title: "أذكار النوم"),
              text: "أذكار النوم",
              containerColor: AppColors.pink2,
              textColor: AppColors.pink1,
              image: ImageManager.bedImg,
            ),
            SizedBox(height: 10.h),
            AzkarItem(
              page: const AzkarForPray(title: "أذكار بعد الصلاة"),
              text: "أذكار بعد الصلاة",
              containerColor: AppColors.green2,
              textColor: AppColors.green1,
              image: ImageManager.prayImg,
            ),
          ],
        ),
      ),
    );
  }
}
