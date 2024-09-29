import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:quran_app/core/helpers/constants.dart';
import 'package:quran_app/core/helpers/navigate.dart';
import 'package:quran_app/core/helpers/to_arabic_days.dart';
import 'package:quran_app/core/helpers/to_arabic_monthes.dart';
import 'package:quran_app/core/helpers/to_arabic_number_convertor.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/features/surah_design/presentation/screens/surah_screen.dart';

import 'widgets/last_read_widget.dart';
import 'widgets/mushaf_container.dart';

class QuranPageView extends StatelessWidget {
  const QuranPageView({super.key});

  @override
  Widget build(BuildContext context) {
    HijriCalendar hijriDate = HijriCalendar.now();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
                  child: Text(
                    hijriDate
                        .fullDate()
                        .toArabicNumbers
                        .toArabicMonths
                        .toArabicDays,
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontFamily: 'cairo',
                    ),
                  ),
                ),
              ),
              const MushafContainer(),
              const LastReadWidget(),
              SizedBox(height: 10.h),
              for (int i = 0; i < arabicName.length; i++)
                GestureDetector(
                  onTap: () {
                    fabIsClicked = false;
                    MagicRouter.navigateTo(
                      page: SurahPage(
                        arabic: quran[0],
                        tafser: tafser,
                        quranSound: quranSound,
                        surah: i,
                        surahName: arabicName[i]['name'],
                        type: arabicName[i]['type'],
                        count: arabicName[i]['verse_count'],
                        ayah: 0,
                      ),
                    );
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    margin: EdgeInsets.only(bottom: 10.h),
                    decoration: BoxDecoration(
                      color: Theme.of(context).listTileTheme.tileColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                arabicName[i]['name'],
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                  fontFamily: 'amiri',
                                ),
                              ),
                              Text(
                                "${arabicName[i]['type']} - آياتها ${arabicName[i]['verse_count'].toString().toArabicNumbers} آية",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                  fontFamily: 'cairo',
                                ),
                              ),
                            ],
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
                                arabicName[i]['surah']
                                    .toString()
                                    .toArabicNumbers,
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
      ),
    );
  }
}
