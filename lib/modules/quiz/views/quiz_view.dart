import 'package:flutter/material.dart';
import 'package:ip_master/core/widgets/app_fullwidth_button.dart';
import 'package:ip_master/modules/auth/models/user_model.dart';
import 'package:ip_master/modules/quiz/models/questions_model.dart';
import 'package:ip_master/modules/quiz/utils/quiz_question.dart';
import 'package:ip_master/modules/ranking/data/scores_database_helper.dart';

/// Ecrã principal do jogo de perguntas.
/// Apresenta uma pergunta de acordo com o nível e atualiza a pontuação do jogador.
class QuizView extends StatefulWidget {
  final User user; // Utilizador autenticado
  final int level; // Nível de dificuldade selecionado

  const QuizView({super.key, required this.user, required this.level});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  late Question _current; // Pergunta atual
  bool _answered = false; // Evita múltiplas respostas
  int _sessionScore = 0; // Pontuação da sessão atual

  @override
  void initState() {
    super.initState();
    _loadNext(); // Carrega a primeira pergunta
  }

  void _loadNext() {
    setState(() {
      _current = generateQuestion(widget.level);
      _answered = false;
    });
  }

  void _onSelect(String option) async {
    if (_answered) return; // Impede respostas múltiplas
    setState(() => _answered = true);

    final correct = option == _current.correctAnswer;

    // Define pontos ganhos/perdidos com base no nível
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

    _sessionScore += scoreDelta; // Atualiza pontuação

    // Regista o resultado na base de dados local
    await ScoresDatabaseHelper().insertScore(
      userId: widget.user.id!,
      difficulty: widget.level,
      score: scoreDelta,
    );

    // Mostra feedback ao utilizador
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

    // Espera 2 segundos antes de apresentar nova pergunta
    Future.delayed(const Duration(seconds: 2), _loadNext);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Nível ${widget.level}'),
        centerTitle: true,
        actions: [
          // Mostra a pontuação atual no topo
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
            // Mostra a pergunta atual
            Text(_current.questionText, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 24),

            // Lista de opções com cores de feedback (verde/vermelho)
            ..._current.options.map(
              (opt) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: AppFullWidthButton(
                  backgroundColor:
                      _answered
                          ? (opt == _current.correctAnswer
                              ? const Color.fromARGB(255, 43, 146, 46) // verde
                              : const Color.fromARGB(
                                255,
                                156,
                                50,
                                42,
                              )) // vermelho
                          : null,
                  onPressed: () => _onSelect(opt),
                  text: opt,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
