import 'list_selection_widget_base.dart';
import 'package.dart';

class ListSelectionWidget<T> extends ListSelectionWidgetBase<T> {
  factory ListSelectionWidget.single({
    Key? key,
    required String hintText,
    required List<SelectionItem<T>> listItems,
    required SelectionItem<T>? selectedValue,
    required Function(SelectionItem<T>) onSingleItemSelected,
    Widget? selectedIcon,
    bool? hideLines,
    Decoration? decoration,
    IconStyleData? iconStyle,
    TextStyleData? textStyle,
    PaddingData? paddingData,
    double? maxHeight,
  }) {
    return ListSelectionWidget<T>(
      key: key,
      hintText: hintText,
      listItems: listItems,
      selectedValue: selectedValue,
      onSingleItemSelected: onSingleItemSelected,
      selectedIcon: selectedIcon,
      hideLines: hideLines,
      decoration: decoration,
      iconStyle: iconStyle,
      textStyle: textStyle,
      paddingData: paddingData,
      maxHeight: maxHeight,
      isMultiSelection: false,
    );
  }

  factory ListSelectionWidget.multi({
    Key? key,
    required String hintText,
    required List<SelectionItem<T>> listItems,
    required List<SelectionItem<T>> multiSelectValues,
    required Function(List<SelectionItem<T>>) onMultiItemsSelected,
    Widget? selectedIcon,
    bool? hideLines,
    Decoration? decoration,
    IconStyleData? iconStyle,
    TextStyleData? textStyle,
    PaddingData? paddingData,
    double? maxHeight,
  }) {
    return ListSelectionWidget<T>(
      key: key,
      hintText: hintText,
      listItems: listItems,
      multiSelectValues: multiSelectValues,
      onMultiItemsSelected: onMultiItemsSelected,
      selectedIcon: selectedIcon,
      hideLines: hideLines,
      decoration: decoration,
      iconStyle: iconStyle,
      textStyle: textStyle,
      paddingData: paddingData,
      maxHeight: maxHeight,
      isMultiSelection: true,
    );
  }

  const ListSelectionWidget({
    Key? key,
    required String hintText,
    required List<SelectionItem<T>> listItems,
    required bool isMultiSelection,
    List<SelectionItem<T>>? multiSelectValues,
    Function(List<SelectionItem<T>>)? onMultiItemsSelected,
    SelectionItem<T>? selectedValue,
    Function(SelectionItem<T>)? onSingleItemSelected,
    Widget? selectedIcon,
    bool? hideLines,
    Decoration? decoration,
    IconStyleData? iconStyle,
    TextStyleData? textStyle,
    PaddingData? paddingData,
    double? maxHeight,
  }) : super(
          key: key,
          hintText: hintText,
          listItems: listItems,
          isMultiSelection: isMultiSelection,
          multiSelectValues: multiSelectValues,
          onMultiItemsSelected: onMultiItemsSelected,
          selectedValue: selectedValue,
          onSingleItemSelected: onSingleItemSelected,
          selectedIcon: selectedIcon,
          hideLines: hideLines,
          decoration: decoration,
          iconStyle: iconStyle,
          textStyle: textStyle,
          paddingData: paddingData,
          maxHeight: maxHeight,
        );
}
