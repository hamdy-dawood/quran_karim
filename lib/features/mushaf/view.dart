import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdfx/pdfx.dart';
import 'package:quran_app/core/helpers/cache_helper.dart';
import 'package:quran_app/core/helpers/navigate.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/features/mushaf/widgets/search_text_field.dart';

import 'cubit.dart';
import 'states.dart';
import 'widgets/custom_text_button.dart';

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
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50.h,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SearchTextField(
                      controller: cubit.num,
                      onFieldSubmitted: (value) {
                        cubit.pdfController.animateToPage(
                          int.parse(value),
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.ease,
                        );
                      },
                    ),
                    CustomTextButton(
                      onPressed: () {
                        cubit.pdfController.animateToPage(
                          int.parse(cubit.num.text),
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.ease,
                        );
                      },
                      text: "اذهب",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    PdfView(
                      builders: PdfViewBuilders<DefaultBuilderOptions>(
                        options: const DefaultBuilderOptions(),
                        documentLoaderBuilder: (_) => Center(
                          child: CircularProgressIndicator(
                            color: AppColors.orangeColor,
                          ),
                        ),
                        pageLoaderBuilder: (_) => Center(
                          child: CircularProgressIndicator(
                            color: AppColors.orangeColor,
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
                    state is QuranOffAddBookmark ||
                            cubit.bookmark == cubit.lastBooked
                        ? Positioned(
                            left: 10,
                            top: 10,
                            child: IconButton(
                              onPressed: () async {
                                await cubit.addBookmark(context);
                              },
                              icon: Icon(
                                Icons.bookmark,
                                color: AppColors.limeGreenColor,
                                size: 60.sp,
                              ),
                            ),
                          )
                        : Positioned(
                            left: 20,
                            top: 15,
                            child: IconButton(
                              onPressed: () async {
                                await cubit.addBookmark(context);
                              },
                              icon: Icon(
                                Icons.bookmark_add,
                                color: AppColors.yellowColor,
                                size: 40.sp,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
