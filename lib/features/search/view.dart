import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/core/helpers/constants.dart';
import 'package:quran_app/core/widgets/app_bar.dart';
import 'package:quran_app/features/search/widgets/search_ayah_text_field.dart';

import 'widgets/search_result.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<Map<String, dynamic>> searchByWord(String word) {
    List<Map<String, dynamic>> results = [];
    for (var item in arabic) {
      String ayaText = item["aya_text_emlaey"];
      if (ayaText.contains(word)) {
        results.add(item);
      }
    }
    return results;
  }

  List<Map<String, dynamic>> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: "البحث"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            SearchAyahTextField(
              onChanged: (value) {
                searchResults = searchByWord(value);
                setState(() {});
              },
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: BuildSearchResult(
                results: searchResults,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
