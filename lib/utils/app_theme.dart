import 'package:flutter/material.dart';
import 'package:islami_app/utils/app_colors.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.transparent,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.BlackBg,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.primaryColor),
    ),
  );
}
