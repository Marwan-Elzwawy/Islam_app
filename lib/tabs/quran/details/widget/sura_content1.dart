import 'package:flutter/material.dart';
import 'package:islami_app/utils/app_styles.dart';

class SuraContent1 extends StatelessWidget {
  final String content;

  const SuraContent1({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Text(
      content,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      style: AppStyles.bold20Primary,
    );
  }
}
