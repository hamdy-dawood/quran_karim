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
  const AzkarView({Key? key}) : super(key: key);

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
              containerColor: ColorManager.orange2,
              textColor: ColorManager.orange1,
              image: AssetsStrings.sunnyImg,
            ),
            SizedBox(height: 10.h),
            AzkarItem(
              page: const AzkarForEvening(title: "أذكار المساء"),
              text: "اذكار المساء",
              containerColor: ColorManager.purple2,
              textColor: ColorManager.purple1,
              image: AssetsStrings.eveningImg,
            ),
            SizedBox(height: 10.h),
            AzkarItem(
              page: const AzkarForWaking(title: "أذكار الاستيقاظ"),
              text: "أذكار الاستيقاظ",
              containerColor: ColorManager.blue2,
              textColor: ColorManager.blue1,
              image: AssetsStrings.morningImg,
            ),
            SizedBox(height: 10.h),
            AzkarItem(
              page: const AzkarForSleeping(title: "أذكار النوم"),
              text: "أذكار النوم",
              containerColor: ColorManager.pink2,
              textColor: ColorManager.pink1,
              image: AssetsStrings.bedImg,
            ),
            SizedBox(height: 10.h),
            AzkarItem(
              page: const AzkarForPray(title: "أذكار بعد الصلاة"),
              text: "أذكار بعد الصلاة",
              containerColor: ColorManager.green2,
              textColor: ColorManager.green1,
              image: AssetsStrings.prayImg,
            ),
          ],
        ),
      ),
    );
  }
}
