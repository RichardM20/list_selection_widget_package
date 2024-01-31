import 'package:dd_list_widget/list_selection_widget.dart';
import 'package:dd_list_widget/src/model/item_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Selection Widget',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ListSelectionWidgetExample(title: 'List Selection Widget'),
    );
  }
}

class ListSelectionWidgetExample extends StatefulWidget {
  const ListSelectionWidgetExample({super.key, required this.title});

  final String title;

  @override
  State<ListSelectionWidgetExample> createState() =>
      _ListSelectionWidgetExampleState();
}

class _ListSelectionWidgetExampleState
    extends State<ListSelectionWidgetExample> {
  List data = [
    {
      "nombre": "FLutter",
      "valor": 0,
    },
    {
      "nombre": "React Native",
      "valor": 1,
    },
    {
      "nombre": "Python",
      "valor": 'python',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 50),
            SizedBox(
              child: ListSelectionWidget(
                isMultiSelection: true,
                hintText: 'Selecciona una o mas opciones',
                listItems: List.generate(
                  data.length,
                  (index) => SelectionItem(
                    value: data[index]['valor'],
                    displayValue: data[index]['nombre'],
                  ),
                ),
                onMultiItemsSelected: (v) {},
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              child: ListSelectionWidget(
                isMultiSelection: false,
                hintText: 'Selecciona una opcion',
                listItems: List.generate(
                  data.length,
                  (index) => SelectionItem(
                    value: data[index]['valor'],
                    displayValue: data[index]['nombre'],
                  ),
                ),
                onSingleItemSelected: (v) {},
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              child: ListSelectionWidget(
                hideLines: true,
                scrollControl: true,
                maxHeight: 50,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                titleStyle: const TextStyle(color: Colors.white),
                isMultiSelection: false,
                hintText: 'Selecciona una opcion',
                listItems: List.generate(
                  data.length,
                  (index) => SelectionItem(
                    value: data[index]['valor'],
                    displayValue: data[index]['nombre'],
                  ),
                ),
                onSingleItemSelected: (v) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
