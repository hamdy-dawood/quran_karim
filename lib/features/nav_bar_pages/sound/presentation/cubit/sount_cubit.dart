import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_app/core/helpers/constants.dart';

import '../data/models/speakers_model.dart';
import 'sound_states.dart';

class AppSoundCubit extends Cubit<AppSoundStates> {
  AppSoundCubit() : super(AppSoundInitialState());

  static AppSoundCubit get(context) => BlocProvider.of(context);

  AudioPlayer player = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;
  bool isStartDownload = false;
  bool isDownloaded = true;
  double percent = 0;
  String percentText = "0%";
  ValueNotifier downloadProgressNotifier = ValueNotifier(0);

  String currentSurahPlayer = "";
  String currentSurahSpeaker = "";
  Dio dio = Dio();

  Future<void> checkIfDownLoaded(String fileName) async {
    String filePath = await _getCacheFilePath(fileName);
    File file = File(filePath);
    if (await file.exists()) {
      isDownloaded = true;
    } else {
      isDownloaded = false;
    }

    log("isDownloaded $isDownloaded");

    emit(CheckIfDownLoadedState());
  }

  Future<String> _getCacheFilePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/$fileName";
  }

  Future<void> play({
    required String fileName,
    required String url,
    required int mediaId,
    required String surahName,
    required String speaker,
  }) async {
    AudioSource audioSource;

    if (!kIsWeb) {
      String filePath = await _getCacheFilePath(fileName);
      File file = File(filePath);

      if (await file.exists() && speaker == currentSurahSpeaker) {
        audioSource = AudioSource.uri(
          Uri.file(filePath),
          tag: MediaItem(
            id: '$mediaId',
            title: "سُورَة $surahName",
            album: "القرآن الكريم",
            artUri: Uri.parse(logoImageNetwork),
          ),
        );
      } else {
        audioSource = AudioSource.uri(
          Uri.parse(url),
          tag: MediaItem(
            id: '$mediaId',
            title: "سُورَة $surahName",
            album: "القرآن الكريم",
            artUri: Uri.parse(logoImageNetwork),
          ),
        );
      }
    } else {
      audioSource = AudioSource.uri(
        Uri.parse(url),
        tag: MediaItem(
          id: '$mediaId',
          title: "سُورَة $surahName",
          album: "القرآن الكريم",
          artUri: Uri.parse(logoImageNetwork),
        ),
      );
    }

    // Only set the audio source once when starting playback
    if (player.audioSource == null) {
      await player.setAudioSource(audioSource, preload: true);
    }
    // Play the audio (resume if already paused)
    player.play();
    isPlaying = true;
    emit(AppSoundPlayingState());
  }

  CancelToken cancelToken = CancelToken();

  void stopDownload() {
    isStartDownload = false;
    isDownloaded = false;
    downloadProgressNotifier.value = 0;
    cancelToken.cancel("Download canceled by the user");
    emit(StopDownLoadState());
  }

  Future<void> downloadAndCacheFile(String url, String fileName) async {
    cancelToken = CancelToken();
    isStartDownload = true;
    downloadProgressNotifier.value = 0;
    String filePath = await _getCacheFilePath(fileName);
    emit(StartDownLoadingState());

    try {
      Response response = await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          downloadProgressNotifier.value = (received / total * 100).floor();

          percent = downloadProgressNotifier.value / 100;
          percentText = "${downloadProgressNotifier.value}%";
        },
        cancelToken: cancelToken,
      );
      if (response.statusCode == 200) {
        isDownloaded = true;
        isStartDownload = false;
        emit(CheckIfDownLoadedState());
        log("File downloaded successfully: $filePath");
      }
    } catch (e) {
      log("Failed to downloaded the file: $e");
      isStartDownload = false;
      emit(ErrorDownLoadState());
    }
  }

  Future<void> pause() async {
    await player.pause();
    isPlaying = false;
    emit(AppSoundPausedState());
  }

  Future<void> resume() async {
    if (!player.playing) {
      await player.play();
      isPlaying = true;
      emit(AppSoundResumedState());
    }
  }

  void seek(Duration newPosition) {
    player.seek(newPosition);
  }

  void onPlayerStateChanged() {
    player.playerStateStream.listen((state) {
      isPlaying = state.playing;

      if (state.processingState == ProcessingState.loading) {
        emit(AppSoundLoadingState());
      }

      if (state.processingState == ProcessingState.completed) {
        seek(Duration.zero);
        resume();
      }
    });

    player.durationStream.listen((newDuration) {
      if (newDuration != null) {
        duration = newDuration;
        emit(DurationStreamState());
      }
    });

    player.positionStream.listen((newPosition) {
      position = newPosition;
      emit(PositionStreamState());
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
    player.stop();
    player.seek(Duration.zero);
    duration = Duration.zero;
    position = Duration.zero;
    isPlaying = false;
    isStartDownload = false;
    isDownloaded = true;
    percent = 0;
    percentText = "0%";
    player.dispose();
    player = AudioPlayer();
    log("position cleared");
    log("isPlaying $isPlaying");
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
