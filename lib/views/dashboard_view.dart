import 'package:flutter/material.dart';
import 'package:IPMaster/modules/auth/models/user_model.dart';
import 'package:IPMaster/modules/auth/views/login_view.dart';
import 'package:IPMaster/modules/ranking/views/top5rank_view.dart';
import 'package:IPMaster/modules/quiz/views/quiz_view.dart';

class DashboardView extends StatefulWidget {
  final User user;

  const DashboardView({Key? key, required this.user}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  void _startQuiz(int level) {
    /*Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizView(user: widget.user, level: level),
      ),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginView()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Table(
              border: TableBorder.all(color: Colors.grey),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
              },
              children: [
                _buildRow("Nome", widget.user.displayName),
                _buildRow("E-mail", widget.user.email),
                _buildRow("Pontuação", widget.user.totalScore.toString()),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CombinedTop5RankView(user: widget.user),
                  ),
                );
              },
              child: const Text("Ver Ranking Top 5 por Nível"),
            ),
            // dentro de DashboardView, abaixo da tabela
            const SizedBox(height: 24),
            Text(
              'Escolhe o nível de dificuldade:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _startQuiz(1),
                  child: const Text('Nível 1'),
                ),
                ElevatedButton(
                  onPressed: () => _startQuiz(2),
                  child: const Text('Nível 2'),
                ),
                ElevatedButton(
                  onPressed: () => _startQuiz(3),
                  child: const Text('Nível 3'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(padding: const EdgeInsets.all(8.0), child: Text(value)),
      ],
    );
  }
}
