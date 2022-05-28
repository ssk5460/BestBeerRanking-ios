
import 'dart:convert';
import 'dart:io';

import 'package:best_beer_ranking/data/model/category.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/data/model/result.dart';
import 'package:best_beer_ranking/data/local/record_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final recordRepositoryProvider = Provider((ref) => RecordRepositoryImpl(ref.read));

abstract class RecordRepository {
  Future<Record> postRecord(String title, String? memo, int? point, int? ranking, File? imageFile, DateTime recordedAt, Category category);
  Future<Result<Record>> updateRecord(int id, String? title, String? memo, int? point, int? ranking, File? imageFile);
  Future<Result<void>> deleteRecord(int id);
  Future<Result<List<Record>>> getRecords(int categoryId);

  Future<List<Record>> getRankingRecords(int categoryId);
  Future<void> updateRanking(List<Record> records);
  Future<void> updateRankingWithPoint(List<Record> records);
  Future<Record> removeRanking(Record record);
}

class RecordRepositoryImpl implements RecordRepository {
  RecordRepositoryImpl(this._reader);

  final Reader _reader;

  late final RecordDatabase _recordDatabase = _reader(recordDatabaseProvider);

  @override
  Future<void> updateRanking(List<Record> records) async {
    records.asMap().forEach((ranking, record) {
      final rank = ranking + 1;
      _recordDatabase.update(
          id:record.id,
          title:record.title,
          memo:record.memo,
          point: record.point,
          ranking: rank);
    });
  }

  @override
  Future<void> updateRankingWithPoint(List<Record> records) async {
    records.sort((a,b) => (b.point ?? 0).compareTo(a.point ?? 0));
    records.asMap().forEach((index, record) {
      final rank = index + 1;
      _recordDatabase.update(
          id:record.id,
          title:record.title,
          memo:record.memo,
          point: record.point,
          ranking: rank);
    });
  }

  @override
  Future<Record> postRecord(String title, String? memo, int? point, int? ranking, File? imageFile, DateTime recordedAt, Category category) async {
    String? base64Image = null;
    if (imageFile != null) {
      List<int> imageBytes = imageFile.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
    }
    return await _recordDatabase.insert(title, memo, point, ranking, base64Image, DateTime.now(), category.id);
  }

  @override
  Future<Result<Record>> updateRecord(int id, String? title, String? memo, int? point, int? ranking, File? imageFile) {
    String? base64Image = null;
    if (imageFile != null) {
      List<int> imageBytes = imageFile.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
    }
    return Result.guardFuture(() async => await _recordDatabase.update(id:id, title:title, memo:memo, point:point, ranking:ranking, imageBase64String: base64Image));
  }

  @override
  Future<Result<void>> deleteRecord(int id) {
    return Result.guardFuture(() async => await _recordDatabase.delete(id));
  }

  @override
  Future<Result<List<Record>>> getRecords(int categoryId) {
    return Result.guardFuture(() async => await _recordDatabase.getRecords(categoryId));
  }

  @override
  Future<List<Record>> getRankingRecords(int categoryId) async {
    final records = await _recordDatabase.getRecords(categoryId);
    var filteredData = records
        .where((value) => value.ranking != null)
        .toList();
    filteredData.sort((a,b) => (a.ranking!).compareTo((b.ranking!)));
    return filteredData;
  }

  @override
  Future<Record> removeRanking(Record record) async {
    final updatedRecord = await _recordDatabase.update(id: record.id, ranking: null);
    final ranking = await getRankingRecords(record.categoryId ?? 0);
    await updateRanking(ranking);
    return updatedRecord;
  }
}
