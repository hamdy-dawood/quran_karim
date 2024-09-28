import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/cache_helper.dart';
import 'package:quran_app/core/helpers/constants.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/core/widgets/app_bar.dart';
import 'package:quran_app/core/widgets/snack_bar.dart';
import 'package:quran_app/features/quran_font/widgets/button_widget.dart';

import 'cubit.dart';
import 'states.dart';

class QuranFontView extends StatelessWidget {
  const QuranFontView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranFontCubit(),
      child: const _QuranFontBody(),
    );
  }
}

class _QuranFontBody extends StatelessWidget {
  const _QuranFontBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = QuranFontCubit.get(context);
    return Scaffold(
      appBar: const CustomAppBar(
        text: "حجم الخط",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            SizedBox(height: 50.h),
            BlocBuilder<QuranFontCubit, QuranFontStates>(
              builder: (context, state) {
                return Center(
                  child: Text(
                    "‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏",
                    style: TextStyle(
                      fontFamily: arabicFont,
                      fontSize: arabicFontSize,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                );
              },
            ),
            SizedBox(height: 20.h),
            BlocBuilder<QuranFontCubit, QuranFontStates>(
              builder: (context, state) {
                return Slider(
                  value: arabicFontSize,
                  activeColor: AppColors.orangeColor,
                  inactiveColor: AppColors.orangeColor.withOpacity(0.5),
                  min: 20,
                  max: 40,
                  onChanged: (value) {
                    cubit.onChangedSlider(value);
                  },
                );
              },
            ),
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ButtonWidget(
                    onTap: () {
                      cubit.restFont();
                    },
                    text: "إعادة ظبط",
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ButtonWidget(
                    onTap: () {
                      CacheHelper.put(
                          key: 'arabicFontSize', value: arabicFontSize);
                      showMessage(
                        message: "تم حفظ حجم الخط",
                        color: AppColors.greenWhatsColor,
                      );
                    },
                    text: "حفظ",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
