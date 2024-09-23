import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/navigate.dart';
import 'package:quran_app/core/theming/assets.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/core/widgets/svg_icons.dart';
import 'package:quran_app/features/mushaf/view.dart';

import 'last_read_widget.dart';

class MushafContainer extends StatelessWidget {
  const MushafContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MagicRouter.navigateTo(page: const MushafView());
      },
      child: EmptyContainer(
        child: Row(
          children: [
            SvgIcon(
              icon: AssetsStrings.mushaf,
              height: 35.h,
              color: ColorManager.white,
            ),
            SizedBox(width: 12.w),
            Text(
              "المصحف الشريف",
              style: TextStyle(
                color: ColorManager.white,
                fontFamily: 'amiri',
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
