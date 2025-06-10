import 'package:flutter/material.dart';
import 'package:IPMaster/views/splash_screen_view.dart';

void main() {
  runApp(const BaseJump());
}

class BaseJump extends StatelessWidget {
  const BaseJump({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IPMaster',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF002E3C),
        scaffoldBackgroundColor: const Color(0xFF002E3C),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF002E3C),
          brightness: Brightness.dark,
        ),
      ),

      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // Set the initial screen to SplashScreen
    );
  }
}
