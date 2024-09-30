import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quran_app/core/helpers/cache_helper.dart';
import 'package:quran_app/core/theming/assets.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/core/widgets/app_bar.dart';
import 'package:quran_app/core/widgets/emit_loading_item.dart';
import 'package:quran_app/core/widgets/svg_icons.dart';
import 'package:quran_app/features/nav_bar_pages/sound/presentation/cubit/sount_cubit.dart';

import '../cubit/sound_states.dart';

class SurahSoundView extends StatefulWidget {
  const SurahSoundView({
    super.key,
    required this.urlSound,
    required this.surahName,
  });

  final String urlSound, surahName;

  @override
  State<SurahSoundView> createState() => _SurahSoundViewState();
}

class _SurahSoundViewState extends State<SurahSoundView> {
  static int _nextMediaId = 0;

  @override
  void initState() {
    super.initState();
    String cachingSpeaker = CacheHelper.get(key: "speaker") ?? "";

    context
        .read<AppSoundCubit>()
        .checkIfDownLoaded("$cachingSpeaker/${widget.urlSound}");

    if (context.read<AppSoundCubit>().currentSurahPlayer != widget.urlSound ||
        context.read<AppSoundCubit>().currentSurahSpeaker != cachingSpeaker) {
      context.read<AppSoundCubit>().clearPosition();
    }

    context.read<AppSoundCubit>().onPlayerStateChanged();
  }

