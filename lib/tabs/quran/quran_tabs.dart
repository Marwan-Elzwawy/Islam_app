import 'package:flutter/material.dart';
import 'package:islami_app/tabs/quran/details/sura_details.dart';
import 'package:islami_app/tabs/quran/quran_resources.dart';
import 'package:islami_app/tabs/quran/shared_prefrence_utils.dart';
import 'package:islami_app/tabs/quran/widget/sura_item_widget.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_styles.dart';

import 'widget/most_recently.dart';

class QuranTab extends StatefulWidget {
  QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  List<int> filterList = List.generate(114, (index) => index);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: height * 0.02,
        children: [
          TextField(
            cursorColor: AppColors.primaryColor,
            style: TextStyle(color: AppColors.White),
            decoration: InputDecoration(
              enabledBorder: buildDecoration(),
              focusedBorder: buildDecoration(),
              prefixIcon: Image.asset(AppAssets.iconSearch),
              hintText: 'Surah Name',
              hintStyle: AppStyles.bold16White,
            ),
            onChanged: (newText) {
              searchByNewText(newText);
            },
          ),
          MostRecently(),
          Text('Suras List', style: AppStyles.bold16White),
          Expanded(
            child: filterList.isEmpty
                ? Center(
                    child: Text(
                      'No sura items found',
                      style: AppStyles.bold20White,
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          //todo: save the last sura index
                          SaveLastSuraIndex(filterList[index]);
                          Navigator.of(context).pushNamed(
                            SuraDetails.routeName,
                            arguments: filterList[index],
                          );
                        },
                        child: SuraItemWidget(index: filterList[index]),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: AppColors.White,
                        thickness: 2,
                        indent: width * 0.12,
                        endIndent: width * 0.12,
                      );
                    },
                    itemCount: filterList.length,
                  ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder buildDecoration() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
    );
  }

  void searchByNewText(String newText) {
    List<int> filterSearchList = [];
    for (int i = 0; i < QuranResources.englishSuraName.length; i++) {
      if (QuranResources.englishSuraName[i].toLowerCase().contains(
        newText.toLowerCase(),
      )) {
        filterSearchList.add(i);
      }
    }
    for (int i = 0; i < QuranResources.arabicSurahName.length; i++) {
      if (QuranResources.arabicSurahName[i].contains(newText)) {
        filterSearchList.add(i);
      }
    }
    filterList = filterSearchList;
    setState(() {});
  }
}
