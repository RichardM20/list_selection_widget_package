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
    SelectionItem(value: 'item1', label: 'Flutter'),
    SelectionItem(value: 'item2', label: 'React Native'),
    SelectionItem(value: 'item3', label: 'Swift'),
    SelectionItem(value: 'item4', label: 'Kotlin'),
  ];

  SelectionItem<String>? _selectedItem =
      const SelectionItem(value: 'item1', label: 'Flutter');
  SelectionItem<String>? _customItem;
  List<SelectionItem<String>> _multiSelectedItems = [];
  bool _isMultiExpanded = true;

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Single selection'),
              const SizedBox(height: 8),
              ListSelectionWidget<String>.single(
                hideLines: true,
                hintText: 'Select an item',
                listItems: _listItems,
                selectedValue: _selectedItem,
                onSingleItemSelected: _onSingleItemSelected,
                autoCollapsed: true,
                animationDuration: const Duration(milliseconds: 100),
                iconStyle: const IconStyleData(
                  trailingIcon: Icon(Icons.keyboard_arrow_down),
                ),
              ),
              const SizedBox(height: 30),
              Text('Multi selection expanded: $_isMultiExpanded'),
              const SizedBox(height: 8),
              ListSelectionWidget<String>.multi(
                hintText: 'Select multiple items',
                listItems: _listItems,
                multiSelectValues: _multiSelectedItems,
                onMultiItemsSelected: _onMultiItemsSelected,
                initiallyExpanded: true,
                onExpansionChanged: (isExpanded) {
                  setState(() {
                    _isMultiExpanded = isExpanded;
                  });
                },
                selectedTitleBuilder: (items) {
                  if (items.isEmpty) {
                    return 'Select multiple items';
                  }
                  return '${items.length} selected';
                },
              ),
              const SizedBox(height: 30),
              const Text('Custom item rows'),
              const SizedBox(height: 8),
              ListSelectionWidget<String>.single(
                hintText: 'Select a custom item',
                listItems: _listItems,
                selectedValue: _customItem,
                onSingleItemSelected: (item) {
                  setState(() {
                    _customItem = item;
                  });
                },
                iconStyle: const IconStyleData(
                  trailingIcon: Icon(Icons.more_horiz),
                  allowDefaultRotation: false,
                ),
                itemBuilder: (context, item, isSelected) {
                  return Row(
                    children: [
                      Icon(
                        isSelected ? Icons.check_circle : Icons.circle_outlined,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(item.label)),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
