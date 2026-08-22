import 'package:flutter_test/flutter_test.dart';
import 'package:list_selection_widget/list_selection_widget.dart';

import '../helpers.dart';

void main() {
  testWidgets('selecting an item adds it and fires callback', (tester) async {
    List<SelectionItem<int>> result = [];
    await tester.pumpWidget(wrap(ListSelectionWidget.multi(
      hintText: 'Pick many',
      listItems: fruits,
      multiSelectValues: const [],
      onMultiItemsSelected: (items) => result = List.from(items.cast()),
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    await tester.tap(listRow('Apple'));
    await tester.pumpAndSettle();
    expect(result.map((e) => e.value), contains(1));
  });

  testWidgets('selecting multiple items accumulates all', (tester) async {
    List<SelectionItem> result = [];
    await tester.pumpWidget(wrap(ListSelectionWidget.multi(
      hintText: 'Pick many',
      listItems: fruits,
      multiSelectValues: const [],
      onMultiItemsSelected: (items) => result = List.from(items),
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    await tester.tap(listRow('Apple'));
    await tester.pumpAndSettle();
    await tester.tap(listRow('Cherry'));
    await tester.pumpAndSettle();
    expect(result.map((e) => e.value), containsAll([1, 3]));
    expect(result.length, 2);
  });

  testWidgets('deselecting removes item from selection', (tester) async {
    List<SelectionItem> result = [fruits[0], fruits[1]];
    await tester.pumpWidget(wrap(ListSelectionWidget.multi(
      hintText: 'Pick many',
      listItems: fruits,
      multiSelectValues: result,
      onMultiItemsSelected: (items) => result = List.from(items),
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    await tester.tap(listRow('Apple'));
    await tester.pumpAndSettle();
    expect(result.map((e) => e.value), isNot(contains(1)));
    expect(result.map((e) => e.value), contains(2));
  });

  testWidgets('deselecting all items reverts header to hintText', (tester) async {
    List<SelectionItem> result = [fruits[0]];
    Future<void> pump() => tester.pumpWidget(wrap(ListSelectionWidget.multi(
          hintText: 'Pick many',
          listItems: fruits,
          multiSelectValues: result,
          onMultiItemsSelected: (items) => result = List.from(items),
          initiallyExpanded: true,
        )));
    await pump();
    await tester.pumpAndSettle();
    await tester.tap(listRow('Apple'));
    await tester.pumpAndSettle();
    await pump();
    await tester.pumpAndSettle();
    expect(find.text('Pick many'), findsOneWidget);
  });

  testWidgets('header updates to reflect all selected labels', (tester) async {
    List<SelectionItem> result = [];
    Future<void> pump() => tester.pumpWidget(wrap(ListSelectionWidget.multi(
          hintText: 'Pick many',
          listItems: fruits,
          multiSelectValues: result,
          onMultiItemsSelected: (items) => result = List.from(items),
          initiallyExpanded: true,
        )));
    await pump();
    await tester.pumpAndSettle();
    await tester.tap(listRow('Apple'));
    await tester.pumpAndSettle();
    await tester.tap(listRow('Banana'));
    await tester.pumpAndSettle();
    await pump();
    await tester.pumpAndSettle();
    expect(find.text('Apple, Banana'), findsOneWidget);
  });

  testWidgets('callback receives immutable list snapshot', (tester) async {
    List<SelectionItem>? snapshot;
    await tester.pumpWidget(wrap(ListSelectionWidget.multi(
      hintText: 'Pick many',
      listItems: fruits,
      multiSelectValues: const [],
      onMultiItemsSelected: (items) => snapshot = items,
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    await tester.tap(listRow('Apple'));
    await tester.pumpAndSettle();
    expect(() => snapshot!.add(fruits[1]), throwsUnsupportedError);
  });
}
