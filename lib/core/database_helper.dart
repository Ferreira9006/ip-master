// Importa a biblioteca sqflite para gestão de base de dados SQLite
import 'package:sqflite/sqflite.dart';

// Importa funções utilitárias para trabalhar com caminhos (ex: join de strings)
import 'package:path/path.dart';

/// Classe singleton que gere o acesso à base de dados SQLite local.
/// Responsável por criar, abrir, atualizar e fornecer acesso à BD.
class DatabaseHelper {
  // Instância única da classe (padrão Singleton)
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Objeto da base de dados (será inicializado uma vez)
  static Database? _database;

  // Construtor privado para impedir múltiplas instâncias da classe
  DatabaseHelper._privateConstructor();

  /// Getter para obter a base de dados.
  /// Se ainda não estiver criada, chama o método _initDatabase().
  Future<Database> get database async {
    _database ??= await _initDatabase(); // se for null, inicializa
    return _database!;
  }

  /// Inicializa a base de dados: define o caminho e abre/cria o ficheiro.
  Future<Database> _initDatabase() async {
    // Obtém o diretório onde o Android/iOS guarda as bases de dados locais
    final dbPath = await getDatabasesPath();

    // Define o caminho completo até ao ficheiro da base de dados
    final path = join(dbPath, 'ipmaster.db');

    // Abre a base de dados (ou cria-a se não existir)
    return await openDatabase(
      path,
      version: 2, // Versão da base de dados (importante para upgrades)
      onCreate: _onCreate, // Executado quando a BD é criada pela primeira vez
      onUpgrade: _onUpgrade, // Executado quando a versão aumenta
    );
  }

  /// Cria as tabelas quando a base de dados é criada pela primeira vez.
  Future _onCreate(Database db, int version) async {
    // Cria a tabela de utilizadores
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        display_name TEXT NOT NULL,
        total_score INTEGER DEFAULT 0
      )
    ''');

    // Cria a tabela de pontuações dos utilizadores
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

  /// Atualiza a base de dados quando a versão é incrementada.
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Exemplo: se o utilizador estiver a migrar da versão 1 para 2
    if (oldVersion < 2) {
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

    // Aqui podem ser adicionadas migrações futuras (ex: versão 3, 4, etc.)
  }
}
