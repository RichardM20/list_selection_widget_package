import 'package:flutter_test/flutter_test.dart';
import 'package:list_selection_widget/list_selection_widget.dart';

import '../helpers.dart';

void main() {
  testWidgets('selectedTitleBuilder receives all selected items', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.multi(
      hintText: 'Pick many',
      listItems: fruits,
      multiSelectValues: [fruits[0], fruits[1]],
      onMultiItemsSelected: (_) {},
      selectedTitleBuilder: (items) => '${items.length} selected',
    )));
    await tester.pump();
    expect(find.text('2 selected'), findsOneWidget);
  });

  testWidgets('selectedTitleBuilder receives empty list when nothing selected', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.multi(
      hintText: 'Pick many',
      listItems: fruits,
      multiSelectValues: const [],
      onMultiItemsSelected: (_) {},
      selectedTitleBuilder: (items) => 'Count:${items.length}',
    )));
    await tester.pump();
    expect(find.text('Count:0'), findsOneWidget);
  });

  testWidgets('itemBuilder renders for every list item', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.multi(
      hintText: 'Pick many',
      listItems: fruits,
      multiSelectValues: const [],
      onMultiItemsSelected: (_) {},
      initiallyExpanded: true,
      itemBuilder: (ctx, item, _) => Text('ROW:${item.label}'),
    )));
    await tester.pumpAndSettle();
    for (final item in fruits) {
      expect(find.text('ROW:${item.label}'), findsOneWidget);
    }
  });
}
