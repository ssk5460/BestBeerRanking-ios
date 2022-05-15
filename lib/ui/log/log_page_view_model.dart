import 'dart:convert';

import 'package:best_beer_ranking/data/foundation/keys.dart';
import 'package:best_beer_ranking/data/model/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/data/provider/shared_preference_provider.dart';
import 'package:best_beer_ranking/data/repository/record_repository.dart';

final logViewModelProvider =
    ChangeNotifierProvider((ref) => LogViewModel(ref.read));

enum LogSection {
  latest,
  oldest,
  outOfRanking
}

class LogViewModel extends ChangeNotifier {


  LogViewModel(this._reader);

  final Reader _reader;
  List<Record> _records = [];
  List<Record> _displyRecords = [];
  List<Record> get records => _displyRecords;

  int _selectedSegmentedControlIndex = 0;
  int get selectedSegmentedControlIndex => _selectedSegmentedControlIndex;

  final logSegmentedControl = {
    LogSection.latest.index: Text('最新順', style: TextStyle(color: Colors.black, fontSize: 14),),
    LogSection.oldest.index: Text('最古順', style: TextStyle(color: Colors.black, fontSize: 14)),
    LogSection.outOfRanking.index: Text('ランキング外', style: TextStyle(color: Colors.black, fontSize: 14))
  };

  late final _recordRepository = _reader(recordRepositoryProvider);
  late final _sharedPreferencesManager = _reader(sharedPreferencesManagerProvider);

  setSegmentedControlIndex(int index) async {
    _selectedSegmentedControlIndex = index;
    final logSection = LogSection.values[index];
    switch (logSection) {
      case LogSection.latest:
        _records.sort((a,b) => (b.recordedAt!).compareTo((a.recordedAt!)));
        _displyRecords = _records;
        break;
      case LogSection.oldest:
        _records.sort((a,b) => (a.recordedAt!).compareTo((b.recordedAt!)));
        _displyRecords = _records;
        break;
      case LogSection.outOfRanking:
        _displyRecords = _records
            .where((Record value) => value.ranking == null)
            .toList();
        break;
    }
    notifyListeners();
  }

  loadHomeData() async {
    final category = await _sharedPreferencesManager.getCategory();
    if (category == null) {
      return;
    }
    final result = await _recordRepository.getRecords(category.id);
    await result.when(success: (data) async {
      _records = data;
      setSegmentedControlIndex(0);
    }, failure: (e) {
    });
  }
}
