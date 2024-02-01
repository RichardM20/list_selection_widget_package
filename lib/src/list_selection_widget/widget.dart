import 'package.dart';

class ListSelectionWidget extends StatefulWidget {
  final String hintText;
  final List<SelectionItem> listItems;
  final bool isMultiSelection;
  //multi
  final List<dynamic>? multiSelectValues;
  final Function(List<dynamic>)? onMultiItemsSelected;
  //single
  final dynamic selectedValue;
  final Function(dynamic)? onSingleItemSelected;
  final Widget? selectedIcon;
  final bool? hideLines;
  final EdgeInsetsGeometry? itemMargin;
  final EdgeInsetsGeometry? itemPadding;
  final Decoration? decoration;
  final TextStyle? titleStyle;
  final TextStyle? itemTextStyle;
  final TextStyle? selectedItemTextStyle;
  final EdgeInsets? contentPadding;
  final EdgeInsets? titlePadding;
  final Widget? titleIcon;
  final bool? scrollControl;
  final double? maxHeight;
  final Color? collapsedIconColor;
  final Color? expandedIconColor;
  final Color? selectedIconColor;
  final Color? backgroundSelectedIconColor;
  final Color? unSelecctedIconColor;

  const ListSelectionWidget({
    Key? key,
    required this.listItems,
    this.multiSelectValues = const [],
    this.onMultiItemsSelected,
    this.hideLines,
    this.itemMargin,
    this.itemPadding,
    this.titleStyle,
    this.decoration,
    this.contentPadding,
    required this.hintText,
    this.titleIcon,
    this.scrollControl,
    this.maxHeight,
    this.titlePadding,
    this.itemTextStyle,
    this.selectedValue,
    this.onSingleItemSelected,
    required this.isMultiSelection,
    this.selectedIcon,
    this.collapsedIconColor,
    this.expandedIconColor,
    this.selectedIconColor,
    this.backgroundSelectedIconColor,
    this.unSelecctedIconColor,
    this.selectedItemTextStyle,
  })  : assert(
          (isMultiSelection && onMultiItemsSelected != null) ||
              (!isMultiSelection && onSingleItemSelected != null),
          'Invalid configuration: If isMultiSelection is true, you must provide onMultiItemsSelected. If isMultiSelection is false, you must provide onSingleItemSelected.',
        ),
        assert(
            scrollControl == true
                ? (maxHeight != null && maxHeight > 30)
                : true,
            'You must enter a max height greater than 30 if you want to scroll through the list'),
        super(key: key);

  @override
  State<ListSelectionWidget> createState() => _ListSelectionWidgetState();
}

class _ListSelectionWidgetState extends State<ListSelectionWidget> {
  late List<SelectionItem> multiSelectValues;
  late SelectionItem singleSelectValue;
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
        paddingContent: widget.contentPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListSelectionWidgetTitleContent(
              collapsedIconColor: widget.collapsedIconColor,
              expandedIconColor: widget.expandedIconColor,
              selected: getTextTitle(),
              titleContentPadding: widget.titlePadding,
              titleStyle: widget.titleStyle,
              icon: widget.titleIcon,
            ),
            CrossAnimationWidget(
              stream: streamController,
              child: SizedBox(
                height: widget.scrollControl == true ? widget.maxHeight : null,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.listItems.length, (index) {
                      return ListSelectionWidgetItemContent(
                        selectedItemTextStyle: widget.selectedItemTextStyle,
                        backgroundSelectedIconColor:
                            widget.backgroundSelectedIconColor,
                        selectedIconColor: widget.selectedIconColor,
                        unSelecctedIconColor: widget.unSelecctedIconColor,
                        isMultiSelection: widget.isMultiSelection,
                        selectedIcon: widget.selectedIcon,
                        itemTextStyle: widget.itemTextStyle,
                        hideLines: widget.hideLines,
                        itemMargin: widget.itemMargin,
                        itemPadding: widget.itemPadding,
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
          : multiSelectValues.map((item) => item.displayValue).join(', ');
    } else {
      return singleSelectValue.displayValue;
    }
  }

  dynamic selectedPass() {
    if (widget.isMultiSelection == true) {
      return multiSelectValues.map((item) => item.value).toList();
    } else {
      return singleSelectValue.value;
    }
  }

  void onTap(SelectionItem item) {
    setState(() {
      if (widget.isMultiSelection == true) {
        toggleMultiItem(item);
      } else {
        toggleSingleItem(item);
      }
    });
  }

  void toggleMultiItem(SelectionItem item) {
    setState(() {
      if (multiSelectValues
          .any((selectedItem) => selectedItem.value == item.value)) {
        multiSelectValues
            .removeWhere((selectedItem) => selectedItem.value == item.value);
      } else {
        multiSelectValues.add(item);
      }
      widget.onMultiItemsSelected!(
          multiSelectValues.map((item) => item.value).toList());
    });
  }

  void setMultiItems() {
    if (widget.multiSelectValues!.isEmpty) {
      multiSelectValues = [];
    } else {
      multiSelectValues = widget.listItems
          .where((item) => widget.multiSelectValues!.contains(item.value))
          .toList();
    }
  }

  void toggleSingleItem(SelectionItem item) {
    if (item.value == singleSelectValue.value) {
      singleSelectValue = SelectionItem(
        value: null,
        displayValue: widget.hintText,
      );
    } else {
      singleSelectValue = item;
      widget.onSingleItemSelected!(
        item.value,
      );
    }
    setState(() {});
  }

  void setSingleItem() {
    if (widget.selectedValue != null) {
      singleSelectValue = widget.listItems.firstWhere(
        (item) => item.value == widget.selectedValue,
        orElse: () => widget.listItems.first,
      );
    } else {
      singleSelectValue = SelectionItem(
        value: null,
        displayValue: widget.hintText,
      );
    }
  }
}
