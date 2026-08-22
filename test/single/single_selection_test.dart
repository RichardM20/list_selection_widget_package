import 'package:flutter_test/flutter_test.dart';
import 'package:list_selection_widget/list_selection_widget.dart';

import '../helpers.dart';

void main() {
  testWidgets('selecting an item fires onSingleItemSelected with correct item',
      (tester) async {
    SelectionItem<int>? result;
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (item) => result = item,
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    await tester.tap(listRow('Cherry'));
    await tester.pumpAndSettle();
    expect(result?.value, 3);
    expect(result?.label, 'Cherry');
  });

  testWidgets('selecting an item updates the header to show its label',
      (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    await tester.tap(listRow('Banana'));
    await tester.pumpAndSettle();
    expect(find.text('Pick one'), findsNothing);
    expect(find.text('Banana'), findsWidgets);
  });

  testWidgets('selecting different items each fires callback', (tester) async {
    final log = <int>[];
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (item) => log.add(item.value),
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    await tester.tap(listRow('Apple'));
    await tester.pumpAndSettle();
    await tester.tap(listRow('Banana'));
    await tester.pumpAndSettle();
    expect(log, equals([1, 2]));
  });

  testWidgets(
      're-tapping already selected item — current behavior: no callback (bug #10)',
      (tester) async {
    int count = 0;
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: fruits[0],
      onSingleItemSelected: (_) => count++,
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    await tester.tap(listRow('Apple'));
    await tester.pumpAndSettle();
    expect(count, 0);
  });

  testWidgets('selected item shows w500 font weight', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: fruits[0],
      onSingleItemSelected: (_) {},
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    final texts = tester.widgetList<Text>(find.text('Apple')).toList();
    expect(texts.any((t) => t.style?.fontWeight == FontWeight.w500), isTrue);
  });

  testWidgets('unselected items use normal font weight', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: fruits[0],
      onSingleItemSelected: (_) {},
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    final widgets = tester.widgetList<Text>(find.text('Banana')).toList();
    expect(
      widgets.any(
          (t) => t.style == null || t.style?.fontWeight == FontWeight.normal),
      isTrue,
    );
  });
}
