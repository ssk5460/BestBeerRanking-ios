import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:best_beer_ranking/theme/app_colors.dart';
import 'package:best_beer_ranking/theme/app_text_theme.dart';

import 'font_size.dart';

final appThemeModeProvider =
    StateNotifierProvider<StateController<ThemeMode>, ThemeMode>(
  (ref) => StateController(ThemeMode.light),
);

final appThemeProvider = Provider<AppTheme>(
  (ref) {
    final mode = ref.watch(appThemeModeProvider);
    switch (mode) {
      case ThemeMode.dark:
        return AppTheme.dark();
      case ThemeMode.light:
      default:
        return AppTheme.light();
    }
  },
);

class AppTheme {
  AppTheme({
    required this.mode,
    required this.data,
    required this.textTheme,
    required this.appColors,
  });

  factory AppTheme.light() {
    const mode = ThemeMode.light;
    final appColors = AppColors.light();
    final themeData = ThemeData.light().copyWith(
        cupertinoOverrideTheme: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
          pickerTextStyle: TextStyle(
              color: appColors.secondaryText, fontSize: FontSize.pt28),
        )),
        scaffoldBackgroundColor: appColors.background,
        textTheme: GoogleFonts.notoSansTextTheme(ThemeData.light().textTheme),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: appColors.dangerText,
          behavior: SnackBarBehavior.floating,
        ),
        colorScheme: ThemeData.light().colorScheme.copyWith(secondary: appColors.accent),
        appBarTheme: AppBarTheme(backgroundColor: appColors.background),
        unselectedWidgetColor: appColors.background);
    return AppTheme(
      mode: mode,
      data: themeData,
      textTheme: AppTextTheme(),
      appColors: appColors,
    );
  }

  factory AppTheme.dark() {
    const mode = ThemeMode.dark;
    final appColors = AppColors.dark();
    final themeData = ThemeData.dark().copyWith(
        cupertinoOverrideTheme: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
          pickerTextStyle: TextStyle(
              color: appColors.secondaryText, fontSize: FontSize.pt28),
        )),
        scaffoldBackgroundColor: appColors.background,
        textTheme: GoogleFonts.notoSansTextTheme(ThemeData.dark().textTheme),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: appColors.dangerText,
          behavior: SnackBarBehavior.floating,
        ),
        appBarTheme: AppBarTheme(backgroundColor: appColors.background),
        unselectedWidgetColor: appColors.background);
    return AppTheme(
      mode: mode,
      data: themeData,
      textTheme: AppTextTheme(),
      appColors: appColors,
    );
  }

  final ThemeMode mode;
  final ThemeData data;
  final AppTextTheme textTheme;
  final AppColors appColors;
}
