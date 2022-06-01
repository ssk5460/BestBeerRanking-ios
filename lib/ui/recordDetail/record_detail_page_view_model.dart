import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:best_beer_ranking/data/local/record_database.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/data/provider/shared_preference_provider.dart';
import 'package:best_beer_ranking/data/repository/ranking_repository.dart';
import 'package:best_beer_ranking/data/repository/record_repository.dart';
import 'package:best_beer_ranking/data/repository/user_repository.dart';
import 'package:best_beer_ranking/utils/image_utils.dart';
import 'package:best_beer_ranking/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
  Image? get image => _image;
  Image? _image;

  String? get title => _title;
  String? _title;
  String? get memo => _memo;
  String? _memo;

  late final _userRepository = _reader(userRepositoryProvider);
  late final _recordRepository = _reader(recordRepositoryProvider);
  late final _rankingRepository = _reader(rankingRepositoryProvider);
  late final _sharedPreferencesManager = _reader(sharedPreferencesManagerProvider);

  late final _recordDatabase = _reader(recordDatabaseProvider);

  final imagePicker = ImagePicker();

  void setRecord(Record record) {
    this._record = record;
    this._title = record.title;
    this._memo = record.memo;
    this._evaluation = record.evaluation;
    this._sharpPoint = record.sharp_point;
    this._acidityPoint = record.acidity_point;
    this._bitterPoint = record.bitter_point;
    this._sweetPoint = record.sweet_point;
    this._richPoint = record.rich_point;
    this._fragrancePoint = record.fragrance_point;
    this._image = Utils.imageFromBase64String(record.imageBase64String);
    notifyListeners();
  }

  void setTitle(String? title) {
    _title = title;
  }

  void setMemo(String? memo) {
    _memo = memo;
  }

  Future<void> update() async {
    if (_title?.isEmpty == true) {
      return;
    }
    await _recordDatabase.update(
        id: record.id,
        title: _title,
        memo: _memo,
        ranking: record.ranking,
        evaluation: _evaluation,
        sharp_point: _sharpPoint,
        acidity_point: _acidityPoint,
        bitter_point: _bitterPoint,
        sweet_point: _sweetPoint,
        rich_point: _richPoint,
        fragrance_point: _fragrancePoint,
        imageFile: _imageFile);
  }

  updateRanking() async {
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

