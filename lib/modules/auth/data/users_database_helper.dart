import 'package:ip_master/core/database_helper.dart';
import 'package:ip_master/modules/auth/models/user_model.dart';

class UsersDatabaseHelper {
  final _dbHelper = DatabaseHelper.instance;

  Future<int> insertUser(User user) async {
    final db = await _dbHelper.database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> loginUser(String email, String password) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }

  Future<List<User>> getRankTopFive() async {
    final db = await _dbHelper.database;
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
    final db = await _dbHelper.database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }
}
