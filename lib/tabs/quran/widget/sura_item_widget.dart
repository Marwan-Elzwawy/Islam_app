import 'package:flutter/material.dart';
import 'package:islami_app/tabs/quran/quran_resources.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_styles.dart';

class SuraItemWidget extends StatelessWidget {
  final int index;

  const SuraItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Row(
      spacing: width * 0.04,
      children: [
        Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Image.asset(AppAssets.suraFrame),
            Text('${index + 1}', style: AppStyles.bold20White),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              QuranResources.englishSuraName[index],
              style: AppStyles.bold20White,
            ),
            Text(
              '${QuranResources.versesSuraNumber[index]} verses',
              style: AppStyles.bold14White,
            ),
          ],
        ),
        Spacer(),
        Text(
          QuranResources.arabicSurahName[index],
          style: AppStyles.bold20White,
        ),
      ],
    );
  }
}
