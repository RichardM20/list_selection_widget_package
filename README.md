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