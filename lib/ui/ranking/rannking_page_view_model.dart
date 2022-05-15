import 'dart:convert';

import 'package:best_beer_ranking/data/foundation/keys.dart';
import 'package:best_beer_ranking/data/model/category.dart';
import 'package:best_beer_ranking/data/repository/category_repository.dart';
import 'package:best_beer_ranking/ui/dialog_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/data/provider/shared_preference_provider.dart';
import 'package:best_beer_ranking/data/repository/record_repository.dart';

final rankingViewModelProvider =
    ChangeNotifierProvider((ref) => RankingViewModel(ref.read));

class RankingViewModel extends ChangeNotifier {

  RankingViewModel(this._reader);

  final Reader _reader;
  List<Record> _records = [];
  List<Record> get records => _records;

  Category? _category;
  Category? get category => _category;

  late final _recordRepository = _reader(recordRepositoryProvider);
  late final _categoryRepository = _reader(categoryRepositoryProvider);
  late final _sharedPreferencesManager = _reader(sharedPreferencesManagerProvider);

  checkHasCategory(BuildContext context) async {
    final category = await _sharedPreferencesManager.getCategory();
    if (category != null) {
      _category = category;
      notifyListeners();
      return;
    }
    var inputText = "";
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('ランキングのカテゴリを入力してください'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              TextField(
                decoration: InputDecoration(hintText: "カテゴリを入力"),
                onChanged: (text) {
                  inputText = text;
                },
              ),
              SizedBox(height: 16,),
              Text("カテゴリは複数設定することができます", style: TextStyle(fontSize: 12),)
            ],),
            actions: <Widget>[
              TextButton(
                child: Text('設定する'),
                onPressed: () async {
                  final category = await _categoryRepository.postCategory(inputText);
                  _category = category;
                  _sharedPreferencesManager.setCategory(category);
                  Navigator.pop(context);
                  notifyListeners();
                },
              ),
            ],
          );
        });
  }

  loadData() async {
    final category = await _sharedPreferencesManager.getCategory();
    if (category == null) {
      return;
    }
    _records = await _recordRepository.getRankingRecords(category.id);
    notifyListeners();
  }

  updateOrder(int oldIndex, int newIndex) {
    final record = records.removeAt(oldIndex);
    _records.insert(newIndex, record);
    _recordRepository.updateRanking(_records);
    notifyListeners();
  }

  updateRankingWithPoint() {
    _recordRepository.updateRankingWithPoint(_records);
    refresh();
  }

  refresh() async {
    final category = await _sharedPreferencesManager.getCategory();
    if (category != null) {
      _category = category;
      _records = await _recordRepository.getRankingRecords(category.id);
      notifyListeners();
      return;
    }
  }

}
