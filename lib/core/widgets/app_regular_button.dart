import 'package:flutter/material.dart';

/// Botão reutilizável com estilo consistente.
/// Pode incluir texto e um ícone opcional.
/// Ao contrário do AppFullWidthButton, este botão não ocupa toda a largura disponível.
class AppRegularButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const AppRegularButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton.icon(
      icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
      label: Text(text),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );

    return button;
  }
}
