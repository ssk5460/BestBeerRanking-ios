import 'package:best_beer_ranking/data/model/ranking.dart';
import 'package:best_beer_ranking/data/model/user.dart';
import 'package:best_beer_ranking/data/repository/ranking_repository.dart';
import 'package:best_beer_ranking/data/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final everyoneRankingViewModelProvider =
    ChangeNotifierProvider((ref) => EveryoneRankingViewModel(ref.read));

enum EveryoneRankingViewSection {
  watch,
  all
}

class EveryoneRankingViewModel extends ChangeNotifier {

  EveryoneRankingViewModel(this._reader);

  final Reader _reader;
  List<Ranking> _rankings = [];
  List<Ranking> get rankings => _rankings;

  List<User> _watchUsers = [];


  late final _rankingRepository = _reader(rankingRepositoryProvider);
  late final _userRepository = _reader(userRepositoryProvider);

  int _selectedSegmentedControlIndex = 0;
  int get selectedSegmentedControlIndex => _selectedSegmentedControlIndex;

  final segmentedControls = {
    EveryoneRankingViewSection.watch.index: Text('ウォッチ', style: TextStyle(color: Colors.black, fontSize: 14),),
    EveryoneRankingViewSection.all.index: Text('すべて', style: TextStyle(color: Colors.black, fontSize: 14)),
  };

  loadData({EveryoneRankingViewSection section = EveryoneRankingViewSection.watch}) async {
    _watchUsers = await _userRepository.getWatchUsers();
    _rankings = await _rankingRepository.getWatchUserRankings(_watchUsers);
    notifyListeners();
  }

  setSegmentedControlIndex(int index) async {
    _selectedSegmentedControlIndex = index;
    final section = EveryoneRankingViewSection.values[index];
    switch (section) {
      case EveryoneRankingViewSection.watch:
        _watchUsers = await _userRepository.getWatchUsers();
        _rankings = await _rankingRepository.getWatchUserRankings(_watchUsers);
        notifyListeners();
        break;
      case EveryoneRankingViewSection.all:
        _rankings = await _rankingRepository.getRankings();
        notifyListeners();
        break;
    }
    notifyListeners();
  }

  bool isWatchedUser(User user) {
    final watched = _watchUsers.contains(user);
    return watched;
  }
  
  Future<void> watchUser(User user) async {
    await _userRepository.watchUser(user);
  }

  Future<void> unWatchUser(User user) async {
    await _userRepository.unWatchUser(user);
  }

}
