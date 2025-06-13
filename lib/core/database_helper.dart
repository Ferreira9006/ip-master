import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

    return await openDatabase(
      path,
      version: 2, // versão nova
      onCreate: _onCreate, // só chamado uma vez
      onUpgrade: _onUpgrade, // chamado quando version aumenta
    );
  }

  Future _onCreate(Database db, int version) async {
    // cria ambas as tabelas de uma vez
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        display_name TEXT NOT NULL,
        total_score INTEGER DEFAULT 0
      )
    ''');
    await db.execute('''
      CREATE TABLE scores (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        difficulty INTEGER NOT NULL CHECK (difficulty IN (1,2,3)),
        score INTEGER NOT NULL,
        played_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY(user_id) REFERENCES users(id)
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // adiciona a tabela scores para quem estava na versão 1
      await db.execute('''
        CREATE TABLE scores (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER NOT NULL,
          difficulty INTEGER NOT NULL CHECK (difficulty IN (1,2,3)),
          score INTEGER NOT NULL,
          played_at DATETIME DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY(user_id) REFERENCES users(id)
        )
      ''');
    }
    // se no futuro bumps para versão 3, acrescenta mais migrações aqui
  }
}
