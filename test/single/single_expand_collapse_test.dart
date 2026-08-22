import 'package:flutter_test/flutter_test.dart';
import 'package:list_selection_widget/list_selection_widget.dart';

import '../helpers.dart';

void main() {
  testWidgets('tap header expands the list', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
    )));
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pumpAndSettle();
    expect(find.text('Apple').hitTestable(), findsOneWidget);
  });

  testWidgets('second tap collapses the list', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
    )));
    final header = find.byType(GestureDetector).first;
    await tester.tap(header);
    await tester.pumpAndSettle();
    await tester.tap(header);
    await tester.pumpAndSettle();
    expect(find.text('Apple').hitTestable(), findsNothing);
  });

  testWidgets('onExpansionChanged fires true on expand', (tester) async {
    bool? result;
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      onExpansionChanged: (v) => result = v,
    )));
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pumpAndSettle();
    expect(result, isTrue);
  });

  testWidgets('onExpansionChanged fires false on collapse', (tester) async {
    final log = <bool>[];
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      onExpansionChanged: log.add,
    )));
    final header = find.byType(GestureDetector).first;
    await tester.tap(header);
    await tester.pumpAndSettle();
    await tester.tap(header);
    await tester.pumpAndSettle();
    expect(log, equals([true, false]));
  });

  testWidgets(
      'initiallyExpanded=true fires onExpansionChanged on first collapse',
      (tester) async {
    bool? result;
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      initiallyExpanded: true,
      onExpansionChanged: (v) => result = v,
    )));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pumpAndSettle();
    expect(result, isFalse);
  });

  testWidgets('tapping hint text area also expands', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
    )));
    await tester.tap(find.text('Pick one'));
    await tester.pumpAndSettle();
    expect(find.text('Apple').hitTestable(), findsOneWidget);
  });
}
