import 'package:flutter/material.dart';
import 'package:IPMaster/modules/auth/views/login_view.dart';

/// Ecrã de introdução (Splash Screen) apresentado ao iniciar a aplicação.
/// Mostra o logótipo e uma frase antes de redirecionar para a tela principal.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key}); // Construtor

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// Estado associado ao [SplashScreen].
/// Responsável por iniciar o temporizador e navegar para o ecrã principal.
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Aguarda 5 segundos antes de navegar automaticamente para o LoginView
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003945), // Cor de fundo da splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logótipo da aplicação
            Image.asset('assets/images/logo.png', width: 200),

            const SizedBox(height: 24), // Espaço entre imagem e texto
            // Frase de apresentação
            const Text(
              'Between zeros and ones',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
