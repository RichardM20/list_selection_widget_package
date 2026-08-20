import 'package:flutter/material.dart';

import '../model/models.dart';
import 'widgets/cross_animation_widget.dart';
import 'widgets/list_selection_widget_decoration.dart';
import 'widgets/list_selection_widget_item_content.dart';
import 'widgets/list_selection_widget_top_content.dart';

class ListSelectionWidgetBase<T> extends StatefulWidget {
  final String hintText;
  final List<SelectionItem<T>> listItems;
  final bool isMultiSelection;
  final List<SelectionItem<T>>? multiSelectValues;
  final Function(List<SelectionItem<T>>)? onMultiItemsSelected;
  final SelectionItem<T>? selectedValue;
  final Function(SelectionItem<T>)? onSingleItemSelected;
  final bool? hideLines;
  final Decoration? decoration;
  final IconStyleData? iconStyle;
  final TextStyleData? textStyle;
  final PaddingData? paddingData;
  final double? maxHeight;
  final bool autoCollapsed;
  final Duration animationDuration;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onExpansionChanged;
  final SelectionTitleBuilder<T>? selectedTitleBuilder;
  final SelectionItemBuilder<T>? itemBuilder;

  const ListSelectionWidgetBase({
    super.key,
    required this.listItems,
    required this.hintText,
    required this.isMultiSelection,
    this.multiSelectValues = const [],
    this.onMultiItemsSelected,
    this.hideLines,
    this.decoration,
    this.iconStyle,
    this.textStyle,
    this.paddingData,
    this.maxHeight,
    this.selectedValue,
    this.onSingleItemSelected,
    this.autoCollapsed = false,
    this.animationDuration = const Duration(milliseconds: 200),
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.selectedTitleBuilder,
    this.itemBuilder,
  });

  @override
  State<ListSelectionWidgetBase<T>> createState() =>
      _ListSelectionWidgetBaseState<T>();
}

class _ListSelectionWidgetBaseState<T>
    extends State<ListSelectionWidgetBase<T>> {
  List<SelectionItem<T>> multiSelectValues = [];
  SelectionItem<T>? singleSelectValue;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.initiallyExpanded;
    syncSelectedItems();
  }

  @override
  void didUpdateWidget(covariant ListSelectionWidgetBase<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isMultiSelection != widget.isMultiSelection ||
        oldWidget.listItems != widget.listItems ||
        oldWidget.selectedValue != widget.selectedValue ||
        oldWidget.multiSelectValues != widget.multiSelectValues) {
      syncSelectedItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListSelectionWidgetDecoration(
      decoration: widget.decoration,
      paddingContent: widget.paddingData?.contentPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListSelectionWidgetTitleContent(
            selected: getTextTitle(),
            titleContentPadding: widget.paddingData?.titlePadding,
            titleStyle: widget.textStyle?.titleStyle,
            iconStyleData: widget.iconStyle,
            isExpanded: isExpanded,
            animationDuration: widget.animationDuration,
            onTap: toggleExpansion,
          ),
          CrossAnimationWidget(
            isExpanded: isExpanded,
            duration: widget.animationDuration,
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.1,
                maxHeight: widget.maxHeight ?? double.infinity,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (final item in widget.listItems)
                      ListSelectionWidgetItemContent(
                        selectedItemTextStyle:
                            widget.textStyle?.selectedItemTextStyle,
                        iconStyle: widget.iconStyle,
                        paddingData: widget.paddingData,
                        textStyle: widget.textStyle,
                        isMultiSelection: widget.isMultiSelection,
                        hideLines: widget.hideLines,
                        item: item,
                        selectedItem: singleSelectValue,
                        selectedItems: multiSelectValues,
                        itemBuilder: widget.itemBuilder,
                        onTap: () => onTap(item),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void syncSelectedItems() {
    if (widget.isMultiSelection == true) {
      setMultiItems();
      singleSelectValue = null;
    } else {
      multiSelectValues = [];
      setSingleItem();
    }
  }

  String getTextTitle() {
    final titleBuilder = widget.selectedTitleBuilder;
    if (titleBuilder != null) {
      return titleBuilder(selectedItems);
    }

    if (widget.isMultiSelection == true) {
      return multiSelectValues.isEmpty
          ? widget.hintText
          : multiSelectValues.map((item) => item.label).join(', ');
    }
    return singleSelectValue?.label ?? widget.hintText;
  }

  List<SelectionItem<T>> get selectedItems {
    if (widget.isMultiSelection == true) {
      return List.unmodifiable(multiSelectValues);
    }

    final selectedValue = singleSelectValue;
    return selectedValue == null ? <SelectionItem<T>>[] : [selectedValue];
  }

  void onTap(SelectionItem<T> item) {
    if (widget.isMultiSelection == true) {
      toggleMultiItem(item);
    } else {
      toggleSingleItem(item);
    }
  }

  void toggleMultiItem(SelectionItem<T> item) {
    setState(() {
      if (multiSelectValues.any((value) => _isSameItem(value, item))) {
        multiSelectValues.removeWhere((value) => _isSameItem(value, item));
      } else {
        multiSelectValues.add(item);
      }
    });
    widget.onMultiItemsSelected?.call(List.unmodifiable(multiSelectValues));
    collapseIfNeeded();
  }

  void setMultiItems() {
    final selectedValues = widget.multiSelectValues ?? [];
    multiSelectValues = widget.listItems
        .where(
          (item) =>
              selectedValues.any((selected) => _isSameItem(item, selected)),
        )
        .toList();
  }

  void toggleSingleItem(SelectionItem<T> item) {
    if (_isSameItem(item, singleSelectValue)) {
      return;
    }

    setState(() {
      singleSelectValue = item;
    });
    widget.onSingleItemSelected?.call(item);
    collapseIfNeeded();
  }

  void setSingleItem() {
    final selectedValue = widget.selectedValue;
    if (selectedValue == null) {
      singleSelectValue = null;
      return;
    }

    singleSelectValue = widget.listItems.firstWhere(
      (item) => _isSameItem(item, selectedValue),
      orElse: () => selectedValue,
    );
  }

  void collapseIfNeeded() {
    if (!widget.autoCollapsed || !isExpanded) {
      return;
    }

    setState(() {
      isExpanded = false;
    });
    widget.onExpansionChanged?.call(false);
  }

  void toggleExpansion() {
    final nextValue = !isExpanded;
    setState(() {
      isExpanded = nextValue;
    });
    widget.onExpansionChanged?.call(nextValue);
  }

  bool _isSameItem(SelectionItem<T>? a, SelectionItem<T>? b) {
    return a?.value == b?.value;
  }
}
