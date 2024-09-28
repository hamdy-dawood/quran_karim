import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/app_theme.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/core/widgets/svg_icons.dart';

class BottomBarItem extends StatelessWidget {
  final String icon;
  final bool isSelected;
  final VoidCallback onPress;

  const BottomBarItem({
    super.key,
    required this.icon,
    this.isSelected = true,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPress,
        child: SvgIcon(
          icon: icon,
          height: isSelected ? 45.sp : 30.sp,
          color: isSelected
              ? AppColors.orangeColor
              : context.read<ThemeCubit>().isDarkMode
                  ? AppColors.grey.withOpacity(0.7)
                  : AppColors.darkGrey,
        ),
      ),
    );
  }
}
