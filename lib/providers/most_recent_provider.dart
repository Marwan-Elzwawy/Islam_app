import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../tabs/quran/shared_prefrence_utils.dart';

class MostRecentProvider extends ChangeNotifier {
  List<int> mostRecentList = [];

  void getLastSuraIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> mostRecentListAsString =
        prefs.getStringList(SharedPreferenceKeys.mostRecentKey) ?? [];
    mostRecentList = mostRecentListAsString
        .map((element) => int.parse(element))
        .toList();
    notifyListeners();
  }
}
