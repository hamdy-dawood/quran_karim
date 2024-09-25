import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/app_theme.dart';
import 'package:upgrader/upgrader.dart';

import 'core/helpers/cache_helper.dart';
import 'core/helpers/constants.dart';
import 'core/helpers/navigate.dart';
import 'features/nav_bar_pages/sound/presentation/cubit/sount_cubit.dart';
import 'features/splash/view.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await readJson();
      await readTafserJson();
      await readQuranSoundJson();
      await CacheHelper.get(key: "arabicFontSize");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ThemeCubit()),
              BlocProvider(create: (context) => AppSoundCubit()),
            ],
            child: BlocBuilder<ThemeCubit, ThemeData>(
              builder: (context, theme) {
                return MaterialApp(
                  title: "القرآن الكريم",
                  debugShowCheckedModeBanner: false,
                  navigatorKey: navigatorKey,
                  theme: theme,
                  supportedLocales: const [
                    Locale("ar"),
                  ],
                  locale: const Locale("ar"),
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  home: UpgradeAlert(
                    child: const SplashView(),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
