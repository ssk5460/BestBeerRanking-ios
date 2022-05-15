import 'package:best_beer_ranking/data/foundation/extension/padding.dart';
import 'package:best_beer_ranking/data/model/category.dart';
import 'package:best_beer_ranking/gen/assets.gen.dart';
import 'package:best_beer_ranking/navigation/app_route_delegate.dart';
import 'package:best_beer_ranking/theme/app_theme.dart';
import 'package:best_beer_ranking/theme/layout_size.dart';
import 'package:best_beer_ranking/ui/dialog_util.dart';
import 'package:best_beer_ranking/ui/ranking/rannking_page_view_model.dart';
import 'package:best_beer_ranking/ui/ranking/ranking_drawer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RankningDrawer extends HookConsumerWidget {
  const RankningDrawer({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final scaffoldKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rankingCategoryViewModel = ref.read(rankingDrawerViewModelProvider);
    useFuture(
      useMemoized(() {
        rankingCategoryViewModel.loadData();
      }),
    );
    final categories = ref.watch(rankingDrawerViewModelProvider).categories;
    return Drawer(
      elevation: 4,
      child: ListView.builder(
        itemCount: categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _addRankingCategoryCell(context, ref);
          }
          final category = categories[index - 1];
          return _rankingCategoryCell(context, ref, category);
        },
      )
    );
  }

  Widget _addRankingCategoryCell(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appThemeProvider).appColors;
    return Column(children: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(primary: appColors.accent),
        onPressed: (){
          showAddCategoryDialog(context, ref);
          },
        child: Text("新しいランキングを追加"),).padding(top: 16, bottom: 16),
      Divider(color: Colors.black38,)
    ],);
  }

  showAddCategoryDialog(BuildContext context, WidgetRef ref) async {
    final rankingCategoryViewModel = ref.read(rankingDrawerViewModelProvider);
    var inputText = "";
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('ランキングを入力してください'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(hintText: "ランキング名を入力"),
                  onChanged: (text) {
                    inputText = text;
                  },
                ),
                SizedBox(height: 16,),
                Text("追加後はランキング画面に表示するランキングとして設定されます", style: TextStyle(fontSize: 12),)
              ],),
            actions: <Widget>[
              TextButton(
                child: Text('登録する', style: TextStyle(color: Colors.deepOrangeAccent),),
                onPressed: () async {
                  Navigator.pop(context);
                  rankingCategoryViewModel.postCategory(inputText);
                },
              ),
            ],
          );
        });
  }

  Widget _rankingCategoryCell(BuildContext context, WidgetRef ref, Category category) {
    final navigator = ref.watch(appNavigationStackProvider.notifier);
    final rankingCategoryViewModel = ref.read(rankingDrawerViewModelProvider);

    final _ = ref.watch(rankingDrawerViewModelProvider).defaultCategory;
    return FutureBuilder(
      future: rankingCategoryViewModel.isDefaultCategory(category),
      builder: (context, AsyncSnapshot<bool> data) {
        final isDefault = data.data ?? false;
        return Column(children: [
          ListTile(
            contentPadding: EdgeInsets.all(8),
            dense: true,
            title: Text(
              category.title,
              style: const TextStyle(fontSize: 15),
            ),
            leading: (() { // 即時関数を使う
              if (isDefault) {
                return Icon(Icons.check, color: Colors.black, size: 32,);
              } else {
                return SizedBox(width: 0,);
              }
            })(),
            trailing: IconButton(
              icon: Icon(Icons.edit, color: Colors.black45),
              onPressed: () async {
                navigator.categoryDetail(category);
              },
            ),
            onTap: () async {
              DialogUtil.showAlertDialog(
                  context: context,
                  message: "ランキング画面に表示するランキングとして設定しますか？",
                  onPositivePress: () {
                    rankingCategoryViewModel.setDefaultCategory(category);
                    Navigator.pop(context);
                  },
                  onNegativePress: () {
                    Navigator.pop(context);
                  });
            },
          ),
          Divider(color: Colors.black38,)
        ],);
      },
    );
  }
}
