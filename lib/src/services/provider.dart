import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Provider extends InheritedWidget {
  final bool? isExpanded;
  final ValueChanged<bool> toggleExpansion;

  const Provider({
    super.key,
    required this.toggleExpansion,
    required Widget child,
    this.isExpanded,
  }) : super(child: child);

  static Provider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>();
  }

  @override
  bool updateShouldNotify(Provider oldWidget) {
    return isExpanded != oldWidget.isExpanded;
  }
}
