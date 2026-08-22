import 'package:flutter_test/flutter_test.dart';
import 'package:list_selection_widget/list_selection_widget.dart';

import '../helpers.dart';

void main() {
  testWidgets('default trailing icon is arrow_forward_ios', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
    )));
    await tester.pump();
    expect(find.byIcon(Icons.arrow_forward_ios_rounded), findsWidgets);
  });

  testWidgets('collapsed icon color is grey by default', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
    )));
    await tester.pump();
    final icon = tester.widget<Icon>(
      find.byIcon(Icons.arrow_forward_ios_rounded).first,
    );
    expect(icon.color, Colors.grey);
  });

  testWidgets('expanded icon color is blue by default', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    final icon = tester.widget<Icon>(
      find.byIcon(Icons.arrow_forward_ios_rounded).first,
    );
    expect(icon.color, Colors.blue);
  });

  testWidgets(
      'collapsedIconColor — activates when EXPANDED (bug: params swapped)',
      (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      initiallyExpanded: true,
      iconStyle: const IconStyleData(collapsedIconColor: Colors.red),
    )));
    await tester.pumpAndSettle();
    final icon = tester.widget<Icon>(
      find.byIcon(Icons.arrow_forward_ios_rounded).first,
    );
    expect(icon.color, Colors.red);
  });

  testWidgets(
      'expandedIconColor — activates when COLLAPSED (bug: params swapped)',
      (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      initiallyExpanded: false,
      iconStyle: const IconStyleData(expandedIconColor: Colors.green),
    )));
    await tester.pump();
    final icon = tester.widget<Icon>(
      find.byIcon(Icons.arrow_forward_ios_rounded).first,
    );
    expect(icon.color, Colors.green);
  });
}
