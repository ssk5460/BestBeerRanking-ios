import 'package:best_beer_ranking/data/model/category.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/data/local/app_database.dart';
import 'package:sqflite/sqflite.dart';


final categoryDatabaseProvider = Provider((ref) => CategoryDatabaseImpl());

abstract class CategoryDatabase {
  Future<List<Category>> getCategories();
  Future<Category> insert(String title, bool isShowThumbnail, bool isShowPoint);
  Future<Category> update(int id, String? title, String? hexColor, bool? isShowThumbnail, bool? isShowPoint);
  Future delete(int id);
}

class CategoryDatabaseImpl extends AppDatabase implements CategoryDatabase {
  final String _tableName = 'categories';

  @override
  Future<List<Category>> getCategories() async {
    final db = await database;
    final maps = await db.query(
      _tableName,
      orderBy: 'id DESC',
    );
    if (maps.isEmpty) return [];
    return maps.map((map) => Category.fromJson(map)).toList();
  }
  @override
  Future<Category> insert(String title, bool isShowThumbnail, bool isShowPoint) async {
    final db = await database;
    var data = <String, dynamic>{};
    data["title"] = title;
    data["hexColor"] = "";
    data["recordedAt"] = DateTime.now().millisecondsSinceEpoch;
    data["isShowThumbnail"] = isShowThumbnail ? 1 : 0;
    data["isShowPoint"] = isShowPoint ? 1 : 0;
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
    final categories = maps.map((map) => Category.fromJson(map)).toList();
    return categories.first;
  }

  @override
  Future<Category> update(int id, String? title, String? hexColor, bool? isShowThumbnail, bool? isShowPoint) async {
    final db = await database;
    var data = <String, dynamic>{};
    data["title"] = title;

    if (hexColor != null) {
      data["hexColor"] = hexColor;
    }
    if (isShowThumbnail != null) {
      data["isShowThumbnail"] = isShowThumbnail ? 1 : 0;
    }
    if (isShowPoint != null) {
      data["isShowPoint"] = isShowPoint ? 1 : 0;
    }
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
    final categories = maps.map((map) => Category.fromJson(map)).toList();
    return categories.first;
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
}