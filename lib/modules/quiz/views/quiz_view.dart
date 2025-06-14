import 'package:flutter/material.dart';
import 'package:ip_master/modules/auth/models/user_model.dart';
import 'package:ip_master/modules/quiz/models/questions_model.dart';
import 'package:ip_master/modules/quiz/utils/quiz_question.dart';
import 'package:ip_master/modules/ranking/data/scores_database_helper.dart';

class QuizView extends StatefulWidget {
  final User user;
  final int level;
  const QuizView({super.key, required this.user, required this.level});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  late Question _current;
  bool _answered = false;
  int _sessionScore = 0;

  @override
  void initState() {
    super.initState();
    _loadNext();
  }

  // Carrega a próxima pergunta
  void _loadNext() {
    setState(() {
      _current = generateQuestion(widget.level);
      _answered = false;
    });
  }

  // Lógica de resposta do utilizador
  void _onSelect(String option) async {
    if (_answered) return;
    setState(() => _answered = true);

    final correct = option == _current.correctAnswer;
    int scoreDelta;

    // Pontuação consoante o nível
    switch (widget.level) {
      case 1:
        scoreDelta = correct ? 10 : -5;
        break;
      case 2:
        scoreDelta = correct ? 20 : -10;
        break;
      case 3:
        scoreDelta = correct ? 30 : -15;
        break;
      default:
        scoreDelta = 0;
    }

    // Atualiza o score da sessão atual
    _sessionScore += scoreDelta;

    // Guarda o resultado na base de dados
    await ScoresDatabaseHelper().insertScore(
      userId: widget.user.id!,
      difficulty: widget.level,
      score: scoreDelta,
    );

    // Mostra feedback ao jogador
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          correct
              ? '✔️ Correto! Ganhaste $scoreDelta pontos.'
              : '❌ Errado! Perdeste ${-scoreDelta} pontos.\nResposta certa: ${_current.correctAnswer}',
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    // Espera 2 segundos antes de carregar nova pergunta
    Future.delayed(const Duration(seconds: 2), _loadNext);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Nível ${widget.level}'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(child: Text('Score: $_sessionScore')),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Pergunta atual
            Text(_current.questionText, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 24),
            // Lista de opções
            ..._current.options.map(
              (opt) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _answered
                            ? (opt == _current.correctAnswer
                                ? const Color.fromARGB(
                                  255,
                                  43,
                                  146,
                                  46,
                                ) // verde
                                : const Color.fromARGB(
                                  255,
                                  156,
                                  50,
                                  42,
                                )) // vermelho
                            : null,
                  ),
                  onPressed: () => _onSelect(opt),
                  child: Text(opt),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
