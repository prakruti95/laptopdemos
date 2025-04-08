import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), "category.db");
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE category(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          imagePath TEXT,
          isSynced INTEGER
        )
      ''');
    });
  }

  Future<void> insertCategory(String name, String imagePath, {bool isSynced = false}) async {
    final dbClient = await db;
    await dbClient.insert("category", {
      "name": name,
      "imagePath": imagePath,
      "isSynced": isSynced ? 1 : 0,
    });
  }

  Future<List<Map<String, dynamic>>> getUnsyncedData() async {
    final dbClient = await db;
    return await dbClient.query("category", where: "isSynced = ?", whereArgs: [0]);
  }

  Future<void> markAsSynced(int id) async {
    final dbClient = await db;
    await dbClient.update("category", {"isSynced": 1}, where: "id = ?", whereArgs: [id]);
  }
}
