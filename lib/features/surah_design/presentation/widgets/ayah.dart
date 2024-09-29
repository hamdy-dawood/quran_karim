import 'package:flutter/material.dart';
import 'package:quran_app/core/helpers/constants.dart';

class AyahItem extends StatelessWidget {
  const AyahItem({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          text,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: arabicFontSize,
            fontFamily: arabicFont,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }
}
