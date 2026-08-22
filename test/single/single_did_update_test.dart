import 'package:flutter_test/flutter_test.dart';
import 'package:list_selection_widget/list_selection_widget.dart';

import '../helpers.dart';

void main() {
  testWidgets('changing selectedValue externally updates header',
      (tester) async {
    SelectionItem<int>? current;

    Future<void> pump() => tester.pumpWidget(wrap(ListSelectionWidget.single(
          hintText: 'Pick one',
          listItems: fruits,
          selectedValue: current,
          onSingleItemSelected: (_) {},
        )));

    await pump();
    await tester.pump();
    expect(find.text('Pick one'), findsOneWidget);

    current = fruits[2];
    await pump();
    await tester.pump();
    expect(find.text('Cherry'), findsWidgets);
    expect(find.text('Pick one'), findsNothing);
  });

  testWidgets('changing selectedValue to null reverts to hintText',
      (tester) async {
    SelectionItem<int>? current = fruits[0];

    Future<void> pump() => tester.pumpWidget(wrap(ListSelectionWidget.single(
          hintText: 'Pick one',
          listItems: fruits,
          selectedValue: current,
          onSingleItemSelected: (_) {},
        )));

    await pump();
    await tester.pump();
    expect(find.text('Pick one'), findsNothing);

    current = null;
    await pump();
    await tester.pump();
    expect(find.text('Pick one'), findsOneWidget);
  });

  testWidgets('replacing listItems triggers re-sync', (tester) async {
    var items = fruits;

    Future<void> pump() => tester.pumpWidget(wrap(ListSelectionWidget.single(
          hintText: 'Pick one',
          listItems: items,
          selectedValue: null,
          onSingleItemSelected: (_) {},
          initiallyExpanded: true,
        )));

    await pump();
    await tester.pumpAndSettle();
    expect(find.text('Apple').hitTestable(), findsOneWidget);

    items = [const SelectionItem(value: 4, label: 'Dragonfruit')];
    await pump();
    await tester.pumpAndSettle();
    expect(find.text('Dragonfruit').hitTestable(), findsOneWidget);
    expect(find.text('Apple').hitTestable(), findsNothing);
  });
}
