import 'dart:convert';
import 'dart:io';

import 'package:best_beer_ranking/data/foundation/keys.dart';
import 'package:best_beer_ranking/data/model/category.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/data/provider/shared_preference_provider.dart';
import 'package:best_beer_ranking/data/repository/ranking_repository.dart';
import 'package:best_beer_ranking/data/repository/record_repository.dart';
import 'package:best_beer_ranking/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final inputViewModelProvider =
    ChangeNotifierProvider((ref) => InputViewModel(ref.read));

class InputViewModel extends ChangeNotifier {
  InputViewModel(this._reader);
  final Reader _reader;
  late final _recordRepository = _reader(recordRepositoryProvider);
  late final _sharedPreferencesManager = _reader(sharedPreferencesManagerProvider);

  late final _pref = _reader(prefsProvider);

  final imagePicker = ImagePicker();

  String get title => _title;
  String _title = "";
  String get memo => _memo;
  String _memo = "";
  int? get point => _point;
  int? _point;

  File? _imageFile;
  File? get imageFile => _imageFile;

  void setTitle(String title) {
    _title = title;
  }

  void setMemo(String memo) {
    _memo = memo;
  }

  void setPoint(int? point) {
    _point = point;
    notifyListeners();
  }

  Future<Record?> save() async {
    final defaultCategory = await _sharedPreferencesManager.getCategory();
    if (defaultCategory == null) {
      return null;
    }
    final record = await _recordRepository.postRecord(
        _title,
        _memo,
        _point,
        null,
        imageFile,
        DateTime.now(),
        defaultCategory);
    clear();
    return record;
  }

  void clear() {
    _title = "";
    _memo = "";
    _point = null;
    _imageFile = null;
  }


  Future<void> getImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source, maxHeight: 500, maxWidth: 500);
    if (pickedFile == null) return;
    _imageFile = await ImageUtils.cropImage(pickedFile.path);
    notifyListeners();
  }
}
