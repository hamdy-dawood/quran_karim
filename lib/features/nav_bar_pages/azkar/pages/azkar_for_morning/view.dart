import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/widgets/app_bar.dart';
import 'package:quran_app/features/nav_bar_pages/azkar/widget/zekr_item.dart';

import 'morning_azkar_list.dart';

class AzkarForMorning extends StatelessWidget {
  const AzkarForMorning({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: title),
      body: Padding(
        padding: EdgeInsets.only(
          right: 15.w,
          left: 15.w,
          top: 20.h,
          bottom: 10.h,
        ),
        child: ListView.builder(
          itemCount: azkarMorningList.length,
          itemBuilder: (context, index) {
            return ZekrItem(
              number: "${azkarMorningList[index].id}",
              count: "${azkarMorningList[index].count}",
              text: "${azkarMorningList[index].text}",
              hintText: "${azkarMorningList[index].hintText}",
            );
          },
        ),
      ),
    );
  }
}
