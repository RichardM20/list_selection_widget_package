import 'package:flutter_test/flutter_test.dart';
import 'package:list_selection_widget/list_selection_widget.dart';

import '../helpers.dart';

void main() {
  testWidgets('custom decoration is applied to container', (tester) async {
    const customDecoration = BoxDecoration(color: Colors.red);
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      decoration: customDecoration,
    )));
    await tester.pump();
    final containers = tester.widgetList<Container>(find.byType(Container));
    expect(containers.any((c) => c.decoration == customDecoration), isTrue);
  });

  testWidgets('custom trailingIcon renders custom widget', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      iconStyle: const IconStyleData(
        trailingIcon: Icon(Icons.star, key: Key('custom-icon')),
      ),
    )));
    await tester.pump();
    expect(find.byKey(const Key('custom-icon')), findsOneWidget);
  });

  testWidgets('titleStyle applied to header text', (tester) async {
    const style = TextStyle(color: Colors.purple, fontSize: 20);
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      textStyle: const TextStyleData(titleStyle: style),
    )));
    await tester.pump();
    final hintText = tester.widget<Text>(find.text('Pick one'));
    expect(hintText.style?.color, Colors.purple);
  });

  testWidgets('hideLines=true renders without crash', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      hideLines: true,
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('maxHeight renders without overflow', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      maxHeight: 100,
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('custom paddingData renders without crash', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      paddingData: const PaddingData(
        contentPadding: EdgeInsets.all(20),
        titlePadding: EdgeInsets.symmetric(horizontal: 8),
        itemPadding: EdgeInsets.all(12),
        itemMargin: EdgeInsets.all(4),
      ),
      initiallyExpanded: true,
    )));
    await tester.pumpAndSettle();
    expect(find.text('Pick one'), findsOneWidget);
  });

  testWidgets('allowDefaultRotation=false — AnimatedRotation absent',
      (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      iconStyle: const IconStyleData(allowDefaultRotation: false),
    )));
    await tester.pump();
    expect(find.byType(AnimatedRotation), findsNothing);
  });

  testWidgets('allowDefaultRotation=true (default) — AnimatedRotation present',
      (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
    )));
    await tester.pump();
    expect(find.byType(AnimatedRotation), findsOneWidget);
  });

  testWidgets('selectionCustomIcon renders in list items', (tester) async {
    await tester.pumpWidget(wrap(ListSelectionWidget.single(
      hintText: 'Pick one',
      listItems: fruits,
      selectedValue: null,
      onSingleItemSelected: (_) {},
      initiallyExpanded: true,
      iconStyle: const IconStyleData(
        selectionCustomIcon: Icon(Icons.check, key: Key('sel-icon')),
      ),
    )));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('sel-icon')), findsWidgets);
  });
}
