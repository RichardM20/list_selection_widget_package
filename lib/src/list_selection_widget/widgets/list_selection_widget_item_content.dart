import '../package.dart';

// ignore: must_be_immutable
class ListSelectionWidgetItemContent extends StatelessWidget {
  final bool? hideLines;
  final Color? selectedIconColor;
  final Color? backgroundSelectedIconColor;
  final Color? unSelecctedIconColor;
  final EdgeInsetsGeometry? itemMargin;
  final EdgeInsetsGeometry? itemPadding;
  final void Function()? onTap;
  final SelectionItem item;
  final dynamic selected;
  final TextStyle? itemTextStyle;
  final Widget? selectedIcon;
  final bool isMultiSelection;
  final TextStyle? selectedItemTextStyle;
  const ListSelectionWidgetItemContent({
    super.key,
    this.hideLines,
    this.itemMargin,
    this.itemPadding,
    this.onTap,
    required this.item,
    this.itemTextStyle,
    this.selected,
    this.selectedIcon,
    required this.isMultiSelection,
    this.selectedIconColor,
    this.backgroundSelectedIconColor,
    this.unSelecctedIconColor,
    this.selectedItemTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MultiSelectedWidgetItemDecoration(
        hideLines: hideLines,
        itemMargin: itemMargin,
        itemPadding: itemPadding,
        child: Row(
          children: [
            iconMulti(),
            styleText(),
          ],
        ),
      ),
    );
  }

  iconMulti() {
    return isMultiSelection == false
        ? selectedIcon ??
            _selectedIconContent(
              selected == item.value,
            )
        : _selectedIconContent(selected.contains(item.value));
  }

  styleText() {
    return isMultiSelection == false
        ? selectedIcon ??
            selectedTextContent(
              selected == item.value,
            )
        : selectedTextContent(selected.contains(item.value));
  }

  Widget selectedTextContent(bool value) {
    return Expanded(
      child: Text(
        item.displayValue,
        style: itemTextStyle == null
            ? value == true
                ? selectedItemTextStyle
                : const TextStyle(
                    color: Colors.black,
                  )
            : value == true
                ? selectedItemTextStyle
                : itemTextStyle,
      ),
    );
  }

  Widget _selectedIconContent(bool value) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundSelectedIconColor ?? Colors.grey.shade100,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check,
        color: value
            ? selectedIconColor ?? Colors.blue
            : unSelecctedIconColor ?? Colors.grey,
        size: 15,
      ),
    );
  }
}
