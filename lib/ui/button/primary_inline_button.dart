import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:best_beer_ranking/theme/app_theme.dart';
import 'package:best_beer_ranking/theme/font_size.dart';
import 'package:best_beer_ranking/theme/layout_size.dart';

class PrimaryInlineButton extends HookConsumerWidget {
  final String text;
  final VoidCallback onTap;
  final double width;
  final double height;

  const PrimaryInlineButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.text,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.read(appThemeProvider).appColors;
    return SizedBox(
      height: height,
      width: width,
      child: Card(
        margin: EdgeInsets.zero,
        color: appColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LayoutSize.borderRadius),
        ),
        elevation: 0,
        child: InkWell(
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: appColors.background, fontSize: FontSize.pt13),
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
