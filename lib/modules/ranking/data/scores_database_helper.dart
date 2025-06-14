import 'package:IPMaster/core/database_helper.dart';
import 'package:IPMaster/modules/ranking/models/user_score_model.dart';

class ScoresDatabaseHelper {
  final _dbHelper = DatabaseHelper.instance;

  /// 1) Insere um novo resultado de jogo na tabela `scores`
  Future<int> insertScore({
    required int userId,
    required int difficulty,
    required int score,
  }) async {
    final db = await _dbHelper.database;
    return await db.insert('scores', {
      'user_id': userId,
      'difficulty': difficulty,
      'score': score,
    });
  }

  /// 2) Busca o top-5 de um determinado nível (difficulty)
  Future<List<UserScore>> getTopFiveByDifficulty(int difficulty) async {
    final db = await DatabaseHelper.instance.database;

    // Agrupa por user_id, soma os scores, ordena e limita a 5
    final rows = await db.rawQuery(
      '''
    SELECT 
      u.display_name, 
      u.email, 
      SUM(s.score) AS total_score
    FROM scores s
    JOIN users u ON u.id = s.user_id
    WHERE s.difficulty = ?
    GROUP BY s.user_id
    ORDER BY total_score DESC
    LIMIT 5
  ''',
      [difficulty],
    );

    return rows
        .map(
          (r) => UserScore(
            displayName: r['display_name'] as String,
            email: r['email'] as String,
            score: r['total_score'] as int,
          ),
        )
        .toList();
  }

  Future<int> getUserScoreByDifficulty(int difficulty, int userId) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.rawQuery(
      '''
    SELECT SUM(score) as total_score
    FROM scores
    WHERE difficulty = ? AND user_id = ?
    ''',
      [difficulty, userId],
    );

    final row = result.first;

    // Se não houver score ainda, retorna 0
    return row['total_score'] != null ? row['total_score'] as int : 0;
  }
}
