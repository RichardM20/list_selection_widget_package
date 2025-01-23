import 'package:list_selection_widget/src/list_selection_widget/widgets/icon.dart';

import '../package.dart';
import 'list_selection_widget_items_decoration.dart';

class ListSelectionWidgetItemContent<T> extends StatelessWidget {
  final bool? hideLines;
  final IconStyleData? iconStyle;
  final TextStyleData? textStyle;
  final PaddingData? paddingData;
  final void Function()? onTap;
  final SelectionItem<T> item;
  final dynamic selected;
  final bool isMultiSelection;
  final TextStyle? selectedItemTextStyle;

  const ListSelectionWidgetItemContent({
    required this.item,
    required this.isMultiSelection,
    Key? key,
    this.hideLines,
    this.onTap,
    this.selected,
    this.selectedItemTextStyle,
    this.iconStyle,
    this.textStyle,
    this.paddingData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MultiSelectedWidgetItemDecoration(
        hideLines: hideLines,
        itemMargin: paddingData?.itemMargin,
        itemPadding: paddingData?.itemPadding,
        child: Row(
          children: [
            _buildIcon(),
            _buildText(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    bool isSelected = _isItemSelected();

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

  Widget _buildText() {
    bool isSelected = _isItemSelected();

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
      if (selected != null && selected is List<SelectionItem<T>>) {
        return (selected as List<SelectionItem<T>>).contains(item);
      }
    } else {
      if (selected != null && selected is SelectionItem<T>) {
        return selected == item;
      }
    }
    return false;
  }
}
