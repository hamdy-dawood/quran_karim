library arabic_numbers;

class _ArabicMonths {
  static String convert(Object value) {
    assert(
      value is int || value is String,
      "The value object must be of type 'int' or 'String'.",
    );

    if (value is int) {
      return _toArabicMonths(value.toString());
    } else {
      return _toArabicMonths(value as String);
    }
  }

  static String _toArabicMonths(String value) {
    return value
        .replaceAll('Muharram', 'محرم')
        .replaceAll('Safar', 'صفر')
        .replaceAll('Rabi\' al-Awwal', 'ربيع الأول')
        .replaceAll('Rabi\' al-Thani', 'ربيع الثاني')
        .replaceAll('Jumada al-Awwal', 'جمادى الأولى')
        .replaceAll('Jumada al-Thani', 'جمادى الثانية')
        .replaceAll('Rajab', 'رجب')
        .replaceAll('Sha\'ban', 'شعبان')
        .replaceAll('Ramadan', 'رمضان')
        .replaceAll('Shawwal', 'شوال')
        .replaceAll('Dhu al-Qi\'dah', 'ذو القعدة')
        .replaceAll('Dhu al-Hijjah', 'ذو الحجة');
  }
}

extension IntExtensions on int {
  String get toArabicMonths {
    return _ArabicMonths.convert(this);
  }
}

extension StringExtensions on String {
  String get toArabicMonths {
    return _ArabicMonths.convert(this);
  }
}
