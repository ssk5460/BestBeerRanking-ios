import 'package:best_beer_ranking/data/foundation/extension/padding.dart';
import 'package:best_beer_ranking/gen/assets.gen.dart';
import 'package:best_beer_ranking/theme/app_theme.dart';
import 'package:best_beer_ranking/theme/layout_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LayoutUtil {

  static Widget getRankingWidget(WidgetRef ref, int ranking) {
    final appColors = ref.read(appThemeProvider).appColors;
    if (ranking < 4) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Center(
            child: Assets.svgs.crown.svg(
                width: LayoutSize.sizeBox50,
                height: LayoutSize.sizeBox50,
                color: appColors.rankingColor(ranking)),
          ),
          Text(
            "${ranking}",
            style: TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ).padding(bottom: 6)
        ],
      );
    } else {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${ranking}",
                    style: TextStyle(fontSize: 28, color: Colors.black),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text("位",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))
                      .padding(bottom: 6)
                ],
              ))
        ],
      );
    }
  }
}
