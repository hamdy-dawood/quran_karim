import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/app_theme.dart';
import 'package:quran_app/core/helpers/navigate.dart';
import 'package:quran_app/core/theming/colors.dart';

showMessage({
  required String message,
  String? subMessage = "",
  int maxLines = 5,
  required Color color,
}) {
  ScaffoldMessenger.of(MagicRouter.currentContext).clearSnackBars();
  ScaffoldMessenger.of(MagicRouter.currentContext).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: MagicRouter.currentContext.read<ThemeCubit>().isDarkMode
          ? AppColors.black
          : AppColors.white,
      elevation: 2.0,
      content: Row(
        children: [
          Container(
            height: 40.h,
            width: 5.w,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3.r),
            ),
          ),
          SizedBox(width: 18.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontFamily: 'cairo',
                    color:
                        MagicRouter.currentContext.read<ThemeCubit>().isDarkMode
                            ? AppColors.white
                            : AppColors.black,
                  ),
                ),
                subMessage!.isNotEmpty
                    ? Text(
                        subMessage,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'cairo',
                          color: MagicRouter.currentContext
                                  .read<ThemeCubit>()
                                  .isDarkMode
                              ? AppColors.white
                              : AppColors.black,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(MagicRouter.currentContext).clearSnackBars();
            },
            child: Icon(
              Icons.close,
              color: MagicRouter.currentContext.read<ThemeCubit>().isDarkMode
                  ? AppColors.white
                  : AppColors.black,
            ),
          ),
        ],
      ),
    ),
  );
}
