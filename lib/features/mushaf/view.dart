import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdfx/pdfx.dart';
import 'package:quran_app/core/helpers/cache_helper.dart';
import 'package:quran_app/core/helpers/navigate.dart';
import 'package:quran_app/core/theming/colors.dart';

import 'cubit.dart';
import 'states.dart';
import 'widgets/search_text_field.dart';

class MushafView extends StatelessWidget {
  const MushafView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MushafCubit(),
      child: const _MushafBody(),
    );
  }
}

class _MushafBody extends StatelessWidget {
  const _MushafBody();

  @override
  Widget build(BuildContext context) {
    final cubit = MushafCubit.get(context);
    return BlocBuilder<MushafCubit, MushafStates>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                MagicRouter.navigatePop();
                ScaffoldMessenger.of(MagicRouter.currentContext)
                    .clearSnackBars();
              },
              color: AppColors.black,
              icon: const Icon(Icons.arrow_back_sharp),
            ),
            title: state is QuranOffAddBookmark ||
                    cubit.bookmark == cubit.lastBooked
                ? IconButton(
                  onPressed: () async {
                    await cubit.addBookmark(context);
                  },
                  icon: Row(
                    children: [
                      Icon(
                        Icons.bookmark,
                        color: AppColors.limeGreenColor,
                        size: 40.sp,
                      ),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: Text(
                          "ازالة العلامة",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: "cairo",
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                : IconButton(
                  onPressed: () async {
                    await cubit.addBookmark(context);
                  },
                  icon: Row(
                    children: [
                      Icon(
                        Icons.bookmark_add,
                        color: AppColors.yellowColor,
                        size: 35.sp,
                      ),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: Text(
                          "حفظ الصفحة",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: "cairo",
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            actions: [
              SearchTextField(
                controller: cubit.num,
                onFieldSubmitted: (value) {
                  cubit.pdfController.animateToPage(
                    int.parse(value) + 3,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.ease,
                  );
                },
              ),
            ],
          ),
          body: PdfView(
            builders: PdfViewBuilders<DefaultBuilderOptions>(
              options: const DefaultBuilderOptions(),
              documentLoaderBuilder: (_) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              ),
              pageLoaderBuilder: (_) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              ),
              errorBuilder: (_, error) =>
                  Center(child: Text(error.toString())),
            ),
            scrollDirection: Axis.horizontal,
            controller: cubit.pdfController,
            onDocumentLoaded: (pd) {
              cubit.bookmark = CacheHelper.get(key: 'bookmark') ?? 0;
              cubit.getBookmark();
            },
            onPageChanged: (i) async {
              cubit.bookmark = i;
              await cubit.getBookmark();
            },
          ),
        );
      },
    );
  }
}

//class MushafBody extends StatefulWidget {
//   const MushafBody({super.key});
//
//   @override
//   _MushafBodyState createState() => _MushafBodyState();
// }
//
// class _MushafBodyState extends State<MushafBody> {
//   late Future<List<FirebaseFile>> futureFiles;
//
//   @override
//   void initState() {
//     super.initState();
//     futureFiles = FirebaseApi.listAll('mushaf/');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PDF Viewer'),
//       ),
//       body: FutureBuilder<List<FirebaseFile>>(
//         future: futureFiles,
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting:
//               return const Center(child: CircularProgressIndicator());
//             default:
//               if (snapshot.hasError) {
//                 return const Center(child: Text('Some error occurred!'));
//               } else {
//                 final files = snapshot.data!;
//
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: files.length,
//                         itemBuilder: (context, index) {
//                           final file = files[index];
//
//                           print("xx: ${file.name}  cc:${file.ref}  url:${file.url}");
//
//                            FirebaseApi.downloadFile(files[1].ref).whenComplete((){
//                              print("xxxxxxxxxxxxx");
//                              SnackBar(
//                                content: Text('Downloaded ${file.name}'),
//                              );
//                            });
//
//                           return buildFile(context, file);
//                         },
//                       ),
//                     ),
//                   ],
//                 );
//               }
//           }
//         },
//       ),
//     );
//   }
//
//   Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
//         title: Text(
//           file.name,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             decoration: TextDecoration.underline,
//             color: Colors.blue,
//           ),
//         ),
//         // onTap: () => Navigator.of(context).push(MaterialPageRoute(
//         //   builder: (context) => ImagePage(file: file),
//         // )),
//       );
// }
//
// class ImagePage extends StatelessWidget {
//   final FirebaseFile file;
//
//   const ImagePage({
//     super.key,
//     required this.file,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final isImage = ['.jpeg', '.jpg', '.png'].any(file.name.contains);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(file.name),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.file_download),
//             onPressed: () async {
//               await FirebaseApi.downloadFile(file.ref);
//
//               final snackBar = SnackBar(
//                 content: Text('Downloaded ${file.name}'),
//               );
//               ScaffoldMessenger.of(context).showSnackBar(snackBar);
//             },
//           ),
//           const SizedBox(width: 12),
//         ],
//       ),
//       body: isImage
//           ? Image.network(
//               file.url,
//               height: double.infinity,
//               fit: BoxFit.cover,
//             )
//           : const Center(
//               child: Text(
//                 'Cannot be displayed',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//     );
//   }
// }
