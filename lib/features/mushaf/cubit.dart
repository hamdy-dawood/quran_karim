import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfx/pdfx.dart';
import 'package:quran_app/core/helpers/cache_helper.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/core/widgets/snack_bar.dart';

import 'states.dart';

class MushafCubit extends Cubit<MushafStates> {
  MushafCubit() : super(MushafInitialState());

  static MushafCubit get(context) => BlocProvider.of(context);

  TextEditingController num = TextEditingController();
  int? bookmark = 0;

  addBookmark(BuildContext context) async {
    emit(QuranOffLoadingBookmark());
    int lastBooked = CacheHelper.get(key: 'bookmark') ?? 0;
    if (bookmark == lastBooked) {
      CacheHelper.removeData(key: 'bookmark');
      showMessage(
        message: "تم ازالة العلامة",
        color: AppColors.redPrimary,
      );
      getBookmark();
    } else {
      await CacheHelper.put(key: 'bookmark', value: bookmark);
      showMessage(
        message: "تم وضع علامة",
        color: AppColors.limeGreenColor,
      );

      emit(QuranOffAddBookmark());
    }
  }

  int lastBooked = 0;

  getBookmark() async {
    emit(QuranOffGetLoadingBookmark());
    lastBooked = CacheHelper.get(key: 'bookmark') ?? 0;
    if (lastBooked == bookmark) {
      emit(QuranOffGetBookmark());
    } else {
      emit(QuranOffGetBookmark());
    }
  }
}


class FirebaseFile {
  final Reference ref;
  final String name;
  final String url;

  const FirebaseFile({
    required this.ref,
    required this.name,
    required this.url,
  });
}
