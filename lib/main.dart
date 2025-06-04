import 'package:flutter/material.dart';
import 'package:number_converter_app/views/splash_screen_view.dart';

void main() {
  runApp(const BaseJump());
}

class BaseJump extends StatelessWidget {
  const BaseJump({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Converter',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF003945),
        scaffoldBackgroundColor: const Color(0xFF003945),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF003945),
          brightness: Brightness.dark,
        ),
      ),

      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // Set the initial screen to SplashScreen
    );
  }
}