  @override
  Widget build(BuildContext context) {
    final appSoundCubit = context.read<AppSoundCubit>();
    String cachingSpeaker = CacheHelper.get(key: "speaker") ?? "";
    log("cachingSpeaker $cachingSpeaker");

    String quranSoundUrl =
        "https://server11.mp3quran.net/$cachingSpeaker/${widget.urlSound}";

    String afasySoundUrl =
        "https://server8.mp3quran.net/$cachingSpeaker/${widget.urlSound}";

    String soundUrl = cachingSpeaker == "afs" ? afasySoundUrl : quranSoundUrl;

    return Scaffold(
      appBar: CustomAppBar(
        text: "سُورَة ${widget.surahName}",
        fontSize: 25.sp,
        fontFamily: 'amiri',
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          BlocBuilder<AppSoundCubit, AppSoundStates>(
            builder: (context, state) {
              return Lottie.asset(
                ImageManager.lottieWaves,
                height: 0.45.sh,
                animate: appSoundCubit.isPlaying ? true : false,
              );
            },
          ),
          SizedBox(height: 0.04.sh),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: BlocBuilder<AppSoundCubit, AppSoundStates>(
              builder: (context, state) {
                return appSoundCubit.isDownloaded == false &&
                        appSoundCubit.isStartDownload == false
                    ? OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.orangeColor,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        onPressed: () {
                          appSoundCubit.downloadAndCacheFile(
                            soundUrl,
                            "$cachingSpeaker/${widget.urlSound}",
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "تحميل",
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                                fontFamily: 'cairo',
                              ),
                            ),
                            10.horizontalSpace,
                            SvgIcon(
                              icon: ImageManager.download,
                              height: 22.h,
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: BlocBuilder<AppSoundCubit, AppSoundStates>(
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
                                  radius: 35,
                                  lineWidth: 4,
                                  percent: appSoundCubit.percent,
                                  center: Text(
                                    appSoundCubit.percentText,
                                    style: TextStyle(
                                      fontSize: 18.sp,
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
                                10.horizontalSpace,
                                IconButton(
                                  onPressed: () {
                                    appSoundCubit.stopDownload();
                                  },
                                  icon: SvgIcon(
                                    icon: ImageManager.cancel,
                                    height: 30.h,
                                    color: AppColors.redPrimary,
                                  ),
                                ),
                              ],
                            );
                    });
              },
            ),
          ),
          SizedBox(height: 0.01.sh),
        ],
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocBuilder<AppSoundCubit, AppSoundStates>(
                        builder: (context, state) {
                          return Slider(
                            min: 0,
                            max: appSoundCubit.duration.inSeconds.toDouble(),
                            value: appSoundCubit.position.inSeconds.toDouble(),
                            onChanged: (value) {
                              appSoundCubit
                                  .seek(Duration(seconds: value.toInt()));
                            },
                            activeColor: Colors.deepOrange.withOpacity(0.8),
                            inactiveColor: Colors.deepOrange.withOpacity(0.3),
                          );
                        },
                      ),
                      // BlocBuilder<AppSoundCubit, AppSoundStates>(
                      //   builder: (context, state) {
                      //     return SizedBox(
                      //       height: 80,
                      //       child: Stack(
                      //         alignment: Alignment.center,
                      //         children: [
                      //           Positioned.fill(
                      //             child: CustomPaint(
                      //               painter:
                      //                   WavePainter(), // Custom wave painter
                      //             ),
                      //           ),
                      //           SliderTheme(
                      //             data: SliderTheme.of(context).copyWith(
                      //               trackHeight: 0,
                      //               thumbShape: const RoundSliderThumbShape(
                      //                 enabledThumbRadius: 8,
                      //               ),
                      //               thumbColor: Colors.deepOrange,
                      //               overlayColor:
                      //                   Colors.deepOrange.withOpacity(0.2),
                      //             ),
                      //             child: Slider(
                      //               min: 0,
                      //               max: appSoundCubit.duration.inSeconds
                      //                   .toDouble(),
                      //               value: appSoundCubit.position.inSeconds
                      //                   .toDouble(),
                      //               onChanged: (value) {
                      //                 appSoundCubit.seek(
                      //                     Duration(seconds: value.toInt()));
                      //               },
                      //               activeColor:
                      //                   Colors.deepOrange.withOpacity(0.5),
                      //               inactiveColor:
                      //                   Colors.deepOrange.withOpacity(0.3),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // ),
                      BlocBuilder<AppSoundCubit, AppSoundStates>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formatDuration(appSoundCubit.position),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                  fontFamily: 'cairo',
                                ),
                              ),
                              Text(
                                formatDuration(appSoundCubit.duration -
                                    appSoundCubit.position),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                  fontFamily: 'cairo',
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<AppSoundCubit, AppSoundStates>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      appSoundCubit.forward10Seconds();
                    },
                    icon: SvgIcon(
                      icon: ImageManager.forward10,
                      height: 30.h,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      appSoundCubit.currentSurahPlayer = widget.urlSound;
                      appSoundCubit.currentSurahSpeaker = cachingSpeaker;

                      if (appSoundCubit.isPlaying) {
                        await appSoundCubit.pause();
                      } else {
                        await appSoundCubit.play(
                          fileName: "$cachingSpeaker/${widget.urlSound}",
                          url: soundUrl,
                          mediaId: _nextMediaId++,
                          surahName: widget.surahName,
                          speaker: cachingSpeaker,
                        );
                      }
                    },
                    child: CircleAvatar(
                      radius: 33.r,
                      backgroundColor: AppColors.orangeColor,
                      child: BlocBuilder<AppSoundCubit, AppSoundStates>(
                        builder: (context, state) {
                          if (state is AppSoundLoadingState) {
                            return const DefaultSmallCircleIndicator();
                          }
                          return Icon(
                            appSoundCubit.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
                            size: 35.sp,
                          );
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      appSoundCubit.backward10Seconds();
                    },
                    icon: SvgIcon(
                      icon: ImageManager.backward10,
                      height: 30.h,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
              );
            },
          ),
          30.verticalSpace,
        ],
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n >= 10 ? "$n" : "0$n";

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    if (duration.inHours > 0) {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    } else {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.deepOrange.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    // Define path for the wave
    Path path = Path();
    path.moveTo(0, size.height * 0.5);

    // Create waves using cubic or quadratic curves
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.6,
        size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.4, size.width, size.height * 0.5);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
