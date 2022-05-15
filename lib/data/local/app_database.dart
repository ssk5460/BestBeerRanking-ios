import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  late Database _database;

  Future<Database> get database async {
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'best_beer_ranking_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTable,
    );
  }

  Future<void> _createTable(Database db, int version) async {
    const String sql = 'CREATE TABLE records ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'title TEXT, '
        'memo TEXT, '
        'image TEXT, '
        'point INTEGER, '
        'ranking INTEGER, '
        'recordedAt INTEGER, '
        'categoryId INTEGER)';
    await db.execute(sql);

    const String categoriesSql = 'CREATE TABLE categories ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'title TEXT, '
        'hexColor TEXT, '
        'isShowThumbnail INTEGER, '
        'isShowPoint INTEGER, '
        'recordedAt INTEGER)';
    await db.execute(categoriesSql);
  }
}