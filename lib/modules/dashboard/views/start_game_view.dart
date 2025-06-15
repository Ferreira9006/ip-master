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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Jogar",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Aprenda redes de uma forma divertida.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),

              AppFullWidthButton(
                text: "Nível 1",
                onPressed: () => _startQuiz(gameLevelDifficultyOne),
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),

              SizedBox(height: 15),

              AppFullWidthButton(
                text: "Nível 2",
                onPressed: () => _startQuiz(gameLevelDifficultyTwo),
                backgroundColor: Colors.green,
                foregroundColor: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),

              SizedBox(height: 15),

              AppFullWidthButton(
                text: "Nível 3",
                onPressed: () => _startQuiz(gameLevelDifficultyThree),
                backgroundColor: Colors.orange,
                foregroundColor: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
