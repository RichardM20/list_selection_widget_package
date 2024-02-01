# list_selection_widget
List selection widget is a Flutter package that provides a highly customizable dropdown list to select options with ease
## Preview
![Untitled video - Made with Clipchamp](https://github.com/RichardM20/list_selection_widget_package/assets/64317751/e50f4967-28de-46b5-af18-0d9254547c10)
![image](https://github.com/RichardM20/list_selection_widget_package/assets/64317751/125fb90b-0006-4d0e-8bfb-e596b62dfc63)


## Usage

```dart
import 'package:list_selection_widget/src/list_selection_widget/package.dart';
```

The package can be used to select multiple texts or just one, it depends on what you need at the moment.

For example, let's say you need to select multiple texts from a list of data, to do this we will pass a true value to the **isMultiSelection** property

```dart

ListSelectionWidget(
    isMultiSelection: true, //< -- This property defines whether it will be multiple or single selection
    hintText: 'Selecciona una o mas opciones',
     listItems: List.generate(
       data.length,
       (index) => SelectionItem(
         value: data[index]['valor'],
         displayValue: data[index]['nombre'],
       ),
     ),
     onMultiItemsSelected: (v) { //<- It will always be from the onMultiItemsSelected function
     
     //return a list data
    //output: [data1, data2, data3 ];
    },
);

```
Keep in mind that depending on how isMultiSelection is declared, the function for data assignment will change, since if the wrong one is used an error will be sent.

In this case there are two possibilities with two functions.
We already saw the first, now we will see what the second is.
```dart
ListSelectionWidget(
    isMultiSelection: false //change,
    hintText: 'Selecciona una opcion',
    listItems: List.generate(
      data.length,
      (index) => SelectionItem(
        value: data[index]['valor'],
        displayValue: data[index]['nombre'],
      ),
    ),
    onSingleItemSelected: (v) { //<-- In this case we declare isMultiSelection to false, so the function we will need will be this

      var yourVariable = v; //return a single data
      //output: data1
    },
);

```
That's all for the selection mode, now as you may have noticed, a list is passed with a class object indicating which will be the value that will be seen in the widget and which will be the one that will be returned when selecting it.

```dart
SelectionItem(
    value: data[index]['valueName'], //Value to select 
    displayValue: data[index]['name'], // Value to be seen
),
```
An important property to also consider is **scrollControl** and maxHeight.

These allow you to scroll through the list of data, while maxHeight defines the height of the list container.
```dart
ListSelectionWidget(
    isMultiSelection: false //change,
    scrollControl: true  // We indicate that you can move,
    maxHeight: 80        // we define the height of the content, >30,
    hintText: 'Selecciona una opcion',
    listItems: List.generate(
      data.length,
      (index) => SelectionItem(
        value: data[index]['valor'],
        displayValue: data[index]['nombre'],
      ),
    ),
    onSingleItemSelected: (v) {},
);

```

The widget is currently very customizable, it will have several options to give it the style you prefer the most.

>Interested in collaborating to improve the package are welcome, if you find any errors please let me know so I can fix it as soon as possible

## Full Example
```dart
import 'package:list_selection_widget/src/list_selection_widget/package.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
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
    }
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Selection Widget',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "Example",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
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
                  onMultiItemsSelected: (v) {
                    var yourVariable = v; //return a list data
                    //output: [data1, data2, data3 ];
                  },
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                child: ListSelectionWidget(
                  isMultiSelection: false,
                  hideLines: true,
                  hintText: 'Selecciona una opcion',
                  backgroundSelectedIconColor: Colors.blue,
                  selectedItemTextStyle: const TextStyle(color: Colors.red),
                  selectedIconColor: Colors.red,
                  unSelecctedIconColor: Colors.white,
                  listItems: List.generate(
                    data.length,
                    (index) => SelectionItem(
                      value: data[index]['valor'],
                      displayValue: data[index]['nombre'],
                    ),
                  ),
                  onSingleItemSelected: (v) {
                    var yourVariable = v; //return a single data
                    //output: data1
                  },
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                child: ListSelectionWidget(
                  hideLines: true,
                  scrollControl: true,
                  maxHeight: 80,
                  itemTextStyle: const TextStyle(color: Colors.white),
                  collapsedIconColor: Colors.white,
                  expandedIconColor: Colors.amber,
                  selectedIconColor: Colors.amber,
                  decoration: BoxDecoration(
                    color: Colors.blue,
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
      ),
    );
  }
}

```
