import 'package:ip_master/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:ip_master/views/splash_screen_view.dart';

void main() {
  runApp(const IpMaster());
}

class IpMaster extends StatelessWidget {
  const IpMaster({super.key});

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
