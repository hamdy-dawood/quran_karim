import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/cache_helper.dart';
import 'package:quran_app/core/helpers/constants.dart';
import 'package:quran_app/core/helpers/navigate.dart';
import 'package:quran_app/core/helpers/to_arabic_number_convertor.dart';
import 'package:quran_app/core/theming/assets.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/core/widgets/snack_bar.dart';
import 'package:quran_app/core/widgets/svg_icons.dart';
import 'package:quran_app/features/surah_design/presentation/screens/surah_screen.dart';

class LastReadWidget extends StatelessWidget {
  const LastReadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String surahString = "${CacheHelper.get(key: 'surah')}";
    int surah = CacheHelper.get(key: 'surah') ?? 1;
    int ayah = CacheHelper.get(key: 'ayah') ?? 1;

    return surahString != "null"
        ? GestureDetector(
            onTap: () {
              fabIsClicked = true;

              MagicRouter.navigateTo(
                page: SurahPage(
                  arabic: quran[0],
                  surah: surah - 1,
                  surahName: arabicName[surah - 1]['name'],
                  count: arabicName[surah - 1]['verse_count'],
                  type: arabicName[surah - 1]['type'],
                  ayah: ayah,
                ),
              );
            },
            child: EmptyContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgIcon(
                            icon: ImageManager.mushaf,
                            height: 30.h,
                            color: AppColors.white,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "آخر علامة",
                            style: TextStyle(
                              color: AppColors.white,
                              fontFamily: 'cairo',
                              fontSize: 20.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "سُورَة ${arabicName[surah - 1]['name']}",
                        style: TextStyle(
                          color: AppColors.white,
                          fontFamily: 'amiri',
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "${arabicName[surah - 1]['type']} - آياتها ${"${arabicName[surah - 1]['verse_count']}".toString().toArabicNumbers} آية",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.white,
                          fontFamily: 'cairo',
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
            ),
          )
        : GestureDetector(
            onTap: () {
              showMessage(
                message: "قم بحفظ الآية اولا للرجوع اليها من هنا",
                color: AppColors.redPrimary,
              );
            },
            child: const EmptyContainerFirst(),
          );
  }
}

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 14.w,
      ),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.orange2,
            AppColors.orangeColor,
          ],
          stops: const [
            0.02,
            0.9,
          ],
        ),
      ),
      child: child,
    );
  }
}

class EmptyContainerFirst extends StatelessWidget {
  const EmptyContainerFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgIcon(
                icon: ImageManager.mushaf,
                height: 40.h,
                color: AppColors.white,
              ),
              SizedBox(height: 10.h),
              Text(
                "القُرْآنُ الكَرِيمُ",
                style: TextStyle(
                  color: AppColors.white,
                  fontFamily: 'amiri',
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w600,
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
