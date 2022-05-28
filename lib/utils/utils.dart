import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:best_beer_ranking/data/foundation/extension/date_time.dart';
import 'package:best_beer_ranking/theme/app_colors.dart';

class Utils {
  static double getWidthWithPercent(BuildContext context, double percent) {
    return MediaQuery.of(context).size.width * percent;
  }

  static double getHeightWithPercent(BuildContext context, double percent) {
    return MediaQuery.of(context).size.height * percent;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getWidgetWidth(
      BuildContext context, double totalSpace, int totalWidget) {
    return (Utils.getScreenWidth(context) - totalSpace) / totalWidget;
  }

  static String convertIntToHHmmddMMyyyy(int number) {
    return DateTime.fromMillisecondsSinceEpoch(number * 1000)
        .formatHHmmddMMyyyy();
  }

  static String convertIntToMMddyyyyHHmm(int number) {
    return DateTime.fromMillisecondsSinceEpoch(number * 1000)
        .formatMMddyyyyHHmm();
  }

  static String convertIntToHHmm(int number) {
    return DateTime.fromMillisecondsSinceEpoch(number * 1000).formatHHmm();
  }

  static String convertIntToddMMyyyy(int number) {
    return DateTime.fromMillisecondsSinceEpoch(number * 1000).formatddMMyyyy();
  }

  static String convertIntToMMddyyyy(int number) {
    return DateTime.fromMillisecondsSinceEpoch(number * 1000).formatMMddyyyy();
  }

  static String convertIntToHHmmaa(int number) {
    return DateTime.fromMillisecondsSinceEpoch(number * 1000)
        .formatHHmmaa()
        .toLowerCase();
  }

  static String convertIntToTimeAa(int number) {
    return DateTime.fromMillisecondsSinceEpoch(number * 1000)
        .formatHHmmssaa()
        .toLowerCase();
  }

  static String formatNumberDecimal(num number) {
    var formatNumber = NumberFormat.decimalPattern();
    return formatNumber.format(number);
  }

  static Image? imageFromBase64String(String? base64String) {
    final data = base64String ?? "";
    if (data.isEmpty) {
      return null;
    }
    return Image.memory(
      base64Decode(data),
      fit: BoxFit.fill,
      gaplessPlayback: true,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

}
