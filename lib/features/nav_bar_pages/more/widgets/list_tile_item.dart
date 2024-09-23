import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTileItem extends StatelessWidget {
  const ListTileItem({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap,
    this.trailing,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        onTap: onTap,
        leading: Icon(
          icon,
          color: Theme.of(context).iconTheme.color,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontFamily: 'cairo',
            fontSize: 20.sp,
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}

class ListTileWithSubTitleItem extends StatelessWidget {
  const ListTileWithSubTitleItem({
    Key? key,
    required this.text,
    required this.subText,
    required this.icon,
    this.onTap,
    this.trailing,
  }) : super(key: key);
  final String text, subText;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        onTap: onTap,
        leading: Icon(
          icon,
          color: Theme.of(context).iconTheme.color,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontFamily: 'cairo',
            fontSize: 20.sp,
          ),
        ),
        subtitle: Text(
          subText,
          style: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontFamily: 'cairo',
            fontSize: 14.sp,
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}
