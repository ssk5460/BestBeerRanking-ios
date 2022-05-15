import 'package:best_beer_ranking/data/foundation/extension/padding.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/navigation/app_route_delegate.dart';
import 'package:best_beer_ranking/theme/layout_size.dart';
import 'package:best_beer_ranking/ui/layout_util.dart';
import 'package:best_beer_ranking/ui/rankingSetting/rannking_setting_page_view_model.dart';
import 'package:best_beer_ranking/utils/ad_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RankingSettingPage extends HookConsumerWidget {

  final Record record;

  const RankingSettingPage({Key? key, required this.record}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(rankingSettingViewModelProvider);
    final navigator = ref.watch(appNavigationStackProvider.notifier);
    useFuture(
      useMemoized(() {
        viewModel.loadData(record);
      }),
    );

    final records = ref.watch(rankingSettingViewModelProvider).records;

    
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "ランキング設定画面",
              style: TextStyle(color: Colors.black),
            ),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    await viewModel.done();
                    navigator.pop();
                    navigator.pop();
                    AdUtil.showAdFullscreenInterstitial();
                  },
                  child: Text("完了", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),))
            ],
          ),
          body: Container(
            child: ReorderableListView(
              padding: EdgeInsets.all(10.0),
              header: Container(
                child: Text("ランキングは記録したログをドラック&ドロップすることで変更できます。\n"
                    "【ドラック&ドロップの方法】\n"
                    "1.記録したログを長押しします\n"
                    "2.長押ししたまま動かすとランキングが変更できます\n\n"
                    "？のまま『完了』を押すとランキング外のログとして記録されます。"
                    "ログ詳細画面でランキングへの追加/変更/外すこともできます")
                    .paddingEdge(EdgeInsets.all(4)),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Colors.deepOrangeAccent//枠線の太さ
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ).paddingEdge(EdgeInsets.fromLTRB(0, 0, 0, 16)),
              onReorder: (oldIndex, newIndex) {
                if (oldIndex < newIndex) {
                  // removing the item at oldIndex will shorten the list by 1.
                  newIndex -= 1;
                }
                viewModel.updateOrder(oldIndex, newIndex);
              },
              children: _itemBuilder(ref, records),
            ),
          )),
    );
  }

  List<Widget> _itemBuilder(WidgetRef ref, List<Record> records) {
    List<Card> cards = [];
    records.asMap().forEach((index, record) {
      final card = Card(
        elevation: 2.0,
        key: Key("${record.id}"),
        child: ListTile(
          leading: recordRankingNumber(ref, record, index),
          title: Text(record.title)),
      );
      cards.add(card);
    });
    return cards;
  }

  Widget recordRankingNumber(WidgetRef ref, Record record, int index) {
    final viewModel = ref.read(rankingSettingViewModelProvider);
    if (index == 0 && !viewModel.isEnterdRanking) {
      return Container(
        width: 56,
        height: 56,
        child: Center(
            child: Container(
              color: Colors.black12,
              width: 44,
              height: 44,
              child: Center(child: Text("?", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.black),),))
        ),
      );
    } else {
      final ranking = viewModel.isEnterdRanking ? index + 1 : index;
      return Container(
        width: LayoutSize.sizeIcon50,
        height: LayoutSize.sizeIcon50,
        child: LayoutUtil.getRankingWidget(ref, ranking),
      );
    }
  }
}
