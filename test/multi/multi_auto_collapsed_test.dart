import 'package:flutter_test/flutter_test.dart';
import 'package:list_selection_widget/list_selection_widget.dart';

import '../helpers.dart';

void main() {
  testWidgets('autoCollapsed=true collapses after each selection', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.multi(
      hintText: 'Pick many',
      listItems: fruits,
      multiSelectValues: const [],
      onMultiItemsSelected: (_) {},
      autoCollapsed: true,
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    await tester.tap(listRow('Apple'));
    await tester.pumpAndSettle();
    expect(find.text('Banana').hitTestable(), findsNothing);
  });

  testWidgets('autoCollapsed=true fires onExpansionChanged(false)', (tester) async {
    bool? result;
    await tester.pumpWidget(wrap(ListSelectionWidget.multi(
      hintText: 'Pick many',
      listItems: fruits,
      multiSelectValues: const [],
      onMultiItemsSelected: (_) {},
      autoCollapsed: true,
      initiallyExpanded: true,
      onExpansionChanged: (v) => result = v,
    )));
    await tester.pumpAndSettle();
    await tester.tap(listRow('Apple'));
    await tester.pumpAndSettle();
    expect(result, isFalse);
  });

  testWidgets('autoCollapsed=false keeps list open after selection', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.multi(
      hintText: 'Pick many',
      listItems: fruits,
      multiSelectValues: const [],
      onMultiItemsSelected: (_) {},
      autoCollapsed: false,
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    await tester.tap(listRow('Apple'));
    await tester.pumpAndSettle();
    expect(find.text('Banana').hitTestable(), findsOneWidget);
  });
}
