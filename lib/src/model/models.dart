import 'package:list_selection_widget/list_selection_widget.dart';

class SelectionItem<T> {
  final T value;
  final String label;

  SelectionItem({required this.value, required this.label});
}

class IconStyleData {
  final Color? collapsedIconColor;
  final Color? expandedIconColor;
  final Color? selectedIconColor;
  final Color? backgroundSelectedIconColor;
  final Color? unselectedIconColor;
  final Widget? tailingIcon;
  final Widget? selectionCustomIcon;
  final bool? allowDefaultRotation;

  const IconStyleData({
    this.collapsedIconColor,
    this.expandedIconColor,
    this.selectedIconColor,
    this.backgroundSelectedIconColor,
    this.unselectedIconColor,
    this.tailingIcon,
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
