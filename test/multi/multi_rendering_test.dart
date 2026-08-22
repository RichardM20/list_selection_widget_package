import 'package:flutter_test/flutter_test.dart';
import 'package:list_selection_widget/list_selection_widget.dart';

import '../helpers.dart';

void main() {
  testWidgets('shows hintText when multiSelectValues is empty', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.multi(
      hintText: 'Pick many',
      listItems: fruits,
      multiSelectValues: const [],
      onMultiItemsSelected: (_) {},
    )));
    expect(find.text('Pick many'), findsOneWidget);
  });

  testWidgets('shows comma-separated labels for pre-selected items', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.multi(
      hintText: 'Pick many',
      listItems: fruits,
      multiSelectValues: [fruits[0], fruits[2]],
      onMultiItemsSelected: (_) {},
    )));
    await tester.pump();
    expect(find.text('Apple, Cherry'), findsOneWidget);
  });

  testWidgets('shows single label when one item pre-selected', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.multi(
      hintText: 'Pick many',
      listItems: fruits,
      multiSelectValues: [fruits[1]],
      onMultiItemsSelected: (_) {},
    )));
    await tester.pump();
    expect(find.text('Banana'), findsWidgets);
  });

  testWidgets('pre-selected items show isSelected=true via itemBuilder', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.multi(
      hintText: 'Pick many',
      listItems: fruits,
      multiSelectValues: [fruits[0]],
      onMultiItemsSelected: (_) {},
      initiallyExpanded: true,
      itemBuilder: (ctx, item, isSelected) => Text('${item.label}:$isSelected'),
    )));
    await tester.pumpAndSettle();
    expect(find.text('Apple:true'), findsOneWidget);
    expect(find.text('Banana:false'), findsOneWidget);
  });
}
