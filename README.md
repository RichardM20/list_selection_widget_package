# list_selection_widget

List Selection Widget is a Flutter package that provides a highly customizable dropdown list to select single or multiple options with ease.

## Preview

![Untitled video - Made with Clipchamp](https://github.com/RichardM20/list_selection_widget_package/assets/64317751/e50f4967-28de-46b5-af18-0d9254547c10)
![image](https://github.com/RichardM20/list_selection_widget_package/assets/64317751/125fb90b-0006-4d0e-8bfb-e596b62dfc63)

## Usage

First, import the package:

```dart
import 'package:list_selection_widget/list_selection_widget.dart';
```

The package provides two main constructors: `ListSelectionWidget.single` for single selection and `ListSelectionWidget.multi` for multiple selections.

> The generic `ListSelectionWidget(...)` constructor is deprecated because it can
> combine single-selection and multi-selection parameters in invalid ways. Use
> `ListSelectionWidget.single(...)` or `ListSelectionWidget.multi(...)` for new
> code.

### Single Selection

```dart
ListSelectionWidget<String>.single(
  hintText: 'Select an option',
  listItems: [
    SelectionItem(value: 'flutter', label: 'Flutter'),
    SelectionItem(value: 'react_native', label: 'React Native'),
    SelectionItem(value: 'swift', label: 'Swift'),
  ],
  selectedValue: null,
  onSingleItemSelected: (item) {
    print('Selected: ${item.label}');
  },
  autoCollapsed: true,
  animationDuration: const Duration(milliseconds: 120),
)
```

### Multiple Selection

```dart
ListSelectionWidget<String>.multi(
  hintText: 'Select multiple options',
  listItems: [
    SelectionItem(value: 'flutter', label: 'Flutter'),
    SelectionItem(value: 'react_native', label: 'React Native'),
    SelectionItem(value: 'swift', label: 'Swift'),
  ],
  multiSelectValues: [],
  onMultiItemsSelected: (items) {
    print('Selected: ${items.map((item) => item.label).join(', ')}');
  },
)
```

## Customization

The widget offers various customization options:

- `decoration`: Customize the overall appearance of the widget
- `iconStyle`: Customize the icons used in the widget
- `textStyle`: Customize the text styles
- `paddingData`: Adjust padding for different parts of the widget
- `hideLines`: Hide separator lines between items
- `maxHeight`: Set a maximum height for the dropdown list
- `autoCollapsed`: Collapse the list automatically after an item is selected
- `animationDuration`: Customize the list expansion and title icon rotation duration
- `initiallyExpanded`: Show the list opened on first build
- `onExpansionChanged`: Listen when the list opens or closes
- `selectedTitleBuilder`: Customize the title text shown when items are selected
- `itemBuilder`: Customize each item row while keeping the built-in selection behavior
- `allowDefaultRotation`: Disable the built-in title icon rotation when using a custom animated icon

Migration note: use `IconStyleData.trailingIcon` for the title icon. The old
misspelled `tailingIcon` parameter was removed.

### Customization Precedence

- `selectedTitleBuilder` replaces the default selected title text. When it is
  provided, the widget does not use `hintText` or the comma-separated selected
  labels for the title.
- `itemBuilder` replaces the default item row content. When it is provided,
  `iconStyle.selectionCustomIcon`, `iconStyle.selectedIconColor`,
  `iconStyle.unselectedIconColor`, `iconStyle.backgroundSelectedIconColor`,
  `textStyle.itemTextStyle`, and `textStyle.selectedItemTextStyle` no longer
  affect the item row content.
- `itemBuilder` does not replace the row wrapper. The package still handles item
  taps, `paddingData.itemPadding`, `paddingData.itemMargin`, and `hideLines`.
- `decoration`, `paddingData.contentPadding`, `paddingData.titlePadding`,
  `maxHeight`, `animationDuration`, and title icon options still apply when
  `itemBuilder` is used.

### Custom Title Icon Rotation

By default, the title icon rotates when the list expands or collapses. Set
`allowDefaultRotation` to `false` when you want to keep your custom
`trailingIcon` static and prevent the package from rotating it.

```dart
ListSelectionWidget<String>.single(
  hintText: 'Select an option',
  listItems: [
    SelectionItem(value: 'flutter', label: 'Flutter'),
    SelectionItem(value: 'react_native', label: 'React Native'),
  ],
  selectedValue: null,
  onSingleItemSelected: (item) {
    print('Selected: ${item.label}');
  },
  iconStyle: IconStyleData(
    trailingIcon: const Icon(Icons.more_horiz),
    allowDefaultRotation: false,
  ),
)
```

Example with customization:

```dart
ListSelectionWidget<String>.single(
  hintText: 'Select an option',
  listItems: [
    SelectionItem(value: 'flutter', label: 'Flutter'),
    SelectionItem(value: 'react_native', label: 'React Native'),
    SelectionItem(value: 'swift', label: 'Swift'),
  ],
  selectedValue: null,
  onSingleItemSelected: (item) {
    print('Selected: ${item.label}');
  },
  hideLines: true,
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(10),
  ),
  iconStyle: IconStyleData(
    collapsedIconColor: Colors.white,
    expandedIconColor: Colors.amber,
  ),
  textStyle: TextStyleData(
    titleStyle: TextStyle(color: Colors.white),
    itemTextStyle: TextStyle(color: Colors.white),
  ),
  maxHeight: 200,
  autoCollapsed: true,
  animationDuration: const Duration(milliseconds: 120),
)
```

### Custom Selected Title

```dart
ListSelectionWidget<String>.multi(
  hintText: 'Select options',
  listItems: items,
  multiSelectValues: selectedItems,
  onMultiItemsSelected: (items) {
    setState(() {
      selectedItems = items;
    });
  },
  selectedTitleBuilder: (items) {
    if (items.isEmpty) return 'Select options';
    return '${items.length} selected';
  },
)
```

### Custom Item Row

```dart
ListSelectionWidget<String>.single(
  hintText: 'Select an option',
  listItems: items,
  selectedValue: selectedItem,
  onSingleItemSelected: (item) {
    setState(() {
      selectedItem = item;
    });
  },
  itemBuilder: (context, item, isSelected) {
    return Row(
      children: [
        Icon(
          isSelected ? Icons.check_circle : Icons.circle_outlined,
          size: 18,
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(item.label)),
      ],
    );
  },
)
```

### Expansion State

```dart
ListSelectionWidget<String>.multi(
  hintText: 'Select options',
  listItems: items,
  multiSelectValues: selectedItems,
  onMultiItemsSelected: (items) {
    setState(() {
      selectedItems = items;
    });
  },
  initiallyExpanded: true,
  onExpansionChanged: (isExpanded) {
    print('Expanded: $isExpanded');
  },
)
```

## Full Example

Here's a complete example demonstrating both single and multiple selection widgets:

```dart
import 'package:flutter/material.dart';
import 'package:list_selection_widget/list_selection_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Selection Widget Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Demo(title: 'List Selection Widget Demo'),
    );
  }
}

class Demo extends StatefulWidget {
  const Demo({super.key, required this.title});

  final String title;

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final List<SelectionItem<String>> _listItems = [
    SelectionItem(value: 'flutter', label: 'Flutter'),
    SelectionItem(value: 'react_native', label: 'React Native'),
    SelectionItem(value: 'swift', label: 'Swift'),
    SelectionItem(value: 'kotlin', label: 'Kotlin'),
  ];

  SelectionItem<String>? _selectedItem;
  List<SelectionItem<String>> _multiSelectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListSelectionWidget<String>.single(
              hintText: 'Select an item',
              listItems: _listItems,
              selectedValue: _selectedItem,
              onSingleItemSelected: (item) {
                setState(() {
                  _selectedItem = item;
                });
              },
              hideLines: true,
            ),
            const SizedBox(height: 30),
            ListSelectionWidget<String>.multi(
              hintText: 'Select multiple items',
              listItems: _listItems,
              multiSelectValues: _multiSelectedItems,
              onMultiItemsSelected: (items) {
                setState(() {
                  _multiSelectedItems = items;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

This example demonstrates how to use both single and multiple selection widgets in a Flutter app, along with state management to track selected items.

## Contributing

Contributions to improve the package are welcome. If you find any issues, please report them so they can be addressed as soon as possible.
