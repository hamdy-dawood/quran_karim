import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/theming/colors.dart';

import 'cache_helper.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit()
      : super(CacheHelper.get(key: 'isDarkMode') ?? false
            ? _darkTheme
            : _lightTheme) {
    isDarkMode = CacheHelper.get(key: 'isDarkMode') ?? false;
  }

  static final ThemeData _lightTheme = ThemeData(
    platform: TargetPlatform.iOS,
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.white,
    colorScheme: const ColorScheme.light(),
    appBarTheme: AppBarTheme(backgroundColor: AppColors.white),
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: AppColors.white),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.black),
      bodyMedium: const TextStyle(
        color: Color.fromARGB(196, 44, 44, 44),
      ),
      displayLarge: TextStyle(color: AppColors.displayLargeLight),
      displayMedium: TextStyle(color: AppColors.displayMediumLight),
    ),
    iconTheme: IconThemeData(color: AppColors.blueColor),
    listTileTheme: ListTileThemeData(tileColor: AppColors.grey),
    cardColor: const Color.fromARGB(255, 253, 251, 240),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: AppColors.white),
  );

  static final ThemeData _darkTheme = ThemeData(
    platform: TargetPlatform.iOS,
    scaffoldBackgroundColor: AppColors.black,
    primaryColor: AppColors.black,
    colorScheme: const ColorScheme.dark(),
    appBarTheme: AppBarTheme(backgroundColor: AppColors.black),
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: AppColors.black),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.white),
      bodyMedium: const TextStyle(
        color: Color(0xffd8d8d8),
      ),
      displayLarge: TextStyle(color: AppColors.displayLargeDark),
      displayMedium: TextStyle(color: AppColors.displayMediumDark),
    ),
    iconTheme: IconThemeData(color: AppColors.blueColor),
    listTileTheme: const ListTileThemeData(tileColor: Color(0xff202328)),
    cardColor: const Color(0x80202328),
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: Color(0xff202328)),
  );

  bool isDarkMode = false;

  ThemeData get theme => isDarkMode ? _darkTheme : _lightTheme;

  void toggleTheme() async {
    isDarkMode = !isDarkMode;
    emit(isDarkMode ? _darkTheme : _lightTheme);
    CacheHelper.put(key: 'isDarkMode', value: isDarkMode);
  }
}
