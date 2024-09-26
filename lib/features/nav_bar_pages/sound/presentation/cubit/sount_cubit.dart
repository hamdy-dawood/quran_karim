import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../data/models/speakers_model.dart';

abstract class AppSoundStates {}

class AppSoundInitialState extends AppSoundStates {}

class AppSoundPlayingState extends AppSoundStates {}

class AppSoundPausedState extends AppSoundStates {}

class AppSoundStoppedState extends AppSoundStates {}

class AppSoundClearedState extends AppSoundStates {}

//==============================================================================

class AppSoundCubit extends Cubit<AppSoundStates> {
  AppSoundCubit() : super(AppSoundInitialState());

  static AppSoundCubit get(context) => BlocProvider.of(context);

  AudioPlayer player = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;

  String currentSurahPlayer = "";
  Dio dio = Dio();

  Future<String> _getCacheFilePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/$fileName";
  }

  Future<void> play(String url, String fileName) async {
    String filePath = await _getCacheFilePath(fileName);
    File file = File(filePath);

    if (await file.exists()) {
      // Play from cache if file exists
      await player.play(DeviceFileSource(filePath));
    } else {
      // Download and cache the file if it doesn't exist
      await _downloadAndCacheFile(url, filePath);
      await player.play(DeviceFileSource(filePath));
    }

    isPlaying = true;
    emit(AppSoundPlayingState());
  }

  Future<void> _downloadAndCacheFile(String url, String savePath) async {
    try {
      Response response = await dio.download(url, savePath);
      if (response.statusCode == 200) {
        log("File downloaded successfully: $savePath");
      }
    } catch (e) {
      log("Failed to download the file: $e");
    }
  }

  Future<void> pause() async {
    await player.pause();
    isPlaying = false;
    emit(AppSoundPausedState());
  }

  Future<void> resume() async {
    await player.resume();
    isPlaying = true;
    emit(AppSoundPlayingState());
  }

  void seek(Duration newPosition) {
    player.seek(newPosition);
  }

  void onPlayerStateChanged() {
    player.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
      emit(isPlaying ? AppSoundPlayingState() : AppSoundPausedState());
    });

    player.onDurationChanged.listen((newDuration) {
      duration = newDuration;
      emit(AppSoundPlayingState());
    });

    player.onPositionChanged.listen((newPosition) {
      position = newPosition;
      emit(AppSoundPlayingState());

      // Check if the audio has finished

      log("position: $position, duration: $duration");
      if (position >= duration && duration != Duration.zero) {
        // Repeat the audio by seeking to the beginning
        seek(Duration.zero);
        player.resume(); // Play the audio again
        emit(AppSoundPlayingState());
      }
    });
  }


  void forward10Seconds() {
    final newPosition = position - const Duration(seconds: 10);
    if (newPosition > Duration.zero) {
      seek(newPosition);
    } else {
      seek(Duration.zero);
    }
  }

  void backward10Seconds() {
    final newPosition = position + const Duration(seconds: 10);
    if (newPosition < duration) {
      seek(newPosition);
    } else {
      seek(duration);
    }
  }

  Future<void> clearPosition() async {
    await player.stop();
    duration = Duration.zero;
    position = Duration.zero;
    isPlaying = false;
    emit(AppSoundClearedState());
  }

  //========================== SPEAKERS ============================//

  List<SpeakersModel> speakersList = [
    SpeakersModel(
      nameId: "sds",
      displayName: "عبد الرحمن السديس",
    ),
    SpeakersModel(
      nameId: "jormy",
      displayName: "أحمد علي العجمي",
    ),
    SpeakersModel(
      nameId: "yasser",
      displayName: "ياسر الدوسري",
    ),
    SpeakersModel(
      nameId: "afs",
      displayName: "مشاري العفاسي",
    ),
    SpeakersModel(
      nameId: "a_jbr",
      displayName: "علي جابر",
    ),
    SpeakersModel(
      nameId: "hazza",
      displayName: "هزاع البلوشي",
    ),
    SpeakersModel(
      nameId: "ahmad_nu",
      displayName: "أحمد نعينع",
    ),
    SpeakersModel(
      nameId: "hatem",
      displayName: "حاتم فريد الواعر",
    ),
    SpeakersModel(
      nameId: "a_ahmed",
      displayName: "عبدالعزيز الأحمد",
    ),
    SpeakersModel(
      nameId: "Othmn",
      displayName: "عثمان الأنصاري",
    ),
    SpeakersModel(
      nameId: "shatri",
      displayName: "أبو بكر الشاطري",
    ),
    SpeakersModel(
      nameId: "bilal",
      displayName: "موسي بلال",
    ),
    SpeakersModel(
      nameId: "hawashi",
      displayName: "احمد الحواشي",
    ),
    SpeakersModel(
      nameId: "koshi",
      displayName: "العيون الكوشي",
    ),
    SpeakersModel(
      nameId: "mhsny",
      displayName: "محمد المحيسني",
    ),
    SpeakersModel(
      nameId: "mrifai",
      displayName: "محمد الرفاعي",
    ),
    SpeakersModel(
      nameId: "kafi",
      displayName: "خالد عبد الكافي",
    ),
    SpeakersModel(
      nameId: "mohna",
      displayName: "خالد المهنا",
    ),
  ];

  @override
  Future<void> close() async {
    player.dispose();
    return super.close();
  }
}
