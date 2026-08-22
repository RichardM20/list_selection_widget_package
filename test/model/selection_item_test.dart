import 'package:flutter_test/flutter_test.dart';
import 'package:list_selection_widget/list_selection_widget.dart';

void main() {
  test('stores value and label', () {
    const item = SelectionItem(value: 42, label: 'Test');
    expect(item.value, 42);
    expect(item.label, 'Test');
  });

  test('supports generic types — String value', () {
    const item = SelectionItem(value: 'id-1', label: 'Option A');
    expect(item.value, 'id-1');
  });

  test('two items with same value are logically equal via value comparison',
      () {
    const a = SelectionItem(value: 1, label: 'A');
    const b = SelectionItem(value: 1, label: 'B');
    expect(a.value == b.value, isTrue);
  });
}
