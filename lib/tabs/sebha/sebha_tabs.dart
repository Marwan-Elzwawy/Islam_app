import 'package:flutter/material.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_styles.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  int counter = 0;
  int index = 0;
  double angle = 0;

  List<String> azkar = [
    "سبحان الله",
    "الحمد لله",
    "لا إله إلا الله",
    "الله أكبر",
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "سَبِّحِ اسْمَ رَبِّكَ الْأَعْلَى",
            style: AppStyles.bold36White,
          ),
          SizedBox(height: height * 0.02),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(AppAssets.okda),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.1),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: onSebhaClick,
                        child: Transform.rotate(
                          angle: angle,
                          child: Image.asset(AppAssets.sebhaBody),
                        ),
                      ),
                      Column(
                        children: [
                          Text(azkar[index], style: AppStyles.bold36White),
                          SizedBox(height: height * 0.02),
                          Text("$counter", style: AppStyles.bold36White),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onSebhaClick() {
    counter++;
    angle += 360 / 30;
    if (counter == 31) {
      counter = 0;
      index++;
      if (index == azkar.length) {
        index = 0;
      }
    }
    setState(() {});
  }
}
