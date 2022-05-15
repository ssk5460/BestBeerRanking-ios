import 'dart:io';
import 'dart:ui';

import 'package:best_beer_ranking/data/foundation/extension/padding.dart';
import 'package:best_beer_ranking/data/model/category.dart';
import 'package:best_beer_ranking/data/model/ranking.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/ext/HexColor.dart';
import 'package:best_beer_ranking/gen/assets.gen.dart';
import 'package:best_beer_ranking/navigation/app_route_delegate.dart';
import 'package:best_beer_ranking/theme/app_theme.dart';
import 'package:best_beer_ranking/theme/layout_size.dart';
import 'package:best_beer_ranking/ui/everyoneRanking/everyone_rannking_page_view_model.dart';
import 'package:best_beer_ranking/ui/layout_util.dart';
import 'package:best_beer_ranking/ui/ranking/ranking_drawer.dart';
import 'package:best_beer_ranking/ui/ranking/rannking_page_view_model.dart';
import 'package:best_beer_ranking/utils/image_utils.dart';
import 'package:best_beer_ranking/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

class EveryoneRankingPage extends HookConsumerWidget {
  const EveryoneRankingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(everyoneRankingViewModelProvider);
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    useFuture(
      useMemoized(() {
        viewModel.loadData();
      }),
    );
    final rankings = ref.watch(everyoneRankingViewModelProvider).rankings;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black12,
        body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (rankings.isEmpty) {
            return Text("no ranking");
          }
          return _rankingWidget(rankings[index], context, ref);
          },
          itemCount: rankings.length,
        ),
    );
  }

  Widget _rankingWidget(Ranking ranking, BuildContext context, WidgetRef ref) {
    var filteredData = ranking.records
        .where((value) => value.ranking != null)
        .toList();
    filteredData.sort((a,b) => (a.ranking!).compareTo((b.ranking!)));
    return Container(
        color: Colors.white,
        child: Column(children: [
          Center(
              child: Text(
                ranking.category.title,
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: HexColor.fromHex(
                        ranking.category.hexColor.isNotEmpty
                            ? ranking.category.hexColor : "#1D1C1C"),
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black26,
                        offset: Offset(2.0, 2.0),
                      ),
                    ]),
              )).paddingEdge(EdgeInsets.all(10.0)),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return _itemBuilder(ref, ranking.category, filteredData[index]);
            },
            itemCount: filteredData.length,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            (() {
              final photoUrl = ranking.user.photoUrl ?? "";
              if (photoUrl.isNotEmpty) {
                return CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(photoUrl),
                  backgroundColor: Colors.transparent,
                );
              }
              return Icon(
                Icons.account_circle,
                size: 32,
                color: Colors.black45,
              );
            })(),
            SizedBox(width: 4,),
            Text(
              '${ranking.user.name}',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 18),
            ),
              SizedBox(width: 8,),
          ],).paddingEdge(EdgeInsets.fromLTRB(8, 8, 16, 8))
        ],)
    ).paddingEdge(EdgeInsets.fromLTRB(16, 16, 16, 16));
  }

  Widget _itemBuilder(WidgetRef ref, Category category, Record record) {
    final card = Card(
      elevation: 4.0,
      key: Key("${record.id}"),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (() {
            // 即時関数を使う
            if (category.isShowThumbnail == true) {
              return Container(
                width: 80,
                height: 80,
                color: Colors.black12,
                child: record.image ??
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
                child: LayoutUtil.getRankingWidget(ref, record.ranking ?? 0),
              ).paddingEdge(EdgeInsets.fromLTRB(8, 8, 8, 8)),
            ],
          ),
          Flexible(
              child: Text(record.title)
                  .padding(left: 8, top: 20, right: 16, bottom: 16)),
        ],
      ),
    );
    return card.paddingEdge(EdgeInsets.fromLTRB(8, 4, 8, 4));
  }
}
