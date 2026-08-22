import 'package:flutter_test/flutter_test.dart';
import 'package:list_selection_widget/list_selection_widget.dart';

import '../helpers.dart';

void main() {
  testWidgets('selectedTitleBuilder overrides header text', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: fruits[0],
      onSingleItemSelected: (_) {},
      selectedTitleBuilder: (items) => 'Custom: ${items.length}',
    )));
    await tester.pump();
    expect(find.text('Custom: 1'), findsOneWidget);
  });

  testWidgets('selectedTitleBuilder with null shows Custom: 0', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      selectedTitleBuilder: (items) => 'Custom: ${items.length}',
    )));
    await tester.pump();
    expect(find.text('Custom: 0'), findsOneWidget);
  });

  testWidgets('itemBuilder replaces default row widget', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      initiallyExpanded: true,
      itemBuilder: (ctx, item, isSelected) =>
          Text('CUSTOM:${item.label}:$isSelected'),
    )));
    await tester.pumpAndSettle();
    expect(find.text('CUSTOM:Apple:false'), findsOneWidget);
    expect(find.text('CUSTOM:Banana:false'), findsOneWidget);
  });

  testWidgets('itemBuilder receives isSelected=true for selected item',
      (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: fruits[0],
      onSingleItemSelected: (_) {},
      initiallyExpanded: true,
      itemBuilder: (ctx, item, isSelected) => Text('${item.label}:$isSelected'),
    )));
    await tester.pumpAndSettle();
    expect(find.text('Apple:true'), findsOneWidget);
    expect(find.text('Banana:false'), findsOneWidget);
  });
}
