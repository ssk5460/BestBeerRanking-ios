import 'dart:io';
import 'dart:ui';

import 'package:best_beer_ranking/data/foundation/extension/padding.dart';
import 'package:best_beer_ranking/ext/HexColor.dart';
import 'package:best_beer_ranking/gen/assets.gen.dart';
import 'package:best_beer_ranking/theme/app_theme.dart';
import 'package:best_beer_ranking/theme/layout_size.dart';
import 'package:best_beer_ranking/ui/dialog_util.dart';
import 'package:best_beer_ranking/ui/layout_util.dart';
import 'package:best_beer_ranking/ui/ranking/ranking_drawer.dart';
import 'package:best_beer_ranking/ui/ranking/ranking_drawer_view_model.dart';
import 'package:best_beer_ranking/utils/image_utils.dart';
import 'package:best_beer_ranking/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/navigation/app_route_delegate.dart';
import 'package:best_beer_ranking/ui/ranking/rannking_page_view_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

class RankingPage extends HookConsumerWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(rankingViewModelProvider);
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    useFuture(
      useMemoized(() {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          viewModel.checkHasCategory(context);
        });
        viewModel.loadData();
      }),
    );

    final records = ref.watch(rankingViewModelProvider).records;
    final category = ref.watch(rankingViewModelProvider).category;
    final GlobalKey shareKey = GlobalKey();
    var hexColor = category?.hexColor ?? "";
    if (hexColor.isEmpty) {
      hexColor = "#1D1C1C";
    }
    final color = HexColor.fromHex(hexColor);
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black12,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            icon: Assets.svgs.menu.svg(),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.black,
              ),
              onPressed: () async {
                showShareDialog(shareKey, context, ref);
              },
            ),
          ],
        ),
        drawer: SafeArea(
            child: SizedBox(
                width: Utils.getWidthWithPercent(context, 0.8),
                child: RankningDrawer(
                  scaffoldKey: _scaffoldKey,
                ))),
        onDrawerChanged: (isOpen) {
          if (!isOpen) {
            viewModel.refresh();
          }
        },
        body: SingleChildScrollView(
            child: RepaintBoundary(
          key: shareKey,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              color: Colors.white,
              child: ReorderableListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                header: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                      child: Text(
                    category?.title ?? "",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: color,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black26,
                            offset: Offset(2.0, 2.0),
                          ),
                        ]),
                  )),
                ),
                padding: EdgeInsets.all(10.0),
                onReorder: (oldIndex, newIndex) {
                  if (oldIndex < newIndex) {
                    // removing the item at oldIndex will shorten the list by 1.
                    newIndex -= 1;
                  }
                  viewModel.updateOrder(oldIndex, newIndex);
                },
                children: _itemBuilder(ref, records),
              ),
            ),
          ),
        )));
  }

  List<Widget> _itemBuilder(WidgetRef ref, List<Record> records) {
    final appColors = ref.read(appThemeProvider).appColors;
    final navigator = ref.watch(appNavigationStackProvider.notifier);
    List<Widget> cards = [];
    records.asMap().forEach((index, record) {
      final ranking = index + 1;
      final rankingWidget = LayoutUtil.getRankingWidget(ref, ranking);
      final category = ref.watch(rankingViewModelProvider).category;
      final card = Card(
        elevation: 4.0,
        key: Key("${record.id}"),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (() {
              // 即時関数を使う
              if (category?.isShowThumbnail == true) {
                return Container(
                  width: 80,
                  height: 80,
                  color: Colors.black12,
                  child: Utils.imageFromBase64String(record.imageBase64String) ??
                      Icon(
                        Icons.image_outlined,
                        color: Colors.black45,
                        size: 48,
                      ),
                ).paddingEdge(EdgeInsets.all(4));
              } else {
                return Container();
              }
            })(),
            Column(
              children: [
                Container(
                  width: LayoutSize.sizeIcon50,
                  height: LayoutSize.sizeIcon50,
                  child: rankingWidget,
                ).paddingEdge(EdgeInsets.fromLTRB(8, 8, 8, 8)),
              ],
            ),
            Flexible(
                child: Text(record.title)
                    .padding(left: 8, top: 20, right: 16, bottom: 16)),
          ],
        ),
      );

      final widget = GestureDetector(
        key: Key("${record.id}"),
        child: card,
        onTap: () {
          navigator.recordDetail(record);
        },
      );
      cards.add(widget);
    });
    return cards;
  }

  showShareDialog(GlobalKey shareKey, BuildContext context, WidgetRef ref) async {
    final bytes = await ImageUtils.exportToImage(shareKey);
    final appColors = ref.watch(appThemeProvider).appColors;
    final Image image = Image.memory(bytes.buffer.asUint8List(), fit: BoxFit.contain,);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 440,
                  child: Container(child: image, color: Colors.black12,),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 240,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: appColors.accent),
                    onPressed: () async {
                      final widgetImageBytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
                      final applicationDocumentsFile = await getApplicationDocumentsFile("share", widgetImageBytes);
                      final path = applicationDocumentsFile.path;
                      await ShareExtend.share(path, "image", extraText: "#ランキングログ");
                      Navigator.pop(context);
                    },
                    child: Text("ランキング画像をシェアする"),),
                ),
                SizedBox(height: 16,),
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "閉じる",
                      style: TextStyle(color: Colors.black54,
                        decoration: TextDecoration.underline,
                      ),
                    )),
              ],
            ),
            actions: <Widget>[
            ],
          );
        });
  }

  Future<File> getApplicationDocumentsFile(String text, List<int> imageData) async {
    final directory = await getApplicationDocumentsDirectory();
    final exportFile = File('${directory.path}/$text.png');
    if (!await exportFile.exists()) {
      await exportFile.create(recursive: true);
    }
    final file = await exportFile.writeAsBytes(imageData);
    return file;
  }
}
