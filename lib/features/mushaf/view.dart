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
  const MushafView({super.key, required this.filePath});

  final String filePath;

  @override
  Widget build(BuildContext context) {
    PdfController pdfController = PdfController(
      initialPage: CacheHelper.get(key: 'bookmark') ?? 0,
      viewportFraction: 1.2,
      document: PdfDocument.openFile(filePath),
    );

    return BlocProvider(
      create: (context) => MushafCubit(),
      child: _MushafBody(pdfController: pdfController),
    );
  }
}

class _MushafBody extends StatelessWidget {
  const _MushafBody({required this.pdfController});

  final PdfController pdfController;

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
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
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
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
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
                  pdfController.animateToPage(
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
              errorBuilder: (_, error) => Center(child: Text(error.toString())),
            ),
            scrollDirection: Axis.horizontal,
            controller: pdfController,
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
