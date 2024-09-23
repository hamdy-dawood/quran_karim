import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/constants.dart';
import 'package:quran_app/core/theming/colors.dart';
import 'package:quran_app/core/widgets/app_bar.dart';

class TafserView extends StatelessWidget {
  const TafserView({
    Key? key,
    required this.tafser,
    required this.ayah,
  }) : super(key: key);
  final String ayah, tafser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        text: "تفسيير",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                color: Theme.of(context).textTheme.displayMedium?.color,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                ayah,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontFamily: arabicFont,
                  color: ColorManager.orangeColor,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Container(
              padding: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                color: Theme.of(context).textTheme.displayMedium?.color,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                tafser,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: "cairo",
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
