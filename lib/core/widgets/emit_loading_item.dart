import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/theming/colors.dart';


class DefaultLargeLoadingItem extends StatelessWidget {
  const DefaultLargeLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100.h,
        width: 100.h,
        child:  CircularProgressIndicator(
          strokeWidth: 4,
          color: AppColors.orangeColor,
        ),
      ),
    );
  }
}

class DefaultCircleProgressIndicator extends StatelessWidget {
  const DefaultCircleProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(
        color: AppColors.orangeColor,
      ),
    );
  }
}

class DefaultSmallCircleIndicator extends StatelessWidget {
  const DefaultSmallCircleIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      heightFactor: 1,
      widthFactor: 1,
      child: SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(
          color: AppColors.white,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
