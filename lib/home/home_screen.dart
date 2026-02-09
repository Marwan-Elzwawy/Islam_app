import 'package:flutter/material.dart';
import 'package:islami_app/tabs/hadeth/hadeth_tabs.dart';
import 'package:islami_app/tabs/quran/quran_tabs.dart';
import 'package:islami_app/tabs/radio/radio_tabs.dart';
import 'package:islami_app/tabs/sebha/sebha_tabs.dart';
import 'package:islami_app/tabs/time/time-tabs.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<String> backgroundImage = [
    AppAssets.quranBg, AppAssets.hadethBg, AppAssets.sebhaBg,
    AppAssets.radioBg, AppAssets.timeBg
  ];
  List<Widget> tabList = [QuranTab(), HadethTab(), SebhaTab(),
    RadioTab(), TimeTab()];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return Stack(
      children: [
        Image.asset(backgroundImage[selectedIndex],
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill),
        Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
                setState(() {

                });
              },
              selectedItemColor: AppColors.White,
              backgroundColor: AppColors.primaryColor,
              type: BottomNavigationBarType.fixed,
              items: [
                buildBottom(
                    iconName: AppAssets.quranDark, label: 'Quaran', index: 0),
                buildBottom(
                    iconName: AppAssets.hadethDark, label: 'Hadeth', index: 1),
                buildBottom(
                    iconName: AppAssets.sebhaDark, label: 'Sebha', index: 2),
                buildBottom(
                    iconName: AppAssets.radioDark, label: 'Radio', index: 3),
                buildBottom(
                    iconName: AppAssets.timeDark, label: 'Time', index: 4),
              ]
          ),
          body: Column(
            spacing: 25,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.islami,
                  height: height * 0.17),
              Expanded(child: tabList[selectedIndex]),
            ],
          ),
        )
      ],
    );
  }

  BottomNavigationBarItem buildBottom({required String iconName,
    required String label, required index}) {
    return BottomNavigationBarItem(icon: selectedIndex == index ?
    Container(
        padding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 8
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(66),
          color: AppColors.BlackBg,
        ),
        child: ImageIcon(AssetImage(iconName))) :
    ImageIcon(AssetImage(iconName))
        , label: label);
  }
}
