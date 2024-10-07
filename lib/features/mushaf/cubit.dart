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

  final pdfController = PdfController(
    initialPage: CacheHelper.get(key: 'bookmark') ?? 0,
    viewportFraction: 1.2,
    document: PdfDocument.openAsset('assets/pdf/quran.pdf'),
  );

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

// Future<File?> downloadPDF(String pdfPath) async {
//   try {
//     final storageRef = FirebaseStorage.instance.ref().child(pdfPath);
//     final tempDir = await getTemporaryDirectory();
//     final tempFile = File('${tempDir.path}/downloaded_pdf.pdf');
//     await storageRef.writeToFile(tempFile);
//     return tempFile;
//   } catch (e) {
//     print('Error downloading PDF: $e');
//     return null;
//   }
// }
}

//=============================================================================

// class FirebaseApi {
//   static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
//       Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());
//
//   static Future<List<FirebaseFile>> listAll(String path) async {
//     final ref = FirebaseStorage.instance.ref(path);
//     final result = await ref.listAll();
//
//     final urls = await _getDownloadLinks(result.items);
//
//     return urls
//         .asMap()
//         .map((index, url) {
//           final ref = result.items[index];
//           final name = ref.name;
//           final file = FirebaseFile(ref: ref, name: name, url: url);
//
//           return MapEntry(index, file);
//         })
//         .values
//         .toList();
//   }
//
//   static Future downloadFile(Reference ref) async {
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File('${dir.path}/${ref.name}');
//
//     await ref.writeToFile(file);
//   }
// }

//=============================================================================

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
