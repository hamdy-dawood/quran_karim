import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_app/core/helpers/app_theme.dart';
import 'package:quran_app/core/helpers/navigate.dart';
import 'package:quran_app/core/theming/assets.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/core/widgets/app_bar.dart';
import 'package:quran_app/features/nav_bar_pages/quran/widgets/last_read_widget.dart';
import 'package:quran_app/features/quran_font/view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/dark_mode_switch.dart';
import 'widgets/list_tile_item.dart';

class MorePage extends StatelessWidget {
  const MorePage({
    super.key,
  });

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return Scaffold(
      appBar: const CustomAppBar(
        text: "الاعدادات",
        withLeading: false,
        withActions: false,
      ),
      body: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            children: [
              const EmptyContainerFirst(),
              SizedBox(height: 15.h),
              ListTileWithSubTitleItem(
                text: "تقييم التطبيق",
                subText: "قم بدعم التطبيق وتقييمه ب 5 نجوم",
                icon: Icons.star,
                onTap: () {
                  StoreRedirect.redirect(
                    androidAppId: "com.hamdy_khalid_dawood.quran_app",
                    iOSAppId: "",
                  );
                },
              ),
              ListTileItem(
                text: "حجم الخط",
                icon: Icons.format_size,
                onTap: () {
                  MagicRouter.navigateTo(
                    page: const QuranFontView(),
                  );
                },
              ),
              ListTileItem(
                text: "الوضع المظلم",
                icon: Icons.dark_mode,
                trailing: DarkModeSwitch(themeCubit: themeCubit),
              ),
              ListTileWithSubTitleItem(
                text: "مشاركة التطبيق",
                subText: "شارك التطبيق مع أصدقاؤك حتي تكون صدقة جارية لك",
                icon: Icons.share,
                onTap: () {
                  Share.share(
                      "تحميل تطبيق القرآن الكريم -  المصحف كامل , تفسير ميسر , أدعية وأذكار - شاركنا الثواب , شاركنا في الصدقة الجارية. \n https://play.google.com/store/apps/details?id=com.hamdy_khalid_dawood.quran_app");
                },
              ),
              Center(
                child: Card(
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.r)),
                  ),
                  child: SizedBox(
                    width: 1.sw,
                    height: 140.h,
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16.r)),
                            color: AppColors.yellowColor,
                          ),
                          width: double.infinity,
                          height: 60.0,
                          child: Center(
                            child: Text(
                              "للتواصل مع مطور التطبيق",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 20.sp,
                                fontFamily: 'cairo',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _launchInBrowser(
                                    Uri.parse(
                                      "https://www.facebook.com/hamdykhaliddawood",
                                    ),
                                  );
                                },
                                icon: SvgPicture.asset(
                                  ImageManager.facebook,
                                  height: 25.h,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _launchInBrowser(
                                    Uri.parse(
                                      "https://www.instagram.com/hamdy_dawood_/",
                                    ),
                                  );
                                },
                                icon: SvgPicture.asset(
                                  ImageManager.instagram,
                                  height: 25.h,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _launchInBrowser(
                                    Uri.parse(
                                      "https://www.linkedin.com/in/hamdy-dawood-468886210/",
                                    ),
                                  );
                                },
                                icon: SvgPicture.asset(
                                  ImageManager.linkedin,
                                  height: 25.h,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
