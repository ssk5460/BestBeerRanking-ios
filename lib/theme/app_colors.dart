import 'package:flutter/material.dart';

// Color converter: https://www.w3schools.com/colors/colors_converter.asp
// Transparency list
// 100% FF
// 95%  F2
// 90%  E6
// 87%  DE
// 85%  D9
// 80%  CC
// 75%  BF
// 70%  B3
// 65%  A6
// 60%  99
// 55%  8C
// 54%  8A
// 50%  80
// 45%  73
// 40%  66
// 35%  59
// 32%  52
// 30%  4D
// 26%  42
// 25%  40
// 20%  33
// 16%  29
// 15%  26
// 12%  1F
// 10%  1A
// 5%   0D

class AppColors {
  const AppColors(
      {required this.primary,
      required this.background,
      required this.accent,
      required this.primaryText,
      required this.secondaryText,
      required this.descriptionText,
      required this.enableText,
      required this.disableText,
      required this.agePickerText,
      required this.dangerText,
      required this.linkText,
      required this.border,
      required this.icon,
      required this.medalEmpty,
      required this.medalBronze,
      required this.medalSilver,
      required this.medalGold});

  final Color primary;
  final Color background;
  final Color accent;
  final Color primaryText;
  final Color secondaryText;
  final Color descriptionText;
  final Color enableText;
  final Color disableText;
  final Color agePickerText;
  final Color dangerText;
  final Color linkText;
  final Color border;
  final Color icon;
  final Color medalEmpty;
  final Color medalBronze;
  final Color medalSilver;
  final Color medalGold;

  Color rankingColor(int ranking) {
    switch (ranking) {
      case 1:
        return medalGold;
      case 2:
        return medalSilver;
      case 3:
        return medalBronze;
    }
    return Colors.black12;
  }

  factory AppColors.light() {
    return const AppColors(
      primary: Color.fromRGBO(13, 187, 108, 1),
      background: Color.fromRGBO(244, 244, 244, 1.0),
      accent: Color.fromRGBO(255, 126, 11, 1.0),
      primaryText: Color.fromRGBO(13, 187, 108, 1),
      secondaryText: Color.fromRGBO(27, 27, 27, 1.0),
      descriptionText: Color.fromRGBO(17, 17, 17, 1),
      enableText: Color.fromRGBO(254, 254, 254, 1.0),
      disableText: Color.fromRGBO(173, 225, 177, 1),
      agePickerText: Color.fromRGBO(222, 226, 229, 1),
      dangerText: Color.fromRGBO(187, 13, 13, 1),
      linkText: Color.fromRGBO(75, 103, 196, 1),
      border: Color.fromRGBO(208, 214, 218, 1),
      icon: Color.fromRGBO(148, 161, 169, 1.0),
      medalEmpty: Color.fromRGBO(242, 243, 245, 1),
      medalBronze: Color.fromRGBO(145, 83, 29, 1),
      medalSilver: Color.fromRGBO(169, 178, 178, 1),
      medalGold: Color.fromRGBO(205, 165, 97, 1),
    );
  }

  factory AppColors.dark() {
    return const AppColors(
      primary: Color.fromRGBO(13, 187, 108, 1),
      background: Color.fromRGBO(27, 27, 27, 1),
      accent: Color.fromRGBO(255, 126, 11, 1.0),
      primaryText: Color.fromRGBO(13, 187, 108, 1),
      secondaryText: Color.fromRGBO(254, 254, 254, 1),
      descriptionText: Color.fromRGBO(17, 17, 17, 1),
      enableText: Color.fromRGBO(254, 254, 254, 1),
      disableText: Color.fromRGBO(173, 225, 177, 1),
      agePickerText: Color.fromRGBO(222, 226, 229, 1),
      dangerText: Color.fromRGBO(187, 13, 13, 1),
      linkText: Color.fromRGBO(75, 103, 196, 1),
      border: Color.fromRGBO(208, 214, 218, 1.0),
      icon: Color.fromRGBO(148, 161, 169, 1),
      medalEmpty: Color.fromRGBO(242, 243, 245, 1),
      medalBronze: Color.fromRGBO(145, 83, 29, 1),
      medalSilver: Color.fromRGBO(169, 178, 178, 1),
      medalGold: Color.fromRGBO(205, 165, 97, 1),
    );
  }
}
