import '../services/provider.dart';
import 'package.dart';
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
  });

  @override
  State<ListSelectionWidgetBase<T>> createState() =>
      _ListSelectionWidgetBaseState<T>();
}

class _ListSelectionWidgetBaseState<T>
    extends State<ListSelectionWidgetBase<T>> {
  late List<SelectionItem<T>> multiSelectValues;
  late SelectionItem<T>? singleSelectValue;
  final streamController = StreamController<bool>.broadcast();

  @override
  void initState() {
    super.initState();
    if (widget.isMultiSelection == true) {
      setMultiItems();
    } else {
      setSingleItem();
    }
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      toggleExpansion: (val) {
        streamController.add(val);
      },
      child: ListSelectionWidgetDecoration(
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
            ),
            CrossAnimationWidget(
              stream: streamController,
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
                    children: List.generate(widget.listItems.length, (index) {
                      return ListSelectionWidgetItemContent(
                        selectedItemTextStyle:
                            widget.textStyle?.selectedItemTextStyle,
                        iconStyle: widget.iconStyle,
                        paddingData: widget.paddingData,
                        textStyle: widget.textStyle,
                        isMultiSelection: widget.isMultiSelection,
                        hideLines: widget.hideLines,
                        item: widget.listItems[index],
                        selected: selectedPass(),
                        onTap: () => onTap(widget.listItems[index]),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTextTitle() {
    if (widget.isMultiSelection == true) {
      return multiSelectValues.isEmpty
          ? widget.hintText
          : multiSelectValues.map((item) => item.label).join(', ');
    } else {
      return singleSelectValue?.label ?? widget.hintText;
    }
  }

  dynamic selectedPass() {
    if (widget.isMultiSelection == true) {
      return multiSelectValues;
    } else {
      return singleSelectValue;
    }
  }

  void onTap(SelectionItem<T> item) {
    setState(() {
      if (widget.isMultiSelection == true) {
        toggleMultiItem(item);
      } else {
        toggleSingleItem(item);
      }
    });
  }

  void toggleMultiItem(SelectionItem<T> item) {
    setState(() {
      if (multiSelectValues.contains(item)) {
        multiSelectValues.remove(item);
      } else {
        multiSelectValues.add(item);
      }
      widget.onMultiItemsSelected!(multiSelectValues);
    });
  }

  void setMultiItems() {
    if (widget.multiSelectValues!.isEmpty) {
      multiSelectValues = [];
    } else {
      multiSelectValues = widget.listItems
          .where((item) => widget.multiSelectValues!.contains(item))
          .toList();
    }
  }

  void toggleSingleItem(SelectionItem<T> item) {
    setState(() {
      if (item != singleSelectValue) {
        singleSelectValue = item;
        widget.onSingleItemSelected!(item);
      }
    });
  }

  void setSingleItem() {
    if (widget.selectedValue != null) {
      singleSelectValue = widget.listItems.firstWhere(
        (item) => item == widget.selectedValue,
        orElse: () => widget.listItems.first,
      );
    } else {
      singleSelectValue = null;
    }
  }
}
