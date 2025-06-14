import 'package:IPMaster/core/theme.dart';
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
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // Set the initial screen to SplashScreen
    );
  }
}
