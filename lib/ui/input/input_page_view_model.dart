import 'dart:io';

import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/data/provider/shared_preference_provider.dart';
import 'package:best_beer_ranking/data/repository/record_repository.dart';
import 'package:best_beer_ranking/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/local/record_database.dart';

final inputViewModelProvider =
    ChangeNotifierProvider((ref) => InputViewModel(ref.read));

class InputViewModel extends ChangeNotifier {
  InputViewModel(this._reader);
  final Reader _reader;

  late final _recordDatabaseProvider = _reader(recordDatabaseProvider);


  late final _sharedPreferencesManager = _reader(sharedPreferencesManagerProvider);

  late final _pref = _reader(prefsProvider);

  final imagePicker = ImagePicker();

  String get title => _title;
  String _title = "";
  String get memo => _memo;
  String _memo = "";

  File? _imageFile;
  File? get imageFile => _imageFile;

  void setTitle(String title) {
    _title = title;
  }

  void setMemo(String memo) {
    _memo = memo;
  }

  Future<Record?> save() async {
    final defaultCategory = await _sharedPreferencesManager.getCategory();
    if (defaultCategory == null) {
      return null;
    }
    final record = await _recordDatabaseProvider.insert(
        categoryId:  defaultCategory.id,
        title: title,
        memo: _memo,
        evaluation: _evaluation,
        sharp_point: _sharpPoint,
        acidity_point: _acidityPoint,
        bitter_point: _bitterPoint,
        sweet_point: _sweetPoint,
        rich_point: _richPoint,
        fragrance_point: _fragrancePoint,
        imageFile: _imageFile);
    clear();
    return record;
  }

  void clear() {
    _title = "";
    _memo = "";
    _evaluation = null;
    _sharpPoint = null;
    _acidityPoint = null;
    _bitterPoint = null;
    _sweetPoint = null;
    _richPoint = null;
    _fragrancePoint = null;
    _imageFile = null;
  }

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source, maxHeight: 500, maxWidth: 500);
    if (pickedFile == null) return;
    _imageFile = await ImageUtils.cropImage(pickedFile.path);
    notifyListeners();
  }

  double? get evaluation => _evaluation;
  double? _evaluation;
  Future<void> setEvaluation(double evaluation) async {
    _evaluation = evaluation;
    notifyListeners();
  }

  double? get sharpPoint => _sharpPoint;
  double? _sharpPoint;
  Future<void> setSharpPoint(double sharpPoint) async {
    _sharpPoint = sharpPoint;
    notifyListeners();
  }

  double? get acidityPoint => _acidityPoint;
  double? _acidityPoint;
  Future<void> setAcidityPoint(double acidityPoint) async {
    _acidityPoint = acidityPoint;
    notifyListeners();
  }

  double? get bitterPoint => _bitterPoint;
  double? _bitterPoint;
  Future<void> setBitterPoint(double bitterPoint) async {
    _bitterPoint = bitterPoint;
    notifyListeners();
  }

  double? get sweetPoint => _sweetPoint;
  double? _sweetPoint;
  Future<void> setSweetPoint(double sweetPoint) async {
    _sweetPoint = sweetPoint;
    notifyListeners();
  }

  double? get richPoint => _richPoint;
  double? _richPoint;
  Future<void> setRichPoint(double richPoint) async {
    _richPoint = richPoint;
    notifyListeners();
  }

  double? get fragrancePoint => _fragrancePoint;
  double? _fragrancePoint;
  Future<void> setFragrancePoint(double fragrancePoint) async {
    _fragrancePoint = fragrancePoint;
    notifyListeners();
  }
}
