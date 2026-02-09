import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/tabs/hadeth/hadeth_resources.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_styles.dart';

import '../../../utils/app_assets.dart';

class HadethItem extends StatefulWidget {
  final index;

  HadethItem({super.key, required this.index});

  @override
  State<HadethItem> createState() => _HadethItemState();
}

class _HadethItemState extends State<HadethItem> {
  Hadeth? hadeth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadHadethFile(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.primaryColor,
      ),
      child: hadeth == null
          ? Center(child: CircularProgressIndicator(color: AppColors.BlackBg))
          : Stack(
              children: [
                Image.asset(
                  AppAssets.hadethContentBg,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.04,
                    horizontal: width * 0.04,
                  ),
                  child: Column(
                    spacing: height * 0.02,
                    children: [
                      Text(
                        hadeth?.title ?? '',
                        textAlign: TextAlign.center,
                        style: AppStyles.bold24Black,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            hadeth?.content ?? '',
                            style: AppStyles.bold16Black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void loadHadethFile(int index) async {
    String fileContent = await rootBundle.loadString(
      'assets/files/hadeth/h$index.txt',
    );
    String title = fileContent.substring(0, fileContent.indexOf('\n'));
    String content = fileContent.substring(fileContent.indexOf('\n') + 1);
    hadeth = Hadeth(title: title, content: content);
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }
}
