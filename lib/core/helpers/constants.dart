import 'dart:convert';

import 'package:flutter/services.dart';

List<Map> arabicName = [
  {"surah": "1", "name": "الْفَاتِحَةُ", "type": "مكية", "verse_count": "7"},
  {"surah": "2", "name": "الْبَقَرَةُ", "type": "مدنية", "verse_count": "286"},
  {
    "surah": "3",
    "name": "آلِ عِمْرَانَ",
    "type": "مدنية",
    "verse_count": "200"
  },
  {"surah": "4", "name": "النِّسَاءُ", "type": "مدنية", "verse_count": "176"},
  {"surah": "5", "name": "الْمَائِدَةُ", "type": "مدنية", "verse_count": "120"},
  {"surah": "6", "name": "الْأَنْعَامُ", "type": "مكية", "verse_count": "165"},
  {"surah": "7", "name": "الْأَعْرَافُ", "type": "مكية", "verse_count": "206"},
  {"surah": "8", "name": "الْأَنْفَالُ", "type": "مدنية", "verse_count": "75"},
  {"surah": "9", "name": "التَّوْبَةُ", "type": "مدنية", "verse_count": "129"},
  {"surah": "10", "name": "يُونُسُ", "type": "مكية", "verse_count": "109"},
  {"surah": "11", "name": "هُودٌ", "type": "مكية", "verse_count": "123"},
  {"surah": "12", "name": "يُوسُفُ", "type": "مكية", "verse_count": "111"},
  {"surah": "13", "name": "الرَّعْدُ", "type": "مدنية", "verse_count": "43"},
  {"surah": "14", "name": "إِبْرَاهِيمَ", "type": "مكية", "verse_count": "52"},
  {"surah": "15", "name": "الْحِجْرُ", "type": "مكية", "verse_count": "99"},
  {"surah": "16", "name": "النَّحْلُ", "type": "مكية", "verse_count": "128"},
  {"surah": "17", "name": "الْإِسْرَاءُ", "type": "مكية", "verse_count": "111"},
  {"surah": "18", "name": "الْكَهْفُ", "type": "مكية", "verse_count": "110"},
  {"surah": "19", "name": "مَرْيَمُ", "type": "مكية", "verse_count": "98"},
  {"surah": "20", "name": "طه", "type": "مكية", "verse_count": "135"},
  {
    "surah": "21",
    "name": "الْأَنْبِيَاءُ",
    "type": "مكية",
    "verse_count": "112"
  },
  {"surah": "22", "name": "الْحَجُّ", "type": "مدنية", "verse_count": "78"},
  {
    "surah": "23",
    "name": "المُؤْمِنُونَ",
    "type": "مكية",
    "verse_count": "118"
  },
  {"surah": "24", "name": "النُّورُ", "type": "مدنية", "verse_count": "64"},
  {"surah": "25", "name": "الْفُرْقَانُ", "type": "مكية", "verse_count": "77"},
  {"surah": "26", "name": "الشُّعَرَاءُ", "type": "مكية", "verse_count": "227"},
  {"surah": "27", "name": "النَّمْلُ", "type": "مكية", "verse_count": "93"},
  {"surah": "28", "name": "الْقَصَصُ", "type": "مكية", "verse_count": "88"},
  {
    "surah": "29",
    "name": "الْعَنْكَبُوتُ",
    "type": "مكية",
    "verse_count": "69"
  },
  {"surah": "30", "name": "الرُّومُ", "type": "مكية", "verse_count": "60"},
  {"surah": "31", "name": "لُقْمَانَ", "type": "مكية", "verse_count": "34"},
  {"surah": "32", "name": "السَّجْدَةُ", "type": "مكية", "verse_count": "30"},
  {"surah": "33", "name": "الأَحْزَابُ", "type": "مدنية", "verse_count": "73"},
  {"surah": "34", "name": "سَبَأٌ", "type": "مكية", "verse_count": "54"},
  {"surah": "35", "name": "فَاطِرٌ", "type": "مكية", "verse_count": "45"},
  {"surah": "36", "name": "يَسٓ", "type": "مكية", "verse_count": "83"},
  {"surah": "37", "name": "الصَّافَّاتُ", "type": "مكية", "verse_count": "182"},
  {"surah": "38", "name": "صٓ", "type": "مكية", "verse_count": "88"},
  {"surah": "39", "name": "الزُّمَرُ", "type": "مكية", "verse_count": "75"},
  {"surah": "40", "name": "غَافِرٌ", "type": "مكية", "verse_count": "85"},
  {"surah": "41", "name": "فُصِّلَتْ", "type": "مكية", "verse_count": "54"},
  {"surah": "42", "name": "الشُّورَىٰ", "type": "مكية", "verse_count": "53"},
  {"surah": "43", "name": "الزُّخْرُفُ", "type": "مكية", "verse_count": "89"},
  {"surah": "44", "name": "الدُّخَانُ", "type": "مكية", "verse_count": "59"},
  {"surah": "45", "name": "الْجَاثِيَةُ", "type": "مكية", "verse_count": "37"},
  {"surah": "46", "name": "الْأَحْقَافُ", "type": "مكية", "verse_count": "35"},
  {"surah": "47", "name": "مُحَمَّدٌ", "type": "مدنية", "verse_count": "38"},
  {"surah": "48", "name": "الْفَتْحُ", "type": "مدنية", "verse_count": "29"},
  {"surah": "49", "name": "الْحُجُرَاتُ", "type": "مدنية", "verse_count": "18"},
  {"surah": "50", "name": "قٓ", "type": "مكية", "verse_count": "45"},
  {"surah": "51", "name": "الذَّارِيَاتُ", "type": "مكية", "verse_count": "60"},
  {"surah": "52", "name": "الطُّورُ", "type": "مكية", "verse_count": "49"},
  {"surah": "53", "name": "النَّجْمُ", "type": "مكية", "verse_count": "62"},
  {"surah": "54", "name": "الْقَمَرُ", "type": "مكية", "verse_count": "55"},
  {
    "surah": "55",
    "name": "الرَّحْمَـٰنُ",
    "type": "مدنية",
    "verse_count": "78"
  },
  {"surah": "56", "name": "الْوَاقِعَةُ", "type": "مكية", "verse_count": "96"},
  {"surah": "57", "name": "الْحَدِيدُ", "type": "مدنية", "verse_count": "29"},
  {
    "surah": "58",
    "name": "الْمُجَادِلَةُ",
    "type": "مدنية",
    "verse_count": "22"
  },
  {"surah": "59", "name": "الْحَشْرُ", "type": "مدنية", "verse_count": "24"},
  {
    "surah": "60",
    "name": "الْمُمْتَحَنَةُ",
    "type": "مدنية",
    "verse_count": "13"
  },
  {"surah": "61", "name": "الصَّفُّ", "type": "مدنية", "verse_count": "14"},
  {"surah": "62", "name": "الْجُمُعَةُ", "type": "مدنية", "verse_count": "11"},
  {
    "surah": "63",
    "name": "الْمُنَافِقُونَ",
    "type": "مدنية",
    "verse_count": "11"
  },
  {"surah": "64", "name": "التَّغَابُنُ", "type": "مدنية", "verse_count": "18"},
  {"surah": "65", "name": "الطَّلَاقُ", "type": "مدنية", "verse_count": "12"},
  {"surah": "66", "name": "التَّحْرِيمُ", "type": "مدنية", "verse_count": "12"},
  {"surah": "67", "name": "المُلْكُ", "type": "مكية", "verse_count": "30"},
  {"surah": "68", "name": "الْقَلَمُ", "type": "مكية", "verse_count": "52"},
  {"surah": "69", "name": "الْحَاقَّةُ", "type": "مكية", "verse_count": "52"},
  {"surah": "70", "name": "المَعَارِجُ", "type": "مكية", "verse_count": "44"},
  {"surah": "71", "name": "نُوحٌ", "type": "مكية", "verse_count": "28"},
  {"surah": "72", "name": "الْجِنُّ", "type": "مكية", "verse_count": "28"},
  {"surah": "73", "name": "الْمُزَّمِّلُ", "type": "مكية", "verse_count": "20"},
  {"surah": "74", "name": "الْمُدَّثِّرُ", "type": "مكية", "verse_count": "56"},
  {"surah": "75", "name": "الْقِيَامَةُ", "type": "مكية", "verse_count": "40"},
  {"surah": "76", "name": "الإِنْسَانُ", "type": "مدنية", "verse_count": "31"},
  {
    "surah": "77",
    "name": "الْمُرْسَلَاتُ",
    "type": "مكية",
    "verse_count": "50"
  },
  {"surah": "78", "name": "النَّبَأُ", "type": "مكية", "verse_count": "40"},
  {"surah": "79", "name": "النَّازِعَاتُ", "type": "مكية", "verse_count": "46"},
  {"surah": "80", "name": "عَبَسَ", "type": "مكية", "verse_count": "42"},
  {"surah": "81", "name": "التَّكْوِيرُ", "type": "مكية", "verse_count": "29"},
  {"surah": "82", "name": "الإِنْفِطَارُ", "type": "مكية", "verse_count": "19"},
  {
    "surah": "83",
    "name": "الْمُطَفِّفِينَ",
    "type": "مكية",
    "verse_count": "36"
  },
  {"surah": "84", "name": "الإِنْشِقَاقُ", "type": "مكية", "verse_count": "25"},
  {"surah": "85", "name": "الْبُرُوجُ", "type": "مكية", "verse_count": "22"},
  {"surah": "86", "name": "الطَّارِقُ", "type": "مكية", "verse_count": "17"},
  {"surah": "87", "name": "الْأَعْلَىٰ", "type": "مكية", "verse_count": "19"},
  {"surah": "88", "name": "الْغَاشِيَةُ", "type": "مكية", "verse_count": "26"},
  {"surah": "89", "name": "الْفَجْرُ", "type": "مكية", "verse_count": "30"},
  {"surah": "90", "name": "الْبَلَدُ", "type": "مكية", "verse_count": "20"},
  {"surah": "91", "name": "الشَّمْسُ", "type": "مكية", "verse_count": "15"},
  {"surah": "92", "name": "اللَّيْلُ", "type": "مكية", "verse_count": "21"},
  {"surah": "93", "name": "الضُّحَىٰ", "type": "مكية", "verse_count": "11"},
  {"surah": "94", "name": "الشَّرْحُ", "type": "مكية", "verse_count": "8"},
  {"surah": "95", "name": "التِّينِ", "type": "مكية", "verse_count": "8"},
  {"surah": "96", "name": "الْعَلَقُ", "type": "مكية", "verse_count": "19"},
  {"surah": "97", "name": "الْقَدْرُ", "type": "مكية", "verse_count": "5"},
  {"surah": "98", "name": "الْبَيِّنَةُ", "type": "مدنية", "verse_count": "8"},
  {"surah": "99", "name": "الزَّلْزَلَةُ", "type": "مدنية", "verse_count": "8"},
  {
    "surah": "100",
    "name": "الْعَادِيَاتُ",
    "type": "مكية",
    "verse_count": "11"
  },
  {"surah": "101", "name": "الْقَارِعَةُ", "type": "مكية", "verse_count": "11"},
  {"surah": "102", "name": "التَّكَاثُرُ", "type": "مكية", "verse_count": "8"},
  {"surah": "103", "name": "الْعَصْرُ", "type": "مكية", "verse_count": "3"},
  {"surah": "104", "name": "الْهُمَزَةُ", "type": "مكية", "verse_count": "9"},
  {"surah": "105", "name": "الْفِيلُ", "type": "مكية", "verse_count": "5"},
  {"surah": "106", "name": "قُرَيْشٌ", "type": "مكية", "verse_count": "4"},
  {"surah": "107", "name": "الْمَاعُونَ", "type": "مكية", "verse_count": "7"},
  {"surah": "108", "name": "الْكَوْثَرُ", "type": "مكية", "verse_count": "3"},
  {"surah": "109", "name": "الْكَافِرُونَ", "type": "مكية", "verse_count": "6"},
  {"surah": "110", "name": "النَّصْرُ", "type": "مدنية", "verse_count": "3"},
  {"surah": "111", "name": "المَسَدُ", "type": "مكية", "verse_count": "5"},
  {"surah": "112", "name": "الإِخْلَاصُ", "type": "مكية", "verse_count": "4"},
  {"surah": "113", "name": "الْفَلَقُ", "type": "مكية", "verse_count": "5"},
  {"surah": "114", "name": "النَّاسُ", "type": "مكية", "verse_count": "6"}
];

