import 'package:best_beer_ranking/gen/assets.gen.dart';
import 'package:best_beer_ranking/theme/app_theme.dart';
import 'package:best_beer_ranking/theme/layout_size.dart';
import 'package:best_beer_ranking/utils/ad_util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:best_beer_ranking/navigation/app_route_delegate.dart';
import 'package:best_beer_ranking/ui/hook/use_l10n.dart';

enum TabType { home, ranking, everyone, mypage  }

final tabTypeProvider = StateProvider<TabType>((ref) => TabType.home);

class TopTabPage extends HookConsumerWidget {
  const TopTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigator = ref.watch(appNavigationStackProvider.notifier);
    final color = ref.watch(appThemeProvider).appColors;

    final tabType = ref.watch(tabTypeProvider.state);
    final _screens = [
      rankingPage.child,
      logPage.child,
      everyoneRankingPage.child,
      myPage.child
    ];

    return Scaffold(
      body: _screens[tabType.state.index],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: color.accent,
        onPressed: () {
          navigator.input();
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabType.state.index,
        onTap: (int selectIndex) {
          tabType.state = TabType.values[selectIndex];
        },
        selectedFontSize: 12,
        unselectedFontSize: 12,
        enableFeedback: false,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              icon: Assets.svgs.crown.svg(
                  width: LayoutSize.sizeBox30,
                  height: LayoutSize.sizeBox30,
                  color: Colors.grey),
              activeIcon: Assets.svgs.crown.svg(
                  width: LayoutSize.sizeBox30,
                  height: LayoutSize.sizeBox30,
                  color: Colors.black87),
              label: 'ランキング'),
          BottomNavigationBarItem(
              icon: Assets.svgs.log.svg(
                  width: LayoutSize.sizeBox30,
                  height: LayoutSize.sizeBox30,
                  color: Colors.grey),
              activeIcon: Assets.svgs.log.svg(
                  width: LayoutSize.sizeBox30,
                  height: LayoutSize.sizeBox30,
                  color: Colors.black87),
              label: 'ログ'),
          BottomNavigationBarItem(
              icon: Assets.svgs.crown.svg(
                  width: LayoutSize.sizeBox30,
                  height: LayoutSize.sizeBox30,
                  color: Colors.grey),
              activeIcon: Assets.svgs.crown.svg(
                  width: LayoutSize.sizeBox30,
                  height: LayoutSize.sizeBox30,
                  color: Colors.black87),
              label: 'みんなのランキング'),
          BottomNavigationBarItem(
              icon: Assets.svgs.crown.svg(
                  width: LayoutSize.sizeBox30,
                  height: LayoutSize.sizeBox30,
                  color: Colors.grey),
              activeIcon: Assets.svgs.crown.svg(
                  width: LayoutSize.sizeBox30,
                  height: LayoutSize.sizeBox30,
                  color: Colors.black87),
              label: 'マイページ'),
        ],
      ),
    );
  }
}
