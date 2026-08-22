import 'package:flutter_test/flutter_test.dart';
import 'package:list_selection_widget/list_selection_widget.dart';

import '../helpers.dart';

void main() {
  testWidgets('height=0 when collapsed', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      initiallyExpanded: false,
    )));
    await tester.pump();
    final size = tester.getSize(find.byType(ClipRect).first);
    expect(size.height, equals(0.0));
  });

  testWidgets('non-zero height when expanded', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    final size = tester.getSize(find.byType(ClipRect).first);
    expect(size.height, greaterThan(0.0));
  });

  testWidgets('IgnorePointer blocks taps when collapsed', (tester) async {
    int count = 0;
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) => count++,
      initiallyExpanded: false,
    )));
    await tester.pump();
    await tester.tap(find.text('Apple'), warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(count, 0);
  });
}
