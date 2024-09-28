import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/cache_helper.dart';
import 'package:quran_app/core/helpers/navigate.dart';
import 'package:quran_app/core/widgets/app_bar.dart';
import 'package:quran_app/features/bottom_nav_bar/view.dart';

import '../cubit/sound_states.dart';
import '../cubit/sount_cubit.dart';

class SpeakersScreen extends StatelessWidget {
  const SpeakersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appSoundCubit = context.read<AppSoundCubit>();
    String cachingSpeaker = CacheHelper.get(key: "speaker") ?? "";

    return Scaffold(
      appBar: CustomAppBar(
        text: "القاريء المفضل",
        fontFamily: 'cairo',
        withLeading: cachingSpeaker.isNotEmpty ? true : false,
        withActions: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: BlocBuilder<AppSoundCubit, AppSoundStates>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: appSoundCubit.speakersList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    CacheHelper.put(
                      key: "speaker",
                      value: appSoundCubit.speakersList[index].nameId,
                    );
                    CacheHelper.put(
                      key: "speaker_name",
                      value: appSoundCubit.speakersList[index].displayName,
                    );
                    MagicRouter.navigateTo(
                      page: const NavBarView(initialIndex: 1),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        right: 10.w, left: 10.w, top: 20.h, bottom: 10.h),
                    margin: EdgeInsets.only(bottom: 10.h),
                    decoration: BoxDecoration(
                      color: Theme.of(context).listTileTheme.tileColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      appSoundCubit.speakersList[index].displayName,
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontFamily: 'cairo',
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
