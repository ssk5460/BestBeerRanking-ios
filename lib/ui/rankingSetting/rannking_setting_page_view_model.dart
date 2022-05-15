import 'dart:convert';

import 'package:best_beer_ranking/data/foundation/keys.dart';
import 'package:best_beer_ranking/data/model/category.dart';
import 'package:best_beer_ranking/data/repository/category_repository.dart';
import 'package:best_beer_ranking/data/repository/ranking_repository.dart';
import 'package:best_beer_ranking/data/repository/user_repository.dart';
import 'package:best_beer_ranking/ui/dialog_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/data/provider/shared_preference_provider.dart';
import 'package:best_beer_ranking/data/repository/record_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;


final rankingSettingViewModelProvider =
    ChangeNotifierProvider((ref) => RankingSettingViewModel(ref.read));

class RankingSettingViewModel extends ChangeNotifier {

  RankingSettingViewModel(this._reader);

  final Reader _reader;
  List<Record> _records = [];
  List<Record> get records => _records;

  bool _isEnterdRanking = false;
  bool get isEnterdRanking => _isEnterdRanking;

  late final _userRepository = _reader(userRepositoryProvider);
  late final _recordRepository = _reader(recordRepositoryProvider);
  late final _rankingRepository = _reader(rankingRepositoryProvider);
  late final _sharedPreferencesManager = _reader(sharedPreferencesManagerProvider);

  loadData(Record record) async {
    final category = await _sharedPreferencesManager.getCategory();
    if (category == null) {
      return;
    }
    _records = await _recordRepository.getRankingRecords(category.id);
    if (_records.isEmpty) {
      await _recordRepository.updateRanking([record]);
      _records = await _recordRepository.getRankingRecords(category.id);
      _isEnterdRanking = true;
    } else if (_records.where((element) => element.id == record.id).isEmpty) {
      _records.insert(0, record);
      _isEnterdRanking = false;
    } else {
      _isEnterdRanking = true;
    }
    notifyListeners();
  }

  updateOrder(int oldIndex, int newIndex) async {
    final record = records.removeAt(oldIndex);
    if (record.ranking == null) {
      _isEnterdRanking = true;
    }
    _records.insert(newIndex, record);
    _recordRepository.updateRanking(_records);
    notifyListeners();
  }

  done() async {
    final category = await _sharedPreferencesManager.getCategory();
    if (category == null) {
      return;
    }

    final auth = firebase_auth.FirebaseAuth.instance.currentUser;
    if (auth != null) {
      final user = await _userRepository.getUser(auth.uid);
      if (user != null) {
        final data = await _recordRepository.getRankingRecords(category.id);
        await _rankingRepository.postRanking(user, category, data);
      }
    }
    _records.clear();
    _isEnterdRanking = false;
  }
}
