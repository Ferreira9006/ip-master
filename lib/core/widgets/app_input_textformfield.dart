import 'package:flutter/material.dart';

/// Campo de texto personalizado reutilizável (TextFormField).
/// Este widget aplica um estilo comum a todos os campos de entrada da aplicação,
/// facilitando a consistência visual e a reutilização.
class AppInputTextformfield extends StatelessWidget {
  final TextInputType keyboardType;
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool obscureText;

  const AppInputTextformfield({
    super.key,
    required this.keyboardType,
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.validator,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    final input = TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(hintText: hintText, prefixIcon: Icon(icon)),
      controller: controller,
      validator: validator,
    );

    return input;
  }
}
