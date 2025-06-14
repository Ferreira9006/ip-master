import 'package:flutter/material.dart';

/// Botão personalizado de largura total.
/// Este widget permite reutilizar um botão estilizado de forma consistente,
/// com ou sem ícone, ocupando toda a largura disponível.
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

    // Devolve o botão dentro de um SizedBox para ocupar toda a largura disponível
    return SizedBox(width: double.infinity, child: button);
  }
}
