import 'package:flutter/material.dart';

class IconContent extends StatelessWidget {
  const IconContent({
    super.key,
    required this.changed,
    this.icon,
    this.defaultColor,
    this.undefaultColor,
  });
  final Widget? icon;
  final Color? defaultColor;
  final Color? undefaultColor;
  final bool changed;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return icon!;
    }
    return Icon(
      Icons.arrow_forward_ios_rounded,
      size: 14,
      color:
          changed ? defaultColor ?? Colors.blue : undefaultColor ?? Colors.grey,
    );
  }
}
