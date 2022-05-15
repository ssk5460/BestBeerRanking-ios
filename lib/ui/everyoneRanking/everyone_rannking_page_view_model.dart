import 'package:best_beer_ranking/data/model/ranking.dart';
import 'package:best_beer_ranking/data/repository/ranking_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final everyoneRankingViewModelProvider =
    ChangeNotifierProvider((ref) => EveryoneRankingViewModel(ref.read));

class EveryoneRankingViewModel extends ChangeNotifier {

  EveryoneRankingViewModel(this._reader);

  final Reader _reader;
  List<Ranking> _rankings = [];
  List<Ranking> get rankings => _rankings;

  late final _rankingRepository = _reader(rankingRepositoryProvider);

  loadData() async {
    _rankings = await _rankingRepository.getRankings();
    notifyListeners();
  }
}
