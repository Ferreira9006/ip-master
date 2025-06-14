import 'package:flutter/material.dart';
import 'package:IPMaster/modules/ranking/data/scores_database_helper.dart';
import 'package:IPMaster/modules/ranking/models/user_score_model.dart';
import 'package:IPMaster/modules/auth/models/user_model.dart';
import 'package:IPMaster/modules/dashboard/views/dashboard_view.dart';

class CombinedTop5RankView extends StatelessWidget {
  final User user;
  const CombinedTop5RankView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final helper = ScoresDatabaseHelper();

    // Para carregar os três rankings ao mesmo tempo
    final futureRanks = Future.wait<List<UserScore>>([
      helper.getTopFiveByDifficulty(1),
      helper.getTopFiveByDifficulty(2),
      helper.getTopFiveByDifficulty(3),
    ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top 5 por Nível'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => DashboardView(user: user)),
            );
          },
        ),
      ),
      body: FutureBuilder<List<List<UserScore>>>(
        future: futureRanks,
        builder: (ctx, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snap.hasData) {
            return const Center(child: Text('Não há dados de ranking.'));
          }
          final List<UserScore> rank1 = snap.data![0];
          final List<UserScore> rank2 = snap.data![1];
          final List<UserScore> rank3 = snap.data![2];

          Widget buildSection(String title, List<UserScore> list) {
            if (list.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('$title\n  Nenhum resultado.'),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                ...List.generate(list.length, (i) {
                  final us = list[i];
                  return ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Text('${i + 1}.'),
                    title: Text(us.displayName),
                    subtitle: Text(us.email),
                    trailing: Text(us.score.toString()),
                  );
                }),
                const Divider(),
              ],
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildSection('Nível 1 (Básico)', rank1),
                buildSection('Nível 2 (Sub-redes)', rank2),
                buildSection('Nível 3 (Super-redes)', rank3),
              ],
            ),
          );
        },
      ),
    );
  }
}
