import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/theming/colors.dart';

import 'ayah.dart';

class ContainerList extends StatelessWidget {
  const ContainerList({
    Key? key,
    required this.index,
    required this.ayaText,
    required this.onTapSave,
    required this.onTapShare,
    required this.onTapTafser,
    required this.onTapSound,
  }) : super(key: key);
  final int index;
  final String ayaText;
  final VoidCallback onTapSave, onTapShare, onTapTafser, onTapSound;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: index % 2 != 0
            ? Theme.of(context).textTheme.displayLarge?.color
            : Theme.of(context).textTheme.displayMedium?.color,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: PopupMenuButton(
        tooltip: "",
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
          ),
        ),
        position: PopupMenuPosition.under,
        child: AyahItem(
          text: ayaText,
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            onTap: onTapSave,
            child: PopupItem(
              icon: Icons.bookmark_add,
              iconColor: AppColors.yellowColor,
              text: "حفظ الآية",
            ),
          ),
          PopupMenuItem(
            onTap: onTapShare,
            child: const PopupItem(
              icon: Icons.share,
              iconColor: Colors.green,
              text: "مشاركة الآية",
            ),
          ),
          PopupMenuItem(
            onTap: onTapTafser,
            child: const PopupItem(
              icon: Icons.text_format,
              iconColor: Colors.blue,
              text: "تفسيير الآية",
            ),
          ),
          PopupMenuItem(
            onTap: onTapSound,
            child: const PopupItem(
              icon: Icons.music_note,
              iconColor: Colors.purple,
              text: "سماع الآية",
            ),
          ),
        ],
      ),
    );
  }
}

class PopupItem extends StatelessWidget {
  const PopupItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.text,
  });
  final IconData icon;
  final Color iconColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: "cairo",
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ),
      ],
    );
  }
}
