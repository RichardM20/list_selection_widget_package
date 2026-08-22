import 'package:flutter_test/flutter_test.dart';
import 'package:list_selection_widget/list_selection_widget.dart';

import '../helpers.dart';

void main() {
  testWidgets('autoCollapsed=true collapses after selection', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      autoCollapsed: true,
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    await tester.tap(listRow('Apple'));
    await tester.pumpAndSettle();
    expect(find.text('Banana').hitTestable(), findsNothing);
  });

  testWidgets('autoCollapsed=true fires onExpansionChanged(false)',
      (tester) async {
    bool? result;
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      autoCollapsed: true,
      initiallyExpanded: true,
      onExpansionChanged: (v) => result = v,
    )));
    await tester.pumpAndSettle();
    await tester.tap(listRow('Banana'));
    await tester.pumpAndSettle();
    expect(result, isFalse);
  });

  testWidgets('autoCollapsed=false keeps list open after selection',
      (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      autoCollapsed: false,
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    await tester.tap(listRow('Apple'));
    await tester.pumpAndSettle();
    expect(find.text('Banana').hitTestable(), findsOneWidget);
  });

  testWidgets('re-tapping selected item does NOT collapse — bug #10',
      (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: fruits[0],
      onSingleItemSelected: (_) {},
      autoCollapsed: true,
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    await tester.tap(listRow('Apple'));
    await tester.pumpAndSettle();
    expect(find.text('Banana').hitTestable(), findsOneWidget);
  });
}
