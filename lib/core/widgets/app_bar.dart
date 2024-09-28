import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/app_theme.dart';
import 'package:quran_app/core/helpers/navigate.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/features/nav_bar_pages/more/widgets/dark_mode_switch.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.text,
    this.withLeading = true,
    this.withActions = true,
    this.fontFamily,
    this.fontSize,
  });
  final String text;
  final bool withLeading;
  final bool withActions;
  final String? fontFamily;
  final double? fontSize;

  @override
  Size get preferredSize => Size.fromHeight(50.h);

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return AppBar(
      elevation: 0,
      leading: withLeading
          ? BlocBuilder<ThemeCubit, ThemeData>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    MagicRouter.navigatePop();
                    ScaffoldMessenger.of(MagicRouter.currentContext)
                        .clearSnackBars();
                  },
                  color: context.read<ThemeCubit>().isDarkMode
                      ? AppColors.white
                      : AppColors.black,
                  icon: const Icon(Icons.arrow_back_sharp),
                );
              },
            )
          : const SizedBox.shrink(),
      title: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, state) {
          return FittedBox(
            child: Text(
              text,
              style: TextStyle(
                color: context.read<ThemeCubit>().isDarkMode
                    ? AppColors.white
                    : AppColors.black,
                fontSize: fontSize ?? 20.sp,
                fontFamily: fontFamily ?? 'cairo',
              ),
            ),
          );
        },
      ),
      centerTitle: true,
      actions: [
        withActions
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: DarkModeIconButton(themeCubit: themeCubit),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
