import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/basmalah.dart';
import 'package:quran_app/core/helpers/to_arabic_number_convertor.dart';
import 'package:quran_app/core/theming/assets.dart';
import 'package:quran_app/core/theming/colors.dart';

class StartedSurahWidget extends StatelessWidget {
  const StartedSurahWidget({
    super.key,
    required this.surahName,
    required this.type,
    required this.count,
    required this.surah,
  });
  final String surahName, type, count;
  final dynamic surah;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorManager.orange2,
            ColorManager.orangeColor,
          ],
          stops: const [
            0.02,
            0.9,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: SizedBox(
              child: Image.asset(
                ImageManager.quranImg,
                height: surah + 1 != 1 && surah + 1 != 9 ? 160.h : 90.h,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Text(
                "سُورَة $surahName",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 40.sp,
                  color: ColorManager.black,
                  fontFamily: 'amiri',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.h,
                  horizontal: 40.w,
                ),
                child: Divider(
                  color: ColorManager.black,
                  thickness: 0.5,
                ),
              ),
              Text(
                "$type - آياتها ${count.toArabicNumbers} آية",
                style: TextStyle(
                  fontSize: 22.sp,
                  color: ColorManager.black,
                  fontFamily: 'cairo',
                ),
              ),
              surah + 1 != 1 && surah + 1 != 9
                  ? const ReturnBasmalah()
                  : const Text(''),
            ],
          ),
        ],
      ),
    );
  }
}
