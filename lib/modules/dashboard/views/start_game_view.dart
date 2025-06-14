import 'package:IPMaster/core/app_constants.dart';
import 'package:IPMaster/core/widgets/app_fullwidth_button.dart';
import 'package:IPMaster/core/widgets/app_regular_button.dart';
import 'package:IPMaster/modules/quiz/views/quiz_view.dart';
import 'package:flutter/material.dart';
import 'package:IPMaster/modules/auth/models/user_model.dart';

class StartGameView extends StatefulWidget {
  final User user;
  const StartGameView({Key? key, required this.user}) : super(key: key);

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 100),
            Text(
              "Jogar",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text("Aprenda redes de uma forma divertida."),
            SizedBox(height: 50),
            AppFullWidthButton(
              text: "Nível 1",
              icon: Icons.looks_one,
              onPressed: () => _startQuiz(gameLevelDifficultyOne),
            ),
            SizedBox(height: 10),
            AppFullWidthButton(
              text: "Nível 2",
              icon: Icons.looks_two,
              onPressed: () => _startQuiz(gameLevelDifficultyTwo),
            ),
            SizedBox(height: 10),
            AppFullWidthButton(
              text: "Nível 3",
              icon: Icons.looks_3,
              onPressed: () => _startQuiz(gameLevelDifficultyThree),
            ),
          ],
        ),
      ),
    );
  }
}
