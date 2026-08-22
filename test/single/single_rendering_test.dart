import 'package:flutter_test/flutter_test.dart';
import 'package:list_selection_widget/list_selection_widget.dart';

import '../helpers.dart';

void main() {
  testWidgets('shows hintText when selectedValue is null', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
    )));
    expect(find.text('Pick one'), findsOneWidget);
  });

  testWidgets('shows selectedValue label when provided', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: fruits[1],
      onSingleItemSelected: (_) {},
    )));
    expect(find.text('Banana'), findsWidgets);
    expect(find.text('Pick one'), findsNothing);
  });

  testWidgets('shows Cherry — not the first item Apple', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: fruits[2],
      onSingleItemSelected: (_) {},
    )));
    expect(find.text('Cherry'), findsWidgets);
    expect(find.text('Pick one'), findsNothing);
  });

  testWidgets('shows label even when selectedValue is not in listItems',
      (tester) async {
    const exotic = SelectionItem(value: 99, label: 'Durian');
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: exotic,
      onSingleItemSelected: (_) {},
    )));
    expect(find.text('Durian'), findsWidgets);
  });

  testWidgets('list items are NOT interactable when collapsed', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      initiallyExpanded: false,
    )));
    await tester.pump();
    expect(find.text('Apple').hitTestable(), findsNothing);
    expect(find.text('Banana').hitTestable(), findsNothing);
    expect(find.text('Cherry').hitTestable(), findsNothing);
  });

  testWidgets('list items ARE interactable when initiallyExpanded=true',
      (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    expect(find.text('Apple').hitTestable(), findsOneWidget);
    expect(find.text('Banana').hitTestable(), findsOneWidget);
    expect(find.text('Cherry').hitTestable(), findsOneWidget);
  });

  testWidgets('all listItems labels are rendered in tree', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    for (final item in fruits) {
      expect(find.text(item.label), findsOneWidget);
    }
  });

  testWidgets('renders with empty listItems without crash', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'No options',
      listItems: const [],
      selectedValue: null,
      onSingleItemSelected: (_) {},
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    expect(find.text('No options'), findsOneWidget);
  });

  testWidgets('renders with a single listItem without crash', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: [fruits[0]],
      selectedValue: null,
      onSingleItemSelected: (_) {},
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    expect(find.text('Apple').hitTestable(), findsOneWidget);
  });
}
