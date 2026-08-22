import 'package:flutter_test/flutter_test.dart';
import 'package:list_selection_widget/list_selection_widget.dart';

final fruits = [
  const SelectionItem(value: 1, label: 'Apple'),
  const SelectionItem(value: 2, label: 'Banana'),
  const SelectionItem(value: 3, label: 'Cherry'),
];

Widget wrap(Widget child) =>
    MaterialApp(home: Scaffold(body: Center(child: child)));

Finder listRow(String label) => find.text(label).hitTestable().last;
