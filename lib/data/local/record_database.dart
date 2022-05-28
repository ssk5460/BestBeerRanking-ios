import 'package:best_beer_ranking/data/model/category.dart';
import 'package:best_beer_ranking/data/model/ranking.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/data/local/app_database.dart';
import 'package:sqflite/sqflite.dart';


final recordDatabaseProvider = Provider((ref) => RecordDatabaseImpl());

abstract class RecordDatabase {
  Future<List<Record>> getRecords(int categoryId);
  Future<Record> insert(String title, String? memo, int? point, int? ranking, String? imageBase64String, DateTime recordedAt, int categoryId);
  Future<Record> update({required int id, String? title, String? memo, int? point, int? ranking, String? imageBase64String});
  Future delete(int id);
  Future<void> sync(Ranking ranking);
}

class RecordDatabaseImpl extends AppDatabase implements RecordDatabase {
  final String _tableName = 'records';

  @override
  Future<List<Record>> getRecords(int categoryId) async {
    final db = await database;
    final maps = await db.query(
      _tableName,
      where: 'categoryId = ?',
      whereArgs: [categoryId],
      orderBy: 'id DESC',
    );
    if (maps.isEmpty) return [];
    return maps.map((map) => Record.fromJson(map)).toList();
  }

  @override
  Future<Record> insert(String title, String? memo, int? point, int? ranking, String? imageBase64String, DateTime recordedAt, int categoryId) async {
    final db = await database;

    var data = <String, dynamic>{};
    data["id"] = DateTime.now().millisecondsSinceEpoch;
    data["title"] = title;
    data["memo"] = memo;
    data["imageBase64String"] = imageBase64String;
    data["point"] = point;
    data["ranking"] = ranking;
    data["recordedAt"] = recordedAt.millisecondsSinceEpoch;
    data["categoryId"] = categoryId;
    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    final records = maps.map((map) => Record.fromJson(map)).toList();
    return records.first;
  }


  @override
  Future<Record> update({required int id, String? title, String? memo, int? point, int? ranking, String? imageBase64String}) async {
    final db = await database;
    var data = <String, dynamic>{};
    if (title != null) {
      data["title"] = title;
    }
    if (memo != null) {
      data["memo"] = memo;
    }
    if (point != null) {
      data["point"] = point;
    }
    if (imageBase64String != null) {
      data["imageBase64String"] = imageBase64String;
    }
    data["ranking"] = ranking;
    await db.update(
      _tableName,
      data,
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    final records = maps.map((map) => Record.fromJson(map)).toList();
    return records.first;
  }

  @override
  Future delete(int id) async {
    final db = await database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> sync(Ranking ranking) async {
    final db = await database;
    ranking.records.forEach((element) async {
      final maps = await db.query(
        _tableName,
        where: 'id = ?',
        whereArgs: [element.id],
      );
      if (maps.isEmpty) {
        final id = await db.insert(
          _tableName,
          element.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        print(id);
      }
    });
  }
}