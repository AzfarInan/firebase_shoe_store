import 'package:firebase_shoe_store/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

final ThemeData themeData = ThemeData(
  colorScheme: const ColorScheme(
    primary: AppColors.primaryNeutral900,
    secondary: AppColors.primaryNeutral0,
    surface: AppColors.primaryNeutral0,
    error: AppColors.error900,
    onPrimary: AppColors.primaryNeutral0,
    onSecondary: AppColors.primaryNeutral0,
    onSurface: AppColors.primaryNeutral900,
    onError: AppColors.error900,
    brightness: Brightness.light,
  ),
  fontFamily: "Inter",
  textTheme: textTheme,
  primaryColor: AppColors.primaryNeutral900,
  scaffoldBackgroundColor: AppColors.primaryNeutral0,
);
