import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quran_app/core/helpers/constants.dart';
import 'package:quran_app/core/helpers/navigate.dart';
import 'package:quran_app/core/theming/assets.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/core/widgets/emit_loading_item.dart';
import 'package:quran_app/core/widgets/snack_bar.dart';
import 'package:quran_app/core/widgets/svg_icons.dart';
import 'package:quran_app/features/mushaf/view.dart';
import 'package:quran_app/features/nav_bar_pages/sound/presentation/cubit/sound_states.dart';
import 'package:quran_app/features/nav_bar_pages/sound/presentation/cubit/sount_cubit.dart';

import 'last_read_widget.dart';

class MushafContainer extends StatefulWidget {
  const MushafContainer({super.key});

  @override
  State<MushafContainer> createState() => _MushafContainerState();
}

class _MushafContainerState extends State<MushafContainer> {
  Future<String> _getCacheFilePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/$fileName";
  }

  @override
  Widget build(BuildContext context) {
    final appSoundCubit = context.read<AppSoundCubit>();

    return GestureDetector(
      onTap: () async {
        if (!kIsWeb) {
          String filePath = await _getCacheFilePath("mushaf_mode_pdf.pdf");
          File file = File(filePath);

          if (await file.exists()) {
            MagicRouter.navigateTo(page: MushafView(filePath: filePath));
          } else {
            appSoundCubit.downloadAndCacheFile(
              mushafPdfLink,
              "mushaf_mode_pdf.pdf",
            );
            showMessage(
              message: "يتم الان تحميل المصحف الشريف",
              color: AppColors.greenWhatsColor,
            );
          }
        }
      },
      child: EmptyContainer(
        child: Row(
          children: [
            SvgIcon(
              icon: ImageManager.mushaf,
              height: 35.h,
              color: AppColors.white,
            ),
            SizedBox(width: 12.w),
            Text(
              "المصحف الشريف",
              style: TextStyle(
                color: AppColors.white,
                fontFamily: 'amiri',
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            BlocBuilder<AppSoundCubit, AppSoundStates>(
              builder: (context, state) {
                return ValueListenableBuilder(
                    valueListenable: appSoundCubit.downloadProgressNotifier,
                    builder: (context, value, snapshot) {
                      if (state is StartDownLoadingState &&
                          appSoundCubit.downloadProgressNotifier.value == 0) {
                        return const DefaultSmallCircleIndicator();
                      }
                      return appSoundCubit.downloadProgressNotifier.value ==
                                  0 ||
                              appSoundCubit.downloadProgressNotifier.value ==
                                  100
                          ? const SizedBox()
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularPercentIndicator(
                                  radius: 20,
                                  lineWidth: 2,
                                  percent: appSoundCubit.percent,
                                  center: Text(
                                    appSoundCubit.percentText,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.color,
                                      fontFamily: 'cairo',
                                    ),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: AppColors.orangeColor,
                                ),
                                2.horizontalSpace,
                                IconButton(
                                  onPressed: () {
                                    appSoundCubit.stopDownload();
                                  },
                                  icon: SvgIcon(
                                    icon: ImageManager.cancel,
                                    height: 20.h,
                                    color: AppColors.redPrimary,
                                  ),
                                ),
                              ],
                            );
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
