import 'package:list_selection_widget/list_selection_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Demo(title: 'List Selection Widget'),
    );
  }
}

class Demo extends StatefulWidget {
  const Demo({super.key, required this.title});

  final String title;

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final List<SelectionItem<String>> _listItems = [
    SelectionItem(value: 'item1', label: 'Item 1'),
    SelectionItem(value: 'item2', label: 'Item 2'),
    SelectionItem(value: 'item3', label: 'Item 3'),
    SelectionItem(value: 'item4', label: 'Item 4'),
  ];

  SelectionItem<String> _selectedItem =
      SelectionItem(value: 'item1', label: 'Item 1');
  List<SelectionItem<String>> _multiSelectedItems = [];

  void _onSingleItemSelected(SelectionItem<String> item) {
    setState(() {
      _selectedItem = item;
    });
  }

  void _onMultiItemsSelected(List<SelectionItem<String>> selectedItems) {
    setState(() {
      _multiSelectedItems = selectedItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListSelectionWidget<String>.single(
              hideLines: true,
              hintText: 'Select an item',
              listItems: _listItems,
              selectedValue: null,
              onSingleItemSelected: _onSingleItemSelected,
            ),
            const SizedBox(height: 30),
            ListSelectionWidget<String>.multi(
              hintText: 'Select multiple items',
              listItems: _listItems,
              multiSelectValues: _multiSelectedItems,
              onMultiItemsSelected: _onMultiItemsSelected,
            ),
          ],
        ),
      ),
    );
  }
}
