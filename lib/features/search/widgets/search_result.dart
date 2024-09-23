import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/app_theme.dart';
import 'package:quran_app/core/helpers/cache_helper.dart';
import 'package:quran_app/core/helpers/constants.dart';
import 'package:quran_app/core/helpers/navigate.dart';
import 'package:quran_app/core/helpers/to_arabic_number_convertor.dart';
import 'package:quran_app/features/surah_design/surah.dart';

class BuildSearchResult extends StatelessWidget {
  const BuildSearchResult({super.key, required this.results});

  final List<Map<String, dynamic>> results;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> item = results[index];
            return GestureDetector(
              onTap: () {
                fabIsClicked = true;

                MagicRouter.navigateReplacement(
                  page: SurahPage(
                    arabic: quran[0],
                    tafser: tafser,
                    quranSound: quranSound,
                    surah: item['sura_no'] - 1,
                    surahName: "${item['sura_name_ar']}",
                    type: arabicName[item['sura_no'] - 1]['type'],
                    count: arabicName[item['sura_no'] - 1]['verse_count'],
                    ayah: item['aya_no'] - 1,
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: BlocBuilder<ThemeCubit, ThemeData>(
                  builder: (context, state) {
                    return Container(
                      padding: EdgeInsets.all(10.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context).textTheme.displayMedium?.color,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "سُورَة ${item["sura_name_ar"]}",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color,
                                    fontFamily: 'amiri',
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "رقم الآية : ",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                  fontFamily: 'cairo',
                                ),
                              ),
                              Text(
                                "${item["aya_no"]}".toArabicNumbers,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                  fontFamily: 'cairo',
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            thickness: 0.3,
                          ),
                          Text(
                            item["aya_text"],
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: arabicFontSize,
                              fontFamily: arabicFont,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
