import 'package:ip_master/core/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:ip_master/modules/ranking/data/scores_database_helper.dart';
import 'package:ip_master/modules/ranking/models/user_score_model.dart';

class LeaderboardView extends StatefulWidget {
  const LeaderboardView({super.key});

  @override
  State<LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  List<UserScore> rank1 = [];
  List<UserScore> rank2 = [];
  List<UserScore> rank3 = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRankings();
  }

  Future<void> _loadRankings() async {
    final helper = ScoresDatabaseHelper();
    final results = await Future.wait([
      helper.getTopFiveByDifficulty(gameLevelDifficultyOne),
      helper.getTopFiveByDifficulty(gameLevelDifficultyTwo),
      helper.getTopFiveByDifficulty(gameLevelDifficultyThree),
    ]);

    setState(() {
      rank1 = results[0];
      rank2 = results[1];
      rank3 = results[2];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 100),
            Text(
              "Leaderboard",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            _buildRankCard('Nível 1 (Básico)', rank1),
            _buildRankCard('Nível 2 (Sub-redes)', rank2),
            _buildRankCard('Nível 3 (Super-redes)', rank3),
          ],
        ),
      ),
    );
  }

  Widget _buildRankCard(String title, List<UserScore> list) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          constraints: const BoxConstraints(minHeight: 100),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              if (list.isEmpty)
                const Text('Nenhum resultado disponível.')
              else
                // Os "..." expande uma lista de widgets dentro de outra lista
                ...list.asMap().entries.map((entry) {
                  final i = entry.key;
                  final us = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${i + 1}. ${us.displayName}'),
                        Text('${us.score} pts'),
                      ],
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}
