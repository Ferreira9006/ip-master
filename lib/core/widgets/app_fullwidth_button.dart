import 'package:flutter/material.dart';

/// Botão personalizado de largura total.
/// Usa o tema da aplicação, mas permite sobreposição de estilo.
class AppFullWidthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const AppFullWidthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultStyle = theme.textTheme.labelLarge;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
        label: Text(text),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? theme.primaryColor,
          foregroundColor: foregroundColor ?? theme.colorScheme.onPrimary,
          textStyle: TextStyle(
            fontSize: fontSize ?? defaultStyle?.fontSize,
            fontWeight: fontWeight ?? defaultStyle?.fontWeight,
          ),
        ),
      ),
    );
  }
}
