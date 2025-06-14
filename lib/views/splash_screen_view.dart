import 'package:flutter/material.dart';
import 'package:ip_master/modules/auth/views/login_view.dart';

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
    Future.delayed(const Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/login_background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent, // Cor de fundo da splash screen
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset('assets/images/logo.png', width: 300)],
            ),
          ),
        ),
      ],
    );
  }
}
