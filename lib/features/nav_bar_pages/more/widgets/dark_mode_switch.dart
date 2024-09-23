import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/app_theme.dart';
import 'package:quran_app/core/helpers/cache_helper.dart';
import 'package:quran_app/core/theming/colors.dart';

class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({Key? key, required this.themeCubit}) : super(key: key);
  final ThemeCubit themeCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, state) {
        return CupertinoSwitch(
          activeColor: ColorManager.orangeColor,
          thumbColor: ColorManager.white,
          value: themeCubit.isDarkMode,
          onChanged: (value) {
            themeCubit.toggleTheme();
            CacheHelper.put(key: 'isDarkMode', value: value);
          },
        );
      },
    );
  }
}

class DarkModeIconButton extends StatelessWidget {
  const DarkModeIconButton({Key? key, required this.themeCubit})
      : super(key: key);
  final ThemeCubit themeCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            themeCubit.toggleTheme();
            CacheHelper.put(
                key: 'isDarkMode',
                value: context.read<ThemeCubit>().isDarkMode);
          },
          child: Icon(
            context.read<ThemeCubit>().isDarkMode
                ? Icons.sunny
                : Icons.dark_mode_outlined,
            color: ColorManager.orangeColor,
            size: 25.sp,
          ),
        );
      },
    );
  }
}