List<int> numberOfVerses = [
  7,
  286,
  200,
  176,
  120,
  165,
  206,
  75,
  129,
  109,
  123,
  111,
  43,
  52,
  99,
  128,
  111,
  110,
  98,
  135,
  112,
  78,
  118,
  64,
  77,
  227,
  93,
  88,
  69,
  60,
  34,
  30,
  73,
  54,
  45,
  83,
  182,
  88,
  75,
  85,
  54,
  53,
  89,
  59,
  37,
  35,
  38,
  29,
  18,
  45,
  60,
  49,
  62,
  55,
  78,
  96,
  29,
  22,
  24,
  13,
  14,
  11,
  11,
  18,
  12,
  12,
  30,
  52,
  52,
  44,
  28,
  28,
  20,
  56,
  40,
  31,
  50,
  40,
  46,
  42,
  29,
  19,
  36,
  25,
  22,
  17,
  19,
  26,
  30,
  20,
  15,
  21,
  11,
  8,
  8,
  19,
  5,
  8,
  8,
  11,
  11,
  8,
  3,
  9,
  5,
  4,
  7,
  3,
  6,
  3,
  5,
  4,
  5,
  6
];

bool fabIsClicked = true;
String arabicFont = "quran";
double arabicFontSize = 28;

List arabic = [];
List malayalam = [];
List quran = [];
List tafser = [];
List quranSound = [];

Future readJson() async {
  final String response =
      await rootBundle.loadString("assets/quran/hafs_smart_v8.json");
  final data = json.decode(response);
  arabic = data["quran"];
  malayalam = data["malayalam"];
  return quran = [arabic, malayalam];
}

Future readTafserJson() async {
  final String response =
      await rootBundle.loadString("assets/quran/tafser.json");
  final data = json.decode(response);
  tafser = data["tafser"];
  return tafser;
}

Future readQuranSoundJson() async {
  final String response =
      await rootBundle.loadString("assets/quran/sound_quran.json");
  final data = json.decode(response);
  quranSound = data["sound_quran"];
  return quranSound;
}

String logoImageNetwork = "https://i.imghippo.com/files/I17QR1727507875.png";
