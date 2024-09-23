import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/helpers/cache_helper.dart';
import 'package:quran_app/core/helpers/constants.dart';

import 'states.dart';

class QuranFontCubit extends Cubit<QuranFontStates> {
  QuranFontCubit() : super(QuranFontInitialState());

  static QuranFontCubit get(context) => BlocProvider.of(context);

  void onChangedSlider(value) {
    arabicFontSize = value;
    emit(OnChangedSliderState());
  }

  void restFont() {
    arabicFontSize = 28;
    CacheHelper.put(key: 'arabicFontSize', value: arabicFontSize);
    emit(RestFontState());
  }
}
