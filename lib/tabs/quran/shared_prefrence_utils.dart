import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceKeys {
  static const String mostRecentKey = 'most_recent';
}

void SaveLastSuraIndex(int newSuraIndex) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  //todo : get last sura index
  List<String> mostRecentList =
      prefs.getStringList(SharedPreferenceKeys.mostRecentKey) ?? [];
  if (mostRecentList.contains('$newSuraIndex')) {
    mostRecentList.remove('$newSuraIndex');
    mostRecentList.insert(0, '$newSuraIndex');
  } else {
    mostRecentList.insert(0, '$newSuraIndex');
  }
  if (mostRecentList.length > 5) {
    mostRecentList.removeLast();
  }
  //todo: save list in share preference
  await prefs.setStringList(SharedPreferenceKeys.mostRecentKey, mostRecentList);
}
