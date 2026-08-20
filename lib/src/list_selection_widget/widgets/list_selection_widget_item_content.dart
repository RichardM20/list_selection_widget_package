import 'package:flutter/material.dart';

import '../../model/models.dart';
import 'icon.dart';
import 'list_selection_widget_items_decoration.dart';

class ListSelectionWidgetItemContent<T> extends StatelessWidget {
  final bool? hideLines;
  final IconStyleData? iconStyle;
  final TextStyleData? textStyle;
  final PaddingData? paddingData;
  final void Function()? onTap;
  final SelectionItem<T> item;
  final SelectionItem<T>? selectedItem;
  final List<SelectionItem<T>> selectedItems;
  final bool isMultiSelection;
  final TextStyle? selectedItemTextStyle;
  final SelectionItemBuilder<T>? itemBuilder;

  const ListSelectionWidgetItemContent({
    required this.item,
    required this.isMultiSelection,
    super.key,
    this.hideLines,
    this.onTap,
    this.selectedItem,
    this.selectedItems = const [],
    this.selectedItemTextStyle,
    this.iconStyle,
    this.textStyle,
    this.paddingData,
    this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = _isItemSelected();

    return GestureDetector(
      onTap: onTap,
      child: MultiSelectedWidgetItemDecoration(
        hideLines: hideLines,
        itemMargin: paddingData?.itemMargin,
        itemPadding: paddingData?.itemPadding,
        child: itemBuilder?.call(context, item, isSelected) ??
            Row(
              children: [
                _buildIcon(isSelected),
                _buildText(isSelected),
              ],
            ),
      ),
    );
  }

  Widget _buildIcon(bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isSelected
            ? (iconStyle?.backgroundSelectedIconColor ?? Colors.white)
            : Colors.grey.shade100,
        shape: BoxShape.circle,
      ),
      child: IconContent(
        changed: isSelected,
        defaultColor: iconStyle?.selectedIconColor,
        undefaultColor: iconStyle?.unselectedIconColor,
        icon: iconStyle?.selectionCustomIcon,
      ),
    );
  }

  Widget _buildText(bool isSelected) {
    return Expanded(
      child: Text(
        item.label,
        style: _getTextStyle(isSelected),
      ),
    );
  }

  TextStyle _getTextStyle(bool isSelected) {
    if (isSelected) {
      return selectedItemTextStyle ??
          const TextStyle(
            fontWeight: FontWeight.w500,
          );
    } else {
      return textStyle?.itemTextStyle ??
          const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          );
    }
  }

  bool _isItemSelected() {
    if (isMultiSelection) {
      return selectedItems.any(_isSameItem);
    }

    final selected = selectedItem;
    return selected != null && _isSameItem(selected);
  }

  bool _isSameItem(SelectionItem<T> selectedItem) {
    return selectedItem.value == item.value;
  }
}
