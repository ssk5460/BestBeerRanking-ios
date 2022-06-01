import 'package:best_beer_ranking/data/model/category.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/ui/everyoneRanking/everyone_ranking_page.dart';
import 'package:best_beer_ranking/ui/log/log_page.dart';
import 'package:best_beer_ranking/ui/mypage/my_page.dart';
import 'package:best_beer_ranking/ui/setting/setting.dart';
import 'package:best_beer_ranking/ui/rankingCategoryDetail/ranking_category_detail_page.dart';
import 'package:best_beer_ranking/ui/rankingSetting/ranking_setting_page.dart';
import 'package:best_beer_ranking/ui/recordDetail/record_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:best_beer_ranking/navigation/app_route_path.dart';
import 'package:best_beer_ranking/data/provider/shared_preference_provider.dart';
import 'package:best_beer_ranking/ui/input/input_page.dart';
import 'package:best_beer_ranking/ui/ranking/ranking_page.dart';
import 'package:best_beer_ranking/ui/top_tab_page.dart';

final _appNavigatorKeyProvider =
Provider<GlobalKey<NavigatorState>>((_) => GlobalKey<NavigatorState>());

final appRouteDelegateProvider = Provider((ref) => AppRouteDelegate(ref));

class AppRouteDelegate extends RouterDelegate<AppRoutePath>
    with PopNavigatorRouterDelegateMixin, ChangeNotifier {
  final Ref ref;

  AppRouteDelegate(this.ref);

  @override
  Widget build(BuildContext context) => Navigator(
    key: navigatorKey,
    pages: ref.watch(appNavigationStackProvider),
    onPopPage: (route, result) {
      ref.watch(appNavigationStackProvider.notifier).pop();
      return false;
    },
  );

  @override
  GlobalKey<NavigatorState>? get navigatorKey =>
      ref.read(_appNavigatorKeyProvider);

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {}
}

typedef AppPage = MaterialPage<void>;
typedef AppPageKey = ValueKey<String>;

final appNavigationStackProvider =
    StateNotifierProvider<AppNavigationStack, List<AppPage>>(
        (ref) => AppNavigationStack(ref));

final initialAppNavigationStack = Provider<List<AppPage>>((ref) {
  final pref = ref.read(prefsProvider);
  // アプリ起動時の端末のデータをチェックして制御できる
  return [topTabPage];
});

const topTabPage = AppPage(key: AppPageKey('topTabPage'), child: TopTabPage(), maintainState: false);
// Home page
const logPage = AppPage(key: AppPageKey('log'), child: LogPage());
// Ranking page
const rankingPage = AppPage(key: AppPageKey('ranking'), child: RankingPage(), maintainState: false);
// Everyone Ranking page
const everyoneRankingPage = AppPage(key: AppPageKey('ranking'), child: EveryoneRankingPage(), maintainState: false);
// my page
const myPage = AppPage(key: AppPageKey('ranking'), child: MyPage(), maintainState: false);
// setting
const settingPage = AppPage(key: AppPageKey('setting'), child: SettingPage(), maintainState: false);

// Input page
const inputPage = AppPage(key: AppPageKey('input'), child: InputPage(), maintainState: false);

// Ranking page
recordSettingPage(Record record) => AppPage(
    key: AppPageKey('RankingSettingPage'),
    child: RankingSettingPage(
      record: record,
    ),
    maintainState: false
);

// Ranking page
categoryDetailPage(Category category) => AppPage(
    key: AppPageKey('RankingCategoryDetailPage'),
    child: RankingCategoryDetailPage(
      category: category,
    ),
    maintainState: false
);

// Home page
recordDetailPage(Record record) => AppPage(
    key: AppPageKey('RankingCategoryPage'),
    child: RecordDetailPage(
      record: record,
    ),
    maintainState: false);

class AppNavigationStack extends StateNotifier<List<AppPage>> {
  final Ref ref;

  AppNavigationStack(this.ref) : super(ref.watch(initialAppNavigationStack));

  void pop() =>
      state = state.length == 1 ? state : List.from(state..removeLast());

  void topTab() {
    state.remove(topTabPage);
    state = List.from(state..add(topTabPage));
  }

  void log() {
    state.remove(logPage);
    state = List.from(state..add(logPage));
  }

  void replaceHome() {
    state.removeLast();
    log();
  }

  void popUntilHome() {
    List<AppPage> listPage = [];
    for (var i = state.length - 1; i >= 0; i--) {
      if (state[i] != logPage) {
        listPage = List.from(state..removeLast());
      }
    }
    if (listPage.isNotEmpty) {
      state = listPage;
    }
  }

  void input() {
    state.remove(inputPage);
    state = List.from(state..add(inputPage));
  }

  void setting() {
    state.remove(settingPage);
    state = List.from(state..add(settingPage));
  }

  void recordDetail(Record record) {
    state.remove(recordDetailPage(record));
    state = List.from(state..add(recordDetailPage(record)));
  }

  void recordSetting(Record record) {
    state.remove(recordSettingPage(record));
    state = List.from(state..add(recordSettingPage(record)));
  }

  void categoryDetail(Category category) {
    state.remove(categoryDetailPage(category));
    state = List.from(state..add(categoryDetailPage(category)));
  }
}
