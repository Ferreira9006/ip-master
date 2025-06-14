import 'package:flutter/material.dart';

/// Input personalizado reutilizável com estilo consistente
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
