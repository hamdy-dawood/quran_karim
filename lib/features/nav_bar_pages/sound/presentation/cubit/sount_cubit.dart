import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  Future<void> play(String url) async {
    await player.play(UrlSource(url));
    isPlaying = true;
    emit(AppSoundPlayingState());
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
    });
  }

  Future<void> clearPosition() async {
    await player.stop();
    duration = Duration.zero;
    position = Duration.zero;
    isPlaying = false;
    emit(AppSoundClearedState());
  }

  @override
  Future<void> close() async {
    player.dispose();
    return super.close();
  }
}
