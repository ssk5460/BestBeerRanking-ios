import 'dart:convert';
import 'dart:io';

import 'package:best_beer_ranking/data/foundation/keys.dart';
import 'package:best_beer_ranking/data/model/category.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/data/provider/shared_preference_provider.dart';
import 'package:best_beer_ranking/data/repository/category_repository.dart';
import 'package:best_beer_ranking/data/repository/record_repository.dart';
import 'package:best_beer_ranking/ui/dialog_util.dart';
import 'package:best_beer_ranking/utils/image_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

final recordDetailViewModelProvider =
    ChangeNotifierProvider((ref) => RecordDetailViewModel(ref.read));

class RecordDetailViewModel extends ChangeNotifier {

  RecordDetailViewModel(this._reader);

  final Reader _reader;
  Record get record => _record;
  var _record;
  File? get imageFile => _imageFile;
  File? _imageFile;

  String? get title => _title;
  String? _title;
  String? get memo => _memo;
  String? _memo;
  int? get point => _point;
  int? _point;

  late final _recordRepository = _reader(recordRepositoryProvider);
  final imagePicker = ImagePicker();

  void setRecord(Record record) {
    this._record = record;
    this._title = record.title;
    this._memo = record.memo;
    this._point = record.point;
    notifyListeners();
  }

  void setTitle(String? title) {
    _title = title;
  }

  void setMemo(String? memo) {
    _memo = memo;
  }

  void setPoint(int? point) {
    _point = point;
    notifyListeners();
  }

  Future<void> update() async {
    if (_title?.isEmpty == true) {
      return;
    }
    final result = await _recordRepository.updateRecord(
        record.id,
        _title,
        _memo,
        _point,
        record.ranking,
        _imageFile);
    await result.when(success: (data) async {
      _record = data;
      notifyListeners();
    }, failure: (e) {
    });
  }

  Future<void> delete(Record record) async {
    await _recordRepository.deleteRecord(record.id);
  }

  Future<void> removeRanking(Record record) async {
    _record = await _recordRepository.removeRanking(record);
    notifyListeners();
  }

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile == null) return;
    _imageFile = await ImageUtils.cropImage(pickedFile.path);
    notifyListeners();
  }
}

