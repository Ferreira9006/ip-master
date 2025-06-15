import 'package:ip_master/core/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:ip_master/modules/auth/models/user_model.dart';
import 'package:ip_master/modules/ranking/data/scores_database_helper.dart';

class UserInfoPanel extends StatefulWidget {
  final User user;

  const UserInfoPanel({super.key, required this.user});

  @override
  State<UserInfoPanel> createState() => _UserInfoPanelState();
}

class _UserInfoPanelState extends State<UserInfoPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 60),
            Text(
              "Olá, ${widget.user.displayName}!",
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const Text("Bem vindo de volta.", style: TextStyle(fontSize: 16)),

            const SizedBox(height: 40),

            const Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(Icons.person_pin, size: 30),
                  SizedBox(width: 10),
                  Text("Dados Pessoais", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Nome"),
                    subtitle: Text(widget.user.displayName),
                    trailing: const Icon(Icons.edit),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text("E-mail"),
                    subtitle: Text(widget.user.email),
                    trailing: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: const [
                  Icon(Icons.analytics_outlined, size: 30),
                  SizedBox(width: 10),
                  Text(
                    "Minhas Pontuações",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildScoreRow("🥇 Nível 1", gameLevelDifficultyOne),
                    const Divider(),
                    _buildScoreRow("🥈 Nível 2", gameLevelDifficultyTwo),
                    const Divider(),
                    _buildScoreRow("🥉 Nível 3", gameLevelDifficultyThree),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreRow(String label, int difficulty) {
    return FutureBuilder<int>(
      future: ScoresDatabaseHelper().getUserScoreByDifficulty(difficulty, widget.user.id!),
      builder: (context, snapshot) {
        final score = snapshot.data ?? 0;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("$score pontos"),
          ],
        );
      },
    );
  }
}
