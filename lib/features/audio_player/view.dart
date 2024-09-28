import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/constants.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/core/widgets/app_bar.dart';

class AudioPlayerView extends StatefulWidget {
  const AudioPlayerView({
    super.key,
    required this.urlSound,
    required this.ayah,
  });

  final String urlSound, ayah;

  @override
  State<AudioPlayerView> createState() => _AudioPlayerViewState();
}

class _AudioPlayerViewState extends State<AudioPlayerView> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String modifiedString =
        widget.urlSound.replaceAll("/", "").replaceAll("audio", "");

    return Scaffold(
      appBar: const CustomAppBar(
        text: "سماع الآية",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            SizedBox(height: 15.h),
            Container(
              padding: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                color: Theme.of(context).textTheme.displayMedium?.color,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                widget.ayah,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontFamily: arabicFont,
                  color: AppColors.orangeColor,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                    } else {
                      String url =
                          "https://www.everyayah.com/data/Ghamadi_40kbps/$modifiedString";
                      await audioPlayer.play(UrlSource(url));
                    }
                  },
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: AppColors.orangeColor,
                    size: 35.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    children: [
                      Slider(
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            position = Duration(seconds: value.toInt());
                          });
                        },
                        onChangeEnd: (value) {
                          audioPlayer.seek(position);
                        },
                        activeColor: Colors.deepOrange.withOpacity(0.8),
                        inactiveColor: Colors.deepOrange.withOpacity(0.3),
                        // divisions: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formatDuration(position)),
                          Text(formatDuration(duration - position)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    // Check if the duration has hours
    if (duration.inHours > 0) {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    } else {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
  }
}
