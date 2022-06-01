import 'dart:convert';
import 'dart:io';

import 'package:best_beer_ranking/data/model/category.dart';
import 'package:best_beer_ranking/data/model/ranking.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/data/local/app_database.dart';
import 'package:sqflite/sqflite.dart';


final recordDatabaseProvider = Provider((ref) => RecordDatabaseImpl());

abstract class RecordDatabase {
  Future<List<Record>> getRecords(int categoryId);
  Future<Record> insert({
    required int categoryId,
    required String title,
    String? memo,
    int? ranking,
    double? evaluation,
    double? sharp_point,
    double? acidity_point,
    double? bitter_point,
    double? sweet_point,
    double? rich_point,
    double? fragrance_point,
    File? imageFile});

  Future<Record> update({
    required int id,
    String? title,
    String? memo,
    int? ranking,
    double? evaluation,
    double? sharp_point,
    double? acidity_point,
    double? bitter_point,
    double? sweet_point,
    double? rich_point,
    double? fragrance_point,
    File? imageFile});

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
  Future<Record> insert({required int categoryId, required String title, String? memo, int? ranking, double? evaluation, double? sharp_point, double? acidity_point, double? bitter_point, double? sweet_point, double? rich_point, double? fragrance_point, File? imageFile}) async {
    final db = await database;
    var data = <String, dynamic>{};
    data["id"] = DateTime.now().millisecondsSinceEpoch;
    data["title"] = title;
    data["memo"] = memo;
    data["evaluation"] = evaluation;
    data["sharp_point"] = sharp_point;
    data["acidity_point"] = acidity_point;
    data["bitter_point"] = bitter_point;
    data["sweet_point"] = sweet_point;
    data["rich_point"] = rich_point;
    data["fragrance_point"] = fragrance_point;
    String? base64Image = null;
    if (imageFile != null) {
      List<int> imageBytes = imageFile.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
    }
    data["imageBase64String"] = base64Image;
    data["recordedAt"] = DateTime.now().millisecondsSinceEpoch;
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
  Future<Record> update({required int id, String? title, String? memo, int? ranking, double? evaluation, double? sharp_point, double? acidity_point, double? bitter_point, double? sweet_point, double? rich_point, double? fragrance_point, File? imageFile}) async {
    final db = await database;
    var data = <String, dynamic>{};
    if (title != null) {
      data["title"] = title;
    }
    if (memo != null) {
      data["memo"] = memo;
    }
    if (evaluation != null) {
      data["evaluation"] = evaluation;
    }
    if (sharp_point != null) {
      data["sharp_point"] = sharp_point;
    }
    if (acidity_point != null) {
      data["acidity_point"] = acidity_point;
    }
    if (bitter_point != null) {
      data["bitter_point"] = bitter_point;
    }
    if (sweet_point != null) {
      data["sweet_point"] = sweet_point;
    }
    if (rich_point != null) {
      data["rich_point"] = rich_point;
    }
    if (fragrance_point != null) {
      data["fragrance_point"] = fragrance_point;
    }
    if (imageFile != null) {
      List<int> imageBytes = imageFile.readAsBytesSync();
      data["imageBase64String"] = base64Encode(imageBytes);
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