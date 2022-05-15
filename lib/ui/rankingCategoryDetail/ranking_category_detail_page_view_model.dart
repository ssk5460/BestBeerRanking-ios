import 'dart:convert';

import 'package:best_beer_ranking/data/foundation/keys.dart';
import 'package:best_beer_ranking/data/model/category.dart';
import 'package:best_beer_ranking/data/provider/shared_preference_provider.dart';
import 'package:best_beer_ranking/data/repository/category_repository.dart';
import 'package:best_beer_ranking/ui/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rankingCategoryDetailViewModelProvider =
    ChangeNotifierProvider((ref) => RankingCategoryDetailViewModel(ref.read));

class RankingCategoryDetailViewModel extends ChangeNotifier {

  RankingCategoryDetailViewModel(this._reader);

  final Reader _reader;
  int _categoryId = 0;
  String? get categoryName => _categoryName;
  String? _categoryName;
  bool get isShowThumbnail => _isShowThumbnail;
  bool _isShowThumbnail = false;
  bool get isShowpoint => _isShowpoint;
  bool _isShowpoint = false;
  String get selectedHexColor => _selectedHexColor;
  String _selectedHexColor = "#1D1C1C";

  List<String> hexColors = ["#1D1C1C", "#FF7E0B", "#008080", "#4350A0", "#F13E6B"];

  late final _categoryRepository = _reader(categoryRepositoryProvider);
  late final _pref = _reader(prefsProvider);

  void setCategoryName(String categoryName) {
    _categoryName = categoryName;
  }

  void setCategory(Category category) {
    _categoryId = category.id;
    _categoryName = category.title;
    _isShowThumbnail = category.isShowThumbnail;
    _isShowpoint = category.isShowPoint;
    var hexColor = category.hexColor;
    if (hexColor.isEmpty) {
      hexColor = "#1D1C1C";
    }
    _selectedHexColor = hexColor;
    notifyListeners();
  }

  setIsShowThumbnail(bool value) async {
    _isShowThumbnail = value;
    final category = await _categoryRepository.updateCategory(id:_categoryId, title: _categoryName, isShowThumbnail: isShowThumbnail, isShowPoint: isShowpoint);
    final isDefault = await isDefaultCategory(category);
    if (isDefault) {
      await setDefaultCategory(category);
    }
    notifyListeners();
  }

  setIsShowPoint(bool value) async {
    _isShowpoint = value;
    final category = await _categoryRepository.updateCategory(id:_categoryId, title: _categoryName, isShowThumbnail: isShowThumbnail, isShowPoint: isShowpoint);
    final isDefault = await isDefaultCategory(category);
    if (isDefault) {
      await setDefaultCategory(category);
    }
    notifyListeners();
  }

  setColor(String hexColor) async {
    _selectedHexColor = hexColor;
    notifyListeners();
    final category = await _categoryRepository.updateCategory(id:_categoryId, title: _categoryName, isShowThumbnail: isShowThumbnail, isShowPoint: isShowpoint, hexColor: _selectedHexColor);
    final isDefault = await isDefaultCategory(category);
    if (isDefault) {
      await setDefaultCategory(category);
    }
  }

  Future<void> updateCategoryName(int id) async {
    final category = await _categoryRepository.updateCategory(id:id, title: _categoryName, isShowThumbnail: isShowThumbnail, isShowPoint: isShowpoint);
    final isDefault = await isDefaultCategory(category);
    if (isDefault) {
      await setDefaultCategory(category);
    }
  }

  Future<bool> isDefaultCategory(Category category) async {
    Map<String, dynamic> userMap = await jsonDecode(_pref.getString(Keys.defaultCategpory)!);
    final data = Category.fromJson(userMap);
    return category.id == data.id;
  }

  setDefaultCategory(Category category) async {
    await _pref.setString(Keys.defaultCategpory, jsonEncode(category));
  }

  Future<void> delete(int id) async {
    await _categoryRepository.deleteCategory(id);
  }

}
