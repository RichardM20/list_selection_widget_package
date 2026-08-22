import 'package:flutter_test/flutter_test.dart';
import 'package:list_selection_widget/list_selection_widget.dart';

import '../helpers.dart';

void main() {
  testWidgets('changing multiSelectValues externally updates header', (tester) async {
    var selected = <SelectionItem<int>>[];

    Future<void> pump() => tester.pumpWidget(wrap(ListSelectionWidget.multi(
          hintText: 'Pick many',
          listItems: fruits,
          multiSelectValues: selected,
          onMultiItemsSelected: (_) {},
        )));

    await pump();
    await tester.pump();
    expect(find.text('Pick many'), findsOneWidget);

    selected = [fruits[0], fruits[2]];
    await pump();
    await tester.pump();
    expect(find.text('Apple, Cherry'), findsOneWidget);
  });

  testWidgets('clearing multiSelectValues externally reverts to hintText', (tester) async {
    var selected = [fruits[0]];

    Future<void> pump() => tester.pumpWidget(wrap(ListSelectionWidget.multi(
          hintText: 'Pick many',
          listItems: fruits,
          multiSelectValues: selected,
          onMultiItemsSelected: (_) {},
        )));

    await pump();
    await tester.pump();
    expect(find.text('Pick many'), findsNothing);

    selected = [];
    await pump();
    await tester.pump();
    expect(find.text('Pick many'), findsOneWidget);
  });
}
