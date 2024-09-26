import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:quran_app/core/helpers/cache_helper.dart';
import 'package:quran_app/core/theming/assets.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/core/widgets/app_bar.dart';
import 'package:quran_app/core/widgets/svg_icons.dart';
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
    String cachingSpeaker = CacheHelper.get(key: "speaker") ?? "";

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
              Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Slider(
                                min: 0,
                                max:
                                    appSoundCubit.duration.inSeconds.toDouble(),
                                value:
                                    appSoundCubit.position.inSeconds.toDouble(),
                                onChanged: (value) {
                                  appSoundCubit
                                      .seek(Duration(seconds: value.toInt()));
                                },
                                activeColor: Colors.deepOrange.withOpacity(0.8),
                                inactiveColor:
                                    Colors.deepOrange.withOpacity(0.3),

                              ),

                              // SizedBox(
                              //   height: 80,
                              //   // Adjust the height based on wave size
                              //   child: Stack(
                              //     alignment: Alignment.center,
                              //     children: [
                              //       // Wave-like background
                              //       Positioned.fill(
                              //         child: CustomPaint(
                              //           painter:
                              //               WavePainter(), // Custom wave painter
                              //         ),
                              //       ),
                              //
                              //       // Slider on top of the wave background
                              //       SliderTheme(
                              //         data: SliderTheme.of(context).copyWith(
                              //           trackHeight: 0, // Hide default track
                              //           thumbShape: const RoundSliderThumbShape(
                              //             enabledThumbRadius: 8,
                              //           ),
                              //           thumbColor: Colors.deepOrange,
                              //           overlayColor:
                              //               Colors.deepOrange.withOpacity(0.2),
                              //         ),
                              //         child: Slider(
                              //           min: 0,
                              //           max: appSoundCubit.duration.inSeconds
                              //               .toDouble(),
                              //           value: appSoundCubit.position.inSeconds
                              //               .toDouble(),
                              //           onChanged: (value) {
                              //             appSoundCubit.seek(
                              //                 Duration(seconds: value.toInt()));
                              //           },
                              //           activeColor: Colors.transparent,
                              //           inactiveColor: Colors.transparent,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
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

                          if (appSoundCubit.isPlaying) {
                            await appSoundCubit.pause();
                          } else {
                            String quranSoundUrl =
                                "https://server11.mp3quran.net/${CacheHelper.get(key: "speaker")}/${widget.urlSound}";

                            String afasySoundUrl =
                                "https://server8.mp3quran.net/${CacheHelper.get(key: "speaker")}/${widget.urlSound}";

                            String soundUrl = cachingSpeaker == "afs" ? afasySoundUrl : quranSoundUrl;

                            // Pass a file name for caching
                            await appSoundCubit.play(soundUrl, "${widget.urlSound}.mp3");
                          }
                        },
                        child: CircleAvatar(
                          radius: 33.r,
                          backgroundColor: ColorManager.orangeColor,
                          child: Icon(
                            appSoundCubit.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
                            size: 35.sp,
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
                  ),
                ],
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
