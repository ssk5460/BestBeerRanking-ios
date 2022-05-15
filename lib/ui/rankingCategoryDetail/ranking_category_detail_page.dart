import 'package:best_beer_ranking/data/foundation/extension/padding.dart';
import 'package:best_beer_ranking/ext/HexColor.dart';
import 'package:best_beer_ranking/navigation/app_route_delegate.dart';
import 'package:best_beer_ranking/theme/app_theme.dart';
import 'package:best_beer_ranking/theme/layout_size.dart';
import 'package:best_beer_ranking/ui/button/primary_button.dart';
import 'package:best_beer_ranking/ui/dialog_util.dart';
import 'package:best_beer_ranking/ui/ranking/ranking_drawer_view_model.dart';
import 'package:best_beer_ranking/ui/rankingCategoryDetail/ranking_category_detail_page_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/category.dart';

class RankingCategoryDetailPage extends HookConsumerWidget {
  final Category category;

  const RankingCategoryDetailPage({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(rankingCategoryDetailViewModelProvider);

    final _scaffoldKey = GlobalKey<ScaffoldState>();
    useMemoized(() {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        viewModel.setCategory(category);
      });
    });

    final isShowThumbnail =
        ref.watch(rankingCategoryDetailViewModelProvider).isShowThumbnail;
    final isShowPoint =
        ref.watch(rankingCategoryDetailViewModelProvider).isShowpoint;

    final appColors = ref.watch(appThemeProvider).appColors;

    //for navigate
    final navigator = ref.watch(appNavigationStackProvider.notifier);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "ランキング編集",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
            onPressed: () => navigator.pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: TextEditingController(text: viewModel.categoryName),
                keyboardType: TextInputType.name,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "ランキング名️",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38)),
                ),
                onChanged: (value) {
                  viewModel.setCategoryName(value);
                },
              ).padding(
                  top: LayoutSize.sizePadding30,
                  right: LayoutSize.sizePadding20,
                  left: LayoutSize.sizePadding20),
              const SizedBox(height: 24, width: 0),
              SizedBox(
                  width: 240,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: appColors.accent),
                    onPressed: () async {
                      await viewModel.updateCategoryName(category.id);
                      DialogUtil.showAlertDialog(
                          context: context, message: "変更しました");
                    },
                    child: Text("変更する"),
                  )),
              const SizedBox(height: 24, width: 0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "サムネイルの表示",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Switch(
                          value: isShowThumbnail,
                          activeColor: appColors.accent,
                          onChanged: (value) {
                            viewModel.setIsShowThumbnail(value);
                          })
                    ],
                  ),
                  Text(
                    "ONにするとランキング画面にサムネイル画像が表示されます",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  )
                ],
              ).padding(
                  top: LayoutSize.sizePadding30,
                  right: LayoutSize.sizePadding20,
                  left: LayoutSize.sizePadding20),
              Container(
                child: Text(
                  "ランキング名のカラー",
                  style: TextStyle(fontSize: 16),
                ).padding(
                    top: LayoutSize.sizePadding20,
                    right: LayoutSize.sizePadding20,
                    left: LayoutSize.sizePadding20),
                width: double.infinity,
              ),
              const SizedBox(height: 16, width: 0),
              _colorSelection(ref),
              const SizedBox(height: 60, width: 0),
              TextButton(
                  onPressed: () async {
                    final isDefaultCategory =
                        await viewModel.isDefaultCategory(category);
                    if (isDefaultCategory) {
                      DialogUtil.showAlertDialog(
                          context: context, message: "設置してるランキングは削除できません");
                      return;
                    }
                    DialogUtil.showAlertDialog(
                        context: context,
                        message: "削除しますか？",
                        positiveText: "OK",
                        onPositivePress: () async {
                          await viewModel.delete(category.id);
                          navigator.pop();
                        },
                        negativeText: "キャンセル");
                  },
                  child: Text(
                    "削除する",
                    style: TextStyle(
                      color: Colors.black54,
                      decoration: TextDecoration.underline,
                    ),
                  )),
            ],
          ),
        ));
  }

  Widget _colorSelection(WidgetRef ref) {
    final viewModel = ref.read(rankingCategoryDetailViewModelProvider);
    final hexColors = viewModel.hexColors;
    final selectedHexColor =
        ref.watch(rankingCategoryDetailViewModelProvider).selectedHexColor;
    final colors = hexColors.map((hex) => GestureDetector(
          child: Stack(
            alignment: AlignmentDirectional.center, // 子要素を中央に配置する
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: HexColor.fromHex(hex)
                )
              ).paddingEdge(EdgeInsets.all(4)),
              (() {
                // 即時関数を使う
                if (hex == selectedHexColor) {
                  return Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 36);
                } else {
                  return Container();
                }
              })(),
            ],
          ),
          onTap: () async {
            await viewModel.setColor(hex);
          },
        ));

    return SingleChildScrollView(
        child: Row(children: colors.toList()),
        scrollDirection: Axis.horizontal);
  }
}
