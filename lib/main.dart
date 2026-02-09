import 'package:flutter/material.dart';
import 'package:islami_app/home/home_screen.dart';
import 'package:islami_app/introduction/onBoarding_screen.dart';
import 'package:islami_app/providers/most_recent_provider.dart';
import 'package:islami_app/tabs/quran/details/sura_details.dart';
import 'package:islami_app/tabs/quran/details/widget/sura_details1.dart';
import 'package:islami_app/utils/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => MostRecentProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: OnBoardingPage.routeName,
      routes: {
        OnBoardingPage.routeName: (context) => OnBoardingPage(),
        HomeScreen.routeName: (context) => HomeScreen(),
        SuraDetails.routeName: (context) => SuraDetails(),
        SuraDetail1.routeName: (context) => SuraDetail1()
      },
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,

    );
  }
}
