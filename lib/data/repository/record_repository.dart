
import 'dart:convert';
import 'dart:io';

import 'package:best_beer_ranking/data/model/category.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/data/model/result.dart';
import 'package:best_beer_ranking/data/local/record_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final recordRepositoryProvider = Provider((ref) => RecordRepositoryImpl(ref.read));

abstract class RecordRepository {
  Future<Result<void>> deleteRecord(int id);
  Future<Result<List<Record>>> getRecords(int categoryId);

  Future<List<Record>> getRankingRecords(int categoryId);
  Future<void> updateRanking(List<Record> records);
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
          ranking: rank);
    });
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
