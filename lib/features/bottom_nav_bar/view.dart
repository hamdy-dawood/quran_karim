import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/app_theme.dart';
import 'package:quran_app/features/nav_bar_pages/azkar/view.dart';
import 'package:quran_app/features/nav_bar_pages/more/more_page.dart';
import 'package:quran_app/features/nav_bar_pages/quran/view.dart';
import 'package:quran_app/features/nav_bar_pages/sound/presentation/screens/surah_screen.dart';

import 'controller.dart';
import 'cubit.dart';
import 'states.dart';
import 'widgets/bottom_bar_item.dart';

class NavBarView extends StatefulWidget {
  const NavBarView({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<NavBarView> createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  final controller = NavBarController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> _buildScreens() => const [
    QuranPageView(),
    QuranSoundView(),
    AzkarView(),
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(controller, scaffoldKey),
      child: _NavBarBody(
        screens: _buildScreens(),
        initialIndex: widget.initialIndex,
      ),
    );
  }
}

class _NavBarBody extends StatelessWidget {
  const _NavBarBody({
    required this.screens,
    required this.initialIndex,
  });

  final List<Widget> screens;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    final cubit = NavBarCubit.get(context);
    cubit.controller.selectedItem = initialIndex;

    return BlocBuilder<NavBarCubit, NavBarStates>(
      builder: (context, state) {
        return Scaffold(
          key: cubit.scaffoldKey,
          body: screens[cubit.controller.selectedItem],
          bottomNavigationBar: _buildBottomNavBar(cubit, context),
        );
      },
    );
  }

  Widget _buildBottomNavBar(NavBarCubit cubit, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
      decoration: BoxDecoration(
        color: Theme.of(context).listTileTheme.tileColor,
        borderRadius: BorderRadius.circular(40.r),
      ),
      height: 0.1.sh,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) {
          return BottomBarItem(
            onPress: () => cubit.selectItem(index),
            icon: cubit.controller.icons[index],
            isSelected: index == cubit.controller.selectedItem,
          );
        }),
      ),
    );
  }
}
