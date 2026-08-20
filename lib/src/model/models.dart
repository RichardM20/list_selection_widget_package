import 'package:flutter/material.dart';

typedef SelectionTitleBuilder<T> = String Function(
  List<SelectionItem<T>> selectedItems,
);

typedef SelectionItemBuilder<T> = Widget Function(
  BuildContext context,
  SelectionItem<T> item,
  bool isSelected,
);

class SelectionItem<T> {
  final T value;
  final String label;

  const SelectionItem({required this.value, required this.label});
}

class IconStyleData {
  final Color? collapsedIconColor;
  final Color? expandedIconColor;
  final Color? selectedIconColor;
  final Color? backgroundSelectedIconColor;
  final Color? unselectedIconColor;
  final Widget? trailingIcon;
  final Widget? selectionCustomIcon;
  final bool? allowDefaultRotation;

  const IconStyleData({
    this.collapsedIconColor,
    this.expandedIconColor,
    this.selectedIconColor,
    this.backgroundSelectedIconColor,
    this.unselectedIconColor,
    this.trailingIcon,
    this.selectionCustomIcon,
    this.allowDefaultRotation = true,
  });
}

class TextStyleData {
  final TextStyle? titleStyle;
  final TextStyle? itemTextStyle;
  final TextStyle? selectedItemTextStyle;

  const TextStyleData({
    this.titleStyle,
    this.itemTextStyle,
    this.selectedItemTextStyle,
  });
}

class PaddingData {
  final EdgeInsets? contentPadding;
  final EdgeInsets? titlePadding;
  final EdgeInsetsGeometry? itemPadding;
  final EdgeInsetsGeometry? itemMargin;

  const PaddingData({
    this.contentPadding,
    this.titlePadding,
    this.itemPadding,
    this.itemMargin,
  });
}
