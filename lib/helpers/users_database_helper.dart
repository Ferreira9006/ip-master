import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:IPMaster/models/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'ipmaster.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        display_name TEXT NOT NULL,
        total_score INTEGER DEFAULT 0
      )
    ''');
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> loginUser(String email, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }

  Future<List<User>> getRankTopFive() async {
    final db = await database;
    // Ordena por total_score desc e limita a 5
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      orderBy: 'total_score DESC',
      limit: 5,
    );

    // Converte cada Map num User e devolve a lista
    return maps.map((m) => User.fromMap(m)).toList();
  }

  Future<bool> emailExists(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  Future<bool> getScore(int userId) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'total_score = ?',
      whereArgs: [userId],
    );
    return result.isNotEmpty;
  }
}
