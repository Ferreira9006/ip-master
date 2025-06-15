import 'package:flutter/material.dart';
import 'package:ip_master/core/app_constants.dart';
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
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text("Leaderboard"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: SingleChildScrollView(
          key: ValueKey(isLoading),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(Icons.emoji_events_sharp, size: 30),
                  SizedBox(width: 10),
                  Text("Raking dos Jogadores ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 16),
              _buildRankCard('Nível 1 - Básico (/8, /16, /24)', rank1),
              _buildRankCard('Nível 2 - Sub-redes', rank2),
              _buildRankCard('Nível 3 - Super-redes', rank3),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRankCard(String title, List<UserScore> list) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              if (list.isEmpty)
                const Text(
                  'Nenhum resultado disponível.',
                  style: TextStyle(color: Colors.grey),
                )
              else
                ...list.asMap().entries.map((entry) {
                  final i = entry.key;
                  final us = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${i + 1}. ${us.displayName}',
                            style: const TextStyle(fontSize: 16)),
                        Text('${us.score} pts',
                            style: const TextStyle(fontSize: 16)),
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
