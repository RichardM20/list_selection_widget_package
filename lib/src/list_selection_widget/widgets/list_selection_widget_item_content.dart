import '../package.dart';

// ignore: must_be_immutable
class ListSelectionWidgetItemContent extends StatelessWidget {
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
  });

  final bool? hideLines;

  final EdgeInsetsGeometry? itemMargin;
  final EdgeInsetsGeometry? itemPadding;
  final void Function()? onTap;
  final SelectionItem item;

  final dynamic selected;
  final TextStyle? itemTextStyle;
  final Widget? selectedIcon;

  final bool isMultiSelection;
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
            _selectedTextContent(),
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

  Widget _selectedTextContent() {
    return Expanded(
      child: Text(
        item.displayValue,
        style: itemTextStyle ??
            const TextStyle(
              color: Colors.black,
            ),
      ),
    );
  }

  Widget _selectedIconContent(bool value) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check,
        color: value ? Colors.blue : Colors.grey,
        size: 15,
      ),
    );
  }
}
