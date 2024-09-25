import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:quran_app/core/theming/assets.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/core/widgets/app_bar.dart';
import 'package:quran_app/features/nav_bar_pages/sound/presentation/cubit/sount_cubit.dart';

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
  @override
  void initState() {
    super.initState();

    if (context.read<AppSoundCubit>().currentSurahPlayer != widget.urlSound) {
      context.read<AppSoundCubit>().clearPosition();
    }

    context.read<AppSoundCubit>().onPlayerStateChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "سُورَة ${widget.surahName}",
        fontSize: 25.sp,
        fontFamily: 'amiri',
      ),
      body: BlocBuilder<AppSoundCubit, AppSoundStates>(
        builder: (context, state) {
          final appSoundCubit = context.read<AppSoundCubit>();

          return ListView(
            children: [
              SizedBox(height: 0.05.sh),
              Lottie.asset(
                ImageManager.lottieWaves,
                height: 0.5.sh,
                animate: appSoundCubit.isPlaying ? true : false,
              ),
              SizedBox(height: 0.05.sh),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        appSoundCubit.currentSurahPlayer = widget.urlSound;

                        if (appSoundCubit.isPlaying) {
                          await appSoundCubit.pause();
                        } else {
                          String quranSoundUrl =
                              "https://server11.mp3quran.net/yasser/${widget.urlSound}";
                          await appSoundCubit.play(quranSoundUrl);
                        }
                      },
                      child: Icon(
                        appSoundCubit.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: ColorManager.orangeColor,
                        size: 35.sp,
                      ),
                    ),
                    SizedBox(height: 0.1.sh),
                    // const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Slider(
                                  min: 0,
                                  max: appSoundCubit.duration.inSeconds
                                      .toDouble(),
                                  value: appSoundCubit.position.inSeconds
                                      .toDouble(),
                                  onChanged: (value) {
                                    appSoundCubit
                                        .seek(Duration(seconds: value.toInt()));
                                  },
                                  activeColor:
                                      Colors.deepOrange.withOpacity(0.8),
                                  inactiveColor:
                                      Colors.deepOrange.withOpacity(0.3),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        formatDuration(appSoundCubit.position)),
                                    Text(formatDuration(appSoundCubit.duration -
                                        appSoundCubit.position)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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
