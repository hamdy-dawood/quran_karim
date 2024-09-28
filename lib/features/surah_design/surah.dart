import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/app_theme.dart';
import 'package:quran_app/core/helpers/cache_helper.dart';
import 'package:quran_app/core/helpers/constants.dart';
import 'package:quran_app/core/helpers/navigate.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/core/widgets/snack_bar.dart';
import 'package:quran_app/features/audio_player/view.dart';
import 'package:quran_app/features/bottom_nav_bar/view.dart';
import 'package:quran_app/features/nav_bar_pages/more/widgets/dark_mode_switch.dart';
import 'package:quran_app/features/search/view.dart';
import 'package:quran_app/features/share_image/share_image.dart';
import 'package:quran_app/features/tafser/view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'widgets/ayah.dart';
import 'widgets/container_list.dart';
import 'widgets/started_surah.dart';

class SurahPage extends StatefulWidget {
  final dynamic arabic;
  final dynamic tafser;
  final dynamic quranSound;
  final int surah;
  final String surahName, type, count;
  final int ayah;

  const SurahPage({
    super.key,
    this.arabic,
    this.tafser,
    this.quranSound,
    required this.surah,
    required this.surahName,
    required this.ayah,
    required this.type,
    required this.count,
  });

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  bool listViewMode = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      jumpToAyah();
    });
    super.initState();
  }

  jumpToAyah() {
    if (fabIsClicked) {
      itemScrollController.scrollTo(
          index: widget.ayah,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOutCubic);
    }
    fabIsClicked = false;
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    int previousVerses = 0;
    int lengthOfSura = numberOfVerses[widget.surah];
    String fullSura = "";

    if (widget.surah + 1 != 1) {
      for (int i = widget.surah - 1; i >= 0; i--) {
        previousVerses = previousVerses + numberOfVerses[i];
      }
    }

    if (!listViewMode) {
      for (int i = 0; i < lengthOfSura; i++) {
        fullSura += "${(widget.arabic[i + previousVerses]['aya_text'])} ";
      }
    }

    return WillPopScope(
      onWillPop: () async {
        MagicRouter.navigateTo(
          page: const NavBarView(),
          withHistory: false,
        );
        ScaffoldMessenger.of(MagicRouter.currentContext).clearSnackBars();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BlocBuilder<ThemeCubit, ThemeData>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  MagicRouter.navigateTo(
                    page: const NavBarView(),
                    withHistory: false,
                  );
                  ScaffoldMessenger.of(MagicRouter.currentContext)
                      .clearSnackBars();
                },
                color: context.read<ThemeCubit>().isDarkMode
                    ? AppColors.white
                    : AppColors.black,
                icon: const Icon(Icons.arrow_back_sharp),
              );
            },
          ),
          elevation: 0.0,
          title: FittedBox(
            child: Text(
              "سُورَة ${widget.surahName}",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 25.sp,
                color: AppColors.orangeColor,
                fontFamily: 'amiri',
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                MagicRouter.navigateTo(page: const SearchView());
              },
              icon: const Icon(Icons.search),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: DarkModeIconButton(themeCubit: themeCubit),
            ),
            SizedBox(width: 15.w),
            // Tooltip(
            //   message: 'Mushaf Mode',
            //   child: TextButton(
            //     child: const Icon(
            //       Icons.chrome_reader_mode,
            //       color: Colors.red,
            //     ),
            //     onPressed: () {
            //       setState(() {
            //         listViewMode = !listViewMode;
            //       });
            //     },
            //   ),
            // ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(right: 12.w, left: 12.w, top: 10.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: listViewMode
                  ? ScrollablePositionedList.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            (index != 0) || (widget.surah == 8)
                                ? const Text('')
                                : Padding(
                                    padding: EdgeInsets.only(bottom: 8.h),
                                    child: StartedSurahWidget(
                                      surahName: widget.surahName,
                                      type: widget.type,
                                      count: widget.count,
                                      surah: widget.surah,
                                    ),
                                  ),
                            ContainerList(
                              index: index,
                              ayaText: widget.arabic[index + previousVerses]
                                  ['aya_text'],
                              onTapSave: () {
                                CacheHelper.put(
                                    key: 'surah', value: widget.surah + 1);
                                CacheHelper.put(key: 'ayah', value: index);

                                showMessage(
                                  message: "تم حفظ الآية",
                                  subMessage:
                                      "يمكنك الرجوع للعلامة من الصفحة الرئيسية",
                                  color: AppColors.greenWhatsColor,
                                );
                              },
                              onTapShare: () async {
                                MagicRouter.navigateTo(
                                    page: await ShareImage(
                                  ayah: widget.arabic[index + previousVerses]
                                      ['aya_text'],
                                  surahNameEn:
                                      widget.arabic[index + previousVerses]
                                          ['sura_name_en'],
                                  surahNameAr:
                                      widget.arabic[index + previousVerses]
                                          ['sura_name_ar'],
                                  surahNumber:
                                      widget.arabic[index + previousVerses]
                                          ['sura_no'],
                                ));
                              },
                              onTapTafser: () async {
                                MagicRouter.navigateTo(
                                  page: await TafserView(
                                    tafser: widget
                                        .tafser[index + previousVerses]['text'],
                                    ayah: widget.arabic[index + previousVerses]
                                        ['aya_text'],
                                  ),
                                );
                              },
                              onTapSound: () async {
                                MagicRouter.navigateTo(
                                  page: await AudioPlayerView(
                                    urlSound: widget.quranSound[widget.surah]
                                        ['array'][index]['path'],
                                    ayah: widget.arabic[index + previousVerses]
                                        ['aya_text'],
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                      itemCount: lengthOfSura,
                    )
                  : ListView(
                      children: [
                        widget.surah + 1 != 1 && widget.surah + 1 != 9
                            ? StartedSurahWidget(
                                surahName: widget.surahName,
                                type: widget.type,
                                count: widget.count,
                                surah: widget.surah,
                              )
                            : const Text(''),
                        AyahItem(
                          text: fullSura,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
