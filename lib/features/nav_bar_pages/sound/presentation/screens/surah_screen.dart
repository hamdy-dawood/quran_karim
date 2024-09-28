import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/constants.dart';
import 'package:quran_app/core/helpers/navigate.dart';
import 'package:quran_app/core/helpers/to_arabic_number_convertor.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/core/widgets/app_bar.dart';

import '../widgets/speaker_container.dart';
import 'surah_sound_screen.dart';

class QuranSoundView extends StatelessWidget {
  const QuranSoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        text: "سماع القرآن",
        withLeading: false,
        withActions: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            SizedBox(height: 10.h),
            const SpeakerContainer(),
            SizedBox(height: 10.h),
            for (int i = 0; i < arabicName.length; i++)
              GestureDetector(
                onTap: () {
                  MagicRouter.navigateTo(
                    page: SurahSoundView(
                      urlSound: quranSound[i]['array'][0]['filename'],
                      surahName: arabicName[i]['name'],
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(
                      right: 10.w, left: 10.w, top: 20.h, bottom: 10.h),
                  margin: EdgeInsets.only(bottom: 10.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).listTileTheme.tileColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          arabicName[i]['name'],
                          style: TextStyle(
                            fontSize: 30.sp,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontFamily: 'amiri',
                          ),
                        ),
                      ),
                      Container(
                        height: 50.h,
                        width: 30.h,
                        decoration: BoxDecoration(
                          color: AppColors.yellowColor,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Center(
                          child: FittedBox(
                            child: Text(
                              arabicName[i]['surah'].toString().toArabicNumbers,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 22.sp,
                                fontFamily: 'amiri',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
