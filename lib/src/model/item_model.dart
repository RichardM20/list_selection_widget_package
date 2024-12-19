import 'package:list_selection_widget/list_selection_widget.dart';

class SelectionItem {
  final dynamic value;
  final String displayValue;

  SelectionItem({required this.value, required this.displayValue});
}

class IconStyleData {
  final Color? collapsedIconColor;
  final Color? expandedIconColor;
  final Color? selectedIconColor;
  final Color? backgroundSelectedIconColor;
  final Color? unselectedIconColor;

  const IconStyleData({
    this.collapsedIconColor,
    this.expandedIconColor,
    this.selectedIconColor,
    this.backgroundSelectedIconColor,
    this.unselectedIconColor,
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
