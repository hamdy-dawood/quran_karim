import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/cache_helper.dart';
import 'package:quran_app/core/helpers/navigate.dart';
import 'package:quran_app/core/theming/assets.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/core/widgets/svg_icons.dart';
import 'package:quran_app/features/nav_bar_pages/quran/widgets/last_read_widget.dart';
import 'package:quran_app/features/nav_bar_pages/sound/presentation/screens/speakers_screen.dart';

class SpeakerContainer extends StatelessWidget {
  const SpeakerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MagicRouter.navigateTo(page: const SpeakersScreen());
      },
      child: EmptyContainer(
        child: Row(
          children: [
            SvgIcon(
              icon: ImageManager.mushaf,
              height: 35.h,
              color: ColorManager.white,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "القاريء المفضل",
                    style: TextStyle(
                      color: ColorManager.white,
                      fontFamily: 'cairo',
                      fontSize: 18.sp,
                      // fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    CacheHelper.get(key: "speaker_name"),
                    style: TextStyle(
                      color: ColorManager.white,
                      fontFamily: 'cairo',
                      fontSize: 22.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
