library arabic_numbers;

class _ArabicDays {
  static String convert(Object value) {
    assert(
      value is int || value is String,
      "The value object must be of type 'int' or 'String'.",
    );

    if (value is int) {
      return _toArabicDays(value.toString());
    } else {
      return _toArabicDays(value as String);
    }
  }

  static String _toArabicDays(String value) {
    return value
        .replaceAll('Saturday', 'السبت')
        .replaceAll('Sunday', 'الأحد')
        .replaceAll('Monday', 'الإثنين')
        .replaceAll('Tuesday', 'الثلاثاء')
        .replaceAll('Wednesday', 'الأربعاء')
        .replaceAll('Thursday', 'الخميس')
        .replaceAll('Friday', 'الجمعة');
  }
}

extension IntExtensions on int {
  String get toArabicDays {
    return _ArabicDays.convert(this);
  }
}

extension StringExtensions on String {
  String get toArabicDays {
    return _ArabicDays.convert(this);
  }
}
