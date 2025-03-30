import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'todo.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();

  static Database? _database;

  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        task TEXT,
        isCompleted INTEGER
      )
    ''');
  }

  // Create a new Todo
  Future<int> create(Todo todo) async {
    final db = await database;
    return await db.insert('todos', todo.toJson());
  }

  // Get all Todos
  Future<List<Todo>> getTodos() async {
    final db = await database;
    final maps = await db.query('todos');
    return maps.map((map) => Todo.fromJson(map)).toList();
  }

  // Update a Todo
  Future<int> update(Todo todo) async {
    final db = await database;
    return await db.update(
      'todos',
      todo.toJson(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  // Delete a Todo
  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
