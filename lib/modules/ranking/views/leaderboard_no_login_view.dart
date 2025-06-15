import 'package:ip_master/core/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:ip_master/modules/ranking/data/scores_database_helper.dart';
import 'package:ip_master/modules/ranking/models/user_score_model.dart';
import 'package:ip_master/modules/auth/views/login_view.dart';

class LeaderboardNoLoginView extends StatefulWidget {
  const LeaderboardNoLoginView({super.key});

  @override
  State<LeaderboardNoLoginView> createState() => _LeaderboardNoLoginViewState();
}

class _LeaderboardNoLoginViewState extends State<LeaderboardNoLoginView> {
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
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Leaderboard",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.leaderboard, size: 48, color: Colors.blue),
              const SizedBox(height: 30),
              _buildRankCard('🥇 Nível 1 (Básico)', rank1, Colors.amber.shade100),
              _buildRankCard('🥈 Nível 2 (Sub-redes)', rank2, Colors.green.shade100),
              _buildRankCard('🥉 Nível 3 (Super-redes)', rank3, Colors.orange.shade100),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                },
                child: const Text("Voltar", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRankCard(String title, List<UserScore> list, Color bgColor) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Card(
        elevation: 4,
        color: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
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
                Column(
                  children: list.asMap().entries.map((entry) {
                    final i = entry.key;
                    final us = entry.value;
                    final medal = i == 0
                        ? '🥇'
                        : i == 1
                            ? '🥈'
                            : i == 2
                                ? '🥉'
                                : '🎖️';
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$medal ${i + 1}. ${us.displayName}'),
                          Text('${us.score} pts'),
                        ],
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
