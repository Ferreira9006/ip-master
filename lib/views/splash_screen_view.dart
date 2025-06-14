// Importa as bibliotecas necessárias
import 'package:flutter/material.dart';
import 'package:ip_master/modules/auth/views/login_view.dart';

/// Ecrã de introdução (Splash Screen) apresentado ao iniciar a aplicação.
/// Mostra o logótipo e uma imagem de fundo durante alguns segundos,
/// antes de redirecionar automaticamente para o ecrã de login.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key}); // Construtor da classe

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// Classe que representa o estado associado ao SplashScreen.
/// Aqui é iniciado o temporizador e feita a navegação automática.
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Após 7 segundos, substitui o ecrã atual pelo ecrã de login.
    // Utiliza pushReplacement para que o utilizador não possa voltar atrás.
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
        // Imagem de fundo da splash screen, ocupa todo o ecrã
        Image.asset(
          "assets/images/login_background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        // Sobreposição do conteúdo da splash screen (logótipo)
        Scaffold(
          backgroundColor:
              Colors
                  .transparent, // Torna o fundo transparente para mostrar a imagem
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logótipo da aplicação
                Image.asset('assets/images/logo.png', width: 300),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
