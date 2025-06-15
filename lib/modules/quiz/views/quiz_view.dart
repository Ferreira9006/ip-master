import 'package:flutter/material.dart';
import 'package:ip_master/modules/auth/models/user_model.dart';
import 'package:ip_master/modules/quiz/models/questions_model.dart';
import 'package:ip_master/modules/quiz/utils/quiz_question.dart';
import 'package:ip_master/modules/ranking/data/scores_database_helper.dart';

/// Ecrã principal do jogo de perguntas.
/// Apresenta uma pergunta de acordo com o nível e atualiza a pontuação do jogador.
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
  int _questionCount = 0;
  final int _maxQuestions = 5;

  @override
  void initState() {
    super.initState();
    _loadNext();
  }

  void _loadNext() {
    if (_questionCount >= _maxQuestions) {
      _showSummary();
      return;
    }

    setState(() {
      _current = generateQuestion(widget.level);
      _answered = false;
      _questionCount++;
    });
  }

  void _showSummary() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => AlertDialog(
            title: const Text('Quiz Finalizado!'),
            content: Text('Pontuação final: $_sessionScore pontos'),
            actions: [
              TextButton(
                onPressed:
                    () => Navigator.of(
                      context,
                    ).popUntil((route) => route.isFirst),
                child: const Text('Voltar'),
              ),
            ],
          ),
    );
  }

  void _onSelect(String option) async {
    if (_answered) return;
    setState(() => _answered = true);

    final correct = option == _current.correctAnswer;

    int scoreDelta;
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

    _sessionScore += scoreDelta;

    await ScoresDatabaseHelper().insertScore(
      userId: widget.user.id!,
      difficulty: widget.level,
      score: scoreDelta,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          correct
              ? 'Correto! Ganhaste $scoreDelta pontos.'
              : 'Errado! Perdeste ${-scoreDelta} pontos.\nResposta certa: ${_current.correctAnswer}',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: correct ? Colors.green.shade600 : Colors.red.shade700,
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _loadNext();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Nível ${widget.level}'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Score: $_sessionScore',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  _current.questionText,
                  key: ValueKey<String>(_current.questionText),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              ..._current.options.map(
                (opt) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:
                          _answered
                              ? (opt == _current.correctAnswer
                                  ? Colors.green
                                  : (opt == _current.correctAnswer
                                      ? Colors.green
                                      : Colors.red))
                              : Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => _onSelect(opt),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          child: Center(
                            child: Text(
                              opt,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
