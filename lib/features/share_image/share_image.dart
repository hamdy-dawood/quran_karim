import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_app/core/helpers/app_theme.dart';
import 'package:quran_app/core/helpers/constants.dart';
import 'package:quran_app/core/helpers/navigate.dart';
import 'package:quran_app/core/theming/assets.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/features/nav_bar_pages/more/widgets/dark_mode_switch.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ShareImage extends StatelessWidget {
  const ShareImage({
    super.key,
    required this.surahNameEn,
    required this.ayah,
    required this.surahNameAr,
    required this.surahNumber,
  });

  final dynamic surahNameEn;
  final dynamic ayah;
  final dynamic surahNameAr;
  final int surahNumber;

  @override
  Widget build(BuildContext context) {
    final screenshotController = ScreenshotController();
    final themeCubit = context.read<ThemeCubit>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: BlocBuilder<ThemeCubit, ThemeData>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                MagicRouter.navigatePop();
              },
              color: context.read<ThemeCubit>().isDarkMode
                  ? ColorManager.white
                  : ColorManager.black,
              icon: const Icon(Icons.arrow_back_sharp),
            );
          },
        ),
        title: Text(
          "مشاركة الآية",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 18.sp,
            fontFamily: "cairo",
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: DarkModeIconButton(themeCubit: themeCubit),
          ),
        ],
      ),
      bottomSheet: GestureDetector(
        onTap: () async {
          final image = await screenshotController.capture();
          saveAndShare(image!);
        },
        child: Container(
          height: 40.h,
          width: 1.sw,
          // color: ColorManager.orangeColor,
          margin: EdgeInsets.all(10.h),
          child: Center(
            child: Text(
              "مشاركة",
              style: TextStyle(
                color: ColorManager.white,
                fontSize: 18.sp,
                fontFamily: "cairo",
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Screenshot(
            controller: screenshotController,
            child: Padding(
              padding: EdgeInsets.all(20.h),
              child: Container(
                padding: EdgeInsets.all(20.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 40,
                      child: Image.asset(
                        ImageManager.designImg,
                        fit: BoxFit.fill,
                        color: ColorManager.orangeColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: Text(
                        ayah,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: arabicFont,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "سُورَة $surahNameAr",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: arabicFont,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          surahNameEn,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 1.5,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Container(
                          decoration: BoxDecoration(
                            color: ColorManager.yellowColor,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                surahNumber.toString(),
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 100,
                      width: 40,
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: Image.asset(
                          ImageManager.designImg,
                          fit: BoxFit.fill,
                          color: ColorManager.orangeColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60.h,
          ),
        ],
      ),
    );
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytes(bytes);

    const text =
        "تمت المشاركة من تطبيق القرآن الكريم -  المصحف كامل , تفسير ميسر , أدعية وأذكار - شاركنا الثواب , شاركنا في الصدقة الجارية. \n https://play.google.com/store/apps/details?id=com.hamdy_khalid_dawood.quran_app";

    await Share.shareFiles([image.path], text: text);
  }
}
