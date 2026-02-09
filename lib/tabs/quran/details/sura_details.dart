import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/tabs/quran/details/widget/sura_content.dart';
import 'package:islami_app/tabs/quran/quran_resources.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

import '../../../providers/most_recent_provider.dart';

class SuraDetails extends StatefulWidget {
  const SuraDetails({super.key}); // Added const

  static const String routeName = 'sura_details_screen';

  @override
  State<SuraDetails> createState() => _SuraDetailsState();
}

enum ViewMode { continuous, List }

class _SuraDetailsState extends State<SuraDetails> {
  late MostRecentProvider mostRecentProvider;
  List<String> verses = [];
  ViewMode currentMode = ViewMode.continuous;
  int index = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mostRecentProvider = Provider.of<MostRecentProvider>(context);
    if (ModalRoute.of(context)?.settings.arguments != null) {
      index = ModalRoute.of(context)?.settings.arguments as int;
      if (verses.isEmpty) {
        loadSuraFiles(index);
      }
    }
  }

  @override
  void dispose() {
    mostRecentProvider.getLastSuraIndex();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.BlackBg,
      appBar: AppBar(
        title: Text(
          QuranResources.englishSuraName[index],
          style: AppStyles.bold20Primary,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                currentMode = ViewMode.continuous;
              });
            },
            icon: Icon(
              Icons.article_outlined,
              color: currentMode == ViewMode.continuous
                  ? AppColors.primaryColor
                  : Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                currentMode = ViewMode.List;
              });
            },
            icon: Icon(
              Icons.list,
              color: currentMode == ViewMode.List
                  ? AppColors.primaryColor
                  : Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Image.asset(
            AppAssets.quranDetails,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.02),
            child: Column(
              children: [
                Text(
                  QuranResources.arabicSurahName[index],
                  style: AppStyles.bold24Primary,
                ),
                SizedBox(height: height * 0.04),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                    child: Center(
                      child: verses.isEmpty
                          ? CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : (currentMode == ViewMode.List)
                          ? ListView.separated(
                              padding: EdgeInsets.only(top: height * 0.02),
                              itemBuilder: (context, index) {
                                return SuraContent(
                                  content: verses[index],
                                  index: index,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: height * 0.02);
                              },
                              itemCount: verses.length,
                            )
                          : SingleChildScrollView(
                              padding: EdgeInsets.only(top: height * 0.02),
                              child: Text(
                                verses
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                      int verseIndex = entry.key;
                                      String verseText = entry.value;
                                      return "$verseText[${verseIndex + 1}]";
                                    })
                                    .join(" "),

                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                                style: AppStyles.bold24Primary,
                              ),
                            ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void loadSuraFiles(int index) async {
    String fileContent = await rootBundle.loadString(
      'assets/files/quran/${index + 1}.txt',
    );
    List<String> lines = fileContent.split('\n');
    verses = lines.where((line) => line.trim().isNotEmpty).toList();
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }
}
