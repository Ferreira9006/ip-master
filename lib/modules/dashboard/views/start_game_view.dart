import 'package:flutter/material.dart';
import 'package:ip_master/core/app_constants.dart';
import 'package:ip_master/core/widgets/app_fullwidth_button.dart';
import 'package:ip_master/modules/quiz/views/quiz_view.dart';
import 'package:ip_master/modules/auth/models/user_model.dart';

class StartGameView extends StatefulWidget {
  final User user;
  const StartGameView({super.key, required this.user});

  @override
  State<StartGameView> createState() => _StartGameViewState();
}

class _StartGameViewState extends State<StartGameView> {
  void _startQuiz(int level) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizView(user: widget.user, level: level),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Jogar",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Aprenda redes de uma forma divertida.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              _buildLevelButton("Nível 1", gameLevelDifficultyOne, Colors.amber),
              const SizedBox(height: 16),
              _buildLevelButton("Nível 2", gameLevelDifficultyTwo, Colors.green),
              const SizedBox(height: 16),
              _buildLevelButton("Nível 3", gameLevelDifficultyThree, Colors.orange),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelButton(String label, int level, Color color) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: () => _startQuiz(level),
        child: Text(label),
      ),
    );
  }
}
