import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/app_theme.dart';
import 'package:quran_app/core/helpers/to_arabic_number_convertor.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/core/widgets/snack_bar.dart';
import 'package:share_plus/share_plus.dart';

class ZekrItem extends StatelessWidget {
  const ZekrItem({
    super.key,
    required this.number,
    required this.count,
    required this.text,
    required this.hintText,
  });
  final String number, count, text, hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: context.read<ThemeCubit>().isDarkMode
            ? ColorManager.displayMediumDark
            : ColorManager.displayMediumLight,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 35.h,
                width: 35.h,
                decoration: BoxDecoration(
                  color: ColorManager.yellowColor,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      number.toArabicNumbers,
                      style: TextStyle(
                        color: ColorManager.black,
                        fontSize: 22.sp,
                        fontFamily: 'amiri',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  height: 35.h,
                  decoration: BoxDecoration(
                    color: context.read<ThemeCubit>().isDarkMode
                        ? ColorManager.grey5
                        : ColorManager.offWhiteColor,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "عدد المرات :  ",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontSize: 14.sp,
                          fontFamily: "cairo",
                        ),
                        children: [
                          TextSpan(
                            text: count.toArabicNumbers,
                            style: TextStyle(
                              color: ColorManager.orangeColor,
                              fontSize: 14.sp,
                              fontFamily: "cairo",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(
                      ClipboardData(text: "{$text}. \n $hintText."));
                  showMessage(
                    message: "تم النسخ",
                    color: ColorManager.greenWhatsColor,
                  );
                },
                child: Icon(
                  Icons.copy,
                  color: ColorManager.orangeColor,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 20.w),
              GestureDetector(
                onTap: () {
                  Share.share(text);
                },
                child: Icon(
                  Icons.share_outlined,
                  color: ColorManager.orangeColor,
                  size: 22.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Text(
            text,
            style: TextStyle(
              fontSize: 25.sp,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontFamily: 'amiri',
            ),
          ),
          hintText.isNotEmpty
              ? Column(
                  children: [
                    Divider(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      thickness: 0.3,
                    ),
                    Text(
                      hintText,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontFamily: 'cairo',
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
