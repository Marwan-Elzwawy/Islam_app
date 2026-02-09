import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/providers/most_recent_provider.dart';
import 'package:islami_app/tabs/quran/details/widget/sura_content1.dart';
import 'package:islami_app/tabs/quran/quran_resources.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

class SuraDetail1 extends StatefulWidget {
  SuraDetail1({super.key});

  static const String routeName = 'sura_detail_screen';

  @override
  State<SuraDetail1> createState() => _SuraDetailsState();
}

class _SuraDetailsState extends State<SuraDetail1> {
  String suraContent = '';
  late MostRecentProvider mostRecentProvider;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mostRecentProvider.getLastSuraIndex();
  }

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)?.settings.arguments as int;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    mostRecentProvider = Provider.of<MostRecentProvider>(context);
    if (suraContent.isEmpty) {
      loadSuraFiles(index);
    }
    return Scaffold(
      backgroundColor: AppColors.BlackBg,
      appBar: AppBar(
        title: Text(
          QuranResources.englishSuraName[index],
          style: AppStyles.bold20Primary,
        ),
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
                  child: Center(
                    child: suraContent.isEmpty
                        ? CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          )
                        : SingleChildScrollView(
                            child: SuraContent1(content: suraContent),
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
    for (int i = 0; i < lines.length; i++) {
      lines[i] += '[${i + 1}]';
      suraContent = lines.join();
    }
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }
}
