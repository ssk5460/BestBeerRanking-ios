import 'dart:convert';

import 'package:best_beer_ranking/data/foundation/keys.dart';
import 'package:best_beer_ranking/data/model/category.dart';
import 'package:best_beer_ranking/data/provider/shared_preference_provider.dart';
import 'package:best_beer_ranking/data/repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rankingDrawerViewModelProvider =
    ChangeNotifierProvider((ref) => RankingDrawerViewModel(ref.read));

class RankingDrawerViewModel extends ChangeNotifier {

  RankingDrawerViewModel(this._reader);

  final Reader _reader;
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  Category? _defaultCategory;
  Category? get defaultCategory => _defaultCategory;

  late final _categoryRepository = _reader(categoryRepositoryProvider);
  late final _pref = _reader(prefsProvider);


  loadData() async {
    _categories = await _categoryRepository.getCategories();
    notifyListeners();
  }

  Future<void> postCategory(String inputText) async {
    final category = await _categoryRepository.postCategory(inputText);
    setDefaultCategory(category);
    await loadData();
    notifyListeners();
  }

  Future<Category> getDefaultCategory() async {
    Map<String, dynamic> map = await jsonDecode(_pref.getString(Keys.defaultCategpory)!);
    final data = Category.fromJson(map);
    return data;
  }

  Future<bool> isDefaultCategory(Category category) async {
    Map<String, dynamic> userMap = await jsonDecode(_pref.getString(Keys.defaultCategpory)!);
    final data = Category.fromJson(userMap);
    return category.id == data.id;
  }

  setDefaultCategory(Category category) async {
    await _pref.setString(Keys.defaultCategpory, jsonEncode(category));
    _defaultCategory = category;
    notifyListeners();
  }

  deleteCategory(BuildContext context, Category category) async {
    await _categoryRepository.deleteCategory(category.id);
    await loadData();
  }
}
