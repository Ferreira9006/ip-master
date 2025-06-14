import 'package:flutter/material.dart';

/// Botão personalizado reutilizável com estilo consistente
class AppFullWidthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const AppFullWidthButton({
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
    );

    return SizedBox(width: double.infinity, child: button);
  }
}
