import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF5F7FA), // fundo bem claro
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF1791C8), // azul IP Master
    brightness: Brightness.light,
  ),
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: Colors.black87, // texto principal escuro
    displayColor: Colors.black87,
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFF5F7FA),
    foregroundColor: Colors.black87,
    elevation: 0,
    centerTitle: true,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF1791C8),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      minimumSize: const Size.fromHeight(48),
    ),
  ),

  cardTheme: CardTheme(
    color: Colors.white,
    shadowColor: Colors.black12,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    elevation: 3,
    margin: const EdgeInsets.all(12),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFEDEDED),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    hintStyle: const TextStyle(color: Colors.black54),
    labelStyle: const TextStyle(color: Colors.black87),
    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
  ),
);
