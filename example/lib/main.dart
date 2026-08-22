import 'package:list_selection_widget/list_selection_widget.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListSelectionWidget — Examples',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _items = [
    (
      icon: Icons.looks_one_outlined,
      label: 'Single selection',
      subtitle: 'selectedValue, hintText, hideLines',
      screen: SingleBasicScreen(),
    ),
    (
      icon: Icons.checklist_rounded,
      label: 'Multi selection',
      subtitle: 'Multiple picks, deselect, header counter',
      screen: MultiBasicScreen(),
    ),
    (
      icon: Icons.expand_rounded,
      label: 'initiallyExpanded · autoCollapsed',
      subtitle: 'Expansion and collapse control',
      screen: ExpandCollapseScreen(),
    ),
    (
      icon: Icons.touch_app_rounded,
      label: 'Re-tap selected item',
      subtitle: 'Behavior when tapping the current selection',
      screen: RetapScreen(),
    ),
    (
      icon: Icons.mouse_rounded,
      label: 'Header tap area',
      subtitle: 'onExpansionChanged callback demo',
      screen: HitAreaScreen(),
    ),
    (
      icon: Icons.palette_outlined,
      label: 'IconStyleData',
      subtitle: 'Colors, rotation, custom icons',
      screen: IconStyleScreen(),
    ),
    (
      icon: Icons.text_fields_rounded,
      label: 'TextStyleData',
      subtitle: 'Title, item and selected text styles',
      screen: TextStyleScreen(),
    ),
    (
      icon: Icons.space_bar_rounded,
      label: 'PaddingData',
      subtitle: 'Content, title, item padding & margin',
      screen: PaddingScreen(),
    ),
    (
      icon: Icons.build_circle_outlined,
      label: 'Custom builders',
      subtitle: 'itemBuilder · selectedTitleBuilder',
      screen: BuildersScreen(),
    ),
    (
      icon: Icons.warning_amber_rounded,
      label: 'Edge cases',
      subtitle: 'Empty list · external control · maxHeight',
      screen: EdgeCasesScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListSelectionWidget'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final item = _items[i];
          return Card(
            child: ListTile(
              leading: Icon(item.icon),
              title: Text(item.label),
              subtitle: Text(item.subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => item.screen),
              ),
            ),
          );
        },
      ),
    );
  }
}

final _frameworks = [
  const SelectionItem(value: 'flutter', label: 'Flutter'),
  const SelectionItem(value: 'rn', label: 'React Native'),
  const SelectionItem(value: 'swift', label: 'Swift UI'),
  const SelectionItem(value: 'kotlin', label: 'Kotlin'),
  const SelectionItem(value: 'xamarin', label: 'Xamarin'),
];

Widget _sectionLabel(String text) => Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
      ),
    );

Widget _chip(String label, Color color) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 12)),
    );

class SingleBasicScreen extends StatefulWidget {
  const SingleBasicScreen({super.key});

  @override
  State<SingleBasicScreen> createState() => _SingleBasicScreenState();
}

class _SingleBasicScreenState extends State<SingleBasicScreen> {
  SelectionItem<String>? _selected;
  SelectionItem<String>? _preSelected =
      const SelectionItem(value: 'flutter', label: 'Flutter');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Single selection')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionLabel('No initial value — shows hintText'),
              ListSelectionWidget<String>.single(
                hintText: 'Select a framework',
                listItems: _frameworks,
                selectedValue: _selected,
                onSingleItemSelected: (item) =>
                    setState(() => _selected = item),
              ),
              if (_selected != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _chip('Selected: ${_selected!.label}', Colors.green),
                ),
              _sectionLabel('Pre-selected value (Flutter)'),
              ListSelectionWidget<String>.single(
                hintText: 'Select a framework',
                listItems: _frameworks,
                selectedValue: _preSelected,
                onSingleItemSelected: (item) =>
                    setState(() => _preSelected = item),
                autoCollapsed: true,
              ),
              _sectionLabel('hideLines=true'),
              ListSelectionWidget<String>.single(
                hintText: 'Select a framework',
                listItems: _frameworks,
                selectedValue: null,
                onSingleItemSelected: (_) {},
                hideLines: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MultiBasicScreen extends StatefulWidget {
  const MultiBasicScreen({super.key});

  @override
  State<MultiBasicScreen> createState() => _MultiBasicScreenState();
}

class _MultiBasicScreenState extends State<MultiBasicScreen> {
  List<SelectionItem<String>> _selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multi selection')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionLabel('Default header (comma-separated)'),
              ListSelectionWidget<String>.multi(
                hintText: 'Select frameworks',
                listItems: _frameworks,
                multiSelectValues: _selected,
                onMultiItemsSelected: (items) =>
                    setState(() => _selected = List.from(items)),
                initiallyExpanded: true,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                children:
                    _selected.map((e) => _chip(e.label, Colors.blue)).toList(),
              ),
              _sectionLabel('Custom header — counter'),
              ListSelectionWidget<String>.multi(
                hintText: 'Select frameworks',
                listItems: _frameworks,
                multiSelectValues: _selected,
                onMultiItemsSelected: (items) =>
                    setState(() => _selected = List.from(items)),
                selectedTitleBuilder: (items) => items.isEmpty
                    ? 'None selected'
                    : '${items.length} selected',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpandCollapseScreen extends StatefulWidget {
  const ExpandCollapseScreen({super.key});

  @override
  State<ExpandCollapseScreen> createState() => _ExpandCollapseScreenState();
}

class _ExpandCollapseScreenState extends State<ExpandCollapseScreen> {
  SelectionItem<String>? _a;
  SelectionItem<String>? _b;
  String _log = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('initiallyExpanded · autoCollapsed')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionLabel('initiallyExpanded=true'),
              ListSelectionWidget<String>.single(
                hintText: 'Select a framework',
                listItems: _frameworks,
                selectedValue: null,
                onSingleItemSelected: (_) {},
                initiallyExpanded: true,
              ),
              _sectionLabel('initiallyExpanded=false (default)'),
              ListSelectionWidget<String>.single(
                hintText: 'Select a framework',
                listItems: _frameworks,
                selectedValue: null,
                onSingleItemSelected: (_) {},
                initiallyExpanded: false,
              ),
              _sectionLabel('autoCollapsed=true — closes after selection'),
              ListSelectionWidget<String>.single(
                hintText: 'Select a framework',
                listItems: _frameworks,
                selectedValue: _a,
                onSingleItemSelected: (item) => setState(() => _a = item),
                autoCollapsed: true,
                initiallyExpanded: true,
              ),
              _sectionLabel('autoCollapsed=false — stays open after selection'),
              ListSelectionWidget<String>.single(
                hintText: 'Select a framework',
                listItems: _frameworks,
                selectedValue: _b,
                onSingleItemSelected: (item) => setState(() => _b = item),
                autoCollapsed: false,
                initiallyExpanded: true,
              ),
              _sectionLabel('onExpansionChanged callback'),
              ListSelectionWidget<String>.single(
                hintText: 'Expand / collapse me',
                listItems: _frameworks,
                selectedValue: null,
                onSingleItemSelected: (_) {},
                onExpansionChanged: (v) =>
                    setState(() => _log = 'onExpansionChanged → $v'),
              ),
              if (_log.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _chip(_log, Colors.deepPurple),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class RetapScreen extends StatefulWidget {
  const RetapScreen({super.key});

  @override
  State<RetapScreen> createState() => _RetapScreenState();
}

class _RetapScreenState extends State<RetapScreen> {
  SelectionItem<String>? _selected =
      const SelectionItem(value: 'flutter', label: 'Flutter');
  int _callbackCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Re-tap selected item')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionLabel('Flutter is pre-selected — tap it again'),
            ListSelectionWidget<String>.single(
              hintText: 'Select a framework',
              listItems: _frameworks,
              selectedValue: _selected,
              onSingleItemSelected: (item) => setState(() {
                _selected = item;
                _callbackCount++;
              }),
              autoCollapsed: true,
              initiallyExpanded: true,
            ),
            const SizedBox(height: 16),
            _chip(
              'onSingleItemSelected fired: $_callbackCount times',
              Colors.indigo,
            ),
            const SizedBox(height: 8),
            Text(
              'Current: ${_selected?.label ?? 'none'}',
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class HitAreaScreen extends StatefulWidget {
  const HitAreaScreen({super.key});

  @override
  State<HitAreaScreen> createState() => _HitAreaScreenState();
}

class _HitAreaScreenState extends State<HitAreaScreen> {
  int _taps = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Header tap area')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionLabel('Tap anywhere on the header row'),
            ListSelectionWidget<String>.single(
              hintText: 'Tap anywhere in the header →',
              listItems: _frameworks,
              selectedValue: null,
              onSingleItemSelected: (_) {},
              onExpansionChanged: (_) => setState(() => _taps++),
            ),
            const SizedBox(height: 16),
            _chip('onExpansionChanged fired: $_taps times', Colors.green),
          ],
        ),
      ),
    );
  }
}

class IconStyleScreen extends StatelessWidget {
  const IconStyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IconStyleData')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionLabel('Default (arrow, grey collapsed / blue expanded)'),
              ListSelectionWidget<String>.single(
                hintText: 'Select',
                listItems: _frameworks,
                selectedValue: null,
                onSingleItemSelected: (_) {},
              ),
              _sectionLabel('collapsedIconColor · expandedIconColor'),
              ListSelectionWidget<String>.single(
                hintText: 'Select',
                listItems: _frameworks,
                selectedValue: null,
                onSingleItemSelected: (_) {},
                iconStyle: const IconStyleData(
                  collapsedIconColor: Colors.red,
                  expandedIconColor: Colors.green,
                ),
              ),
              _sectionLabel('Custom trailingIcon'),
              ListSelectionWidget<String>.single(
                hintText: 'Select',
                listItems: _frameworks,
                selectedValue: null,
                onSingleItemSelected: (_) {},
                iconStyle: const IconStyleData(
                  trailingIcon: Icon(Icons.keyboard_arrow_down),
                ),
              ),
              _sectionLabel(
                  'allowDefaultRotation=false — icon does NOT rotate'),
              ListSelectionWidget<String>.single(
                hintText: 'Select',
                listItems: _frameworks,
                selectedValue: null,
                onSingleItemSelected: (_) {},
                iconStyle: const IconStyleData(
                  allowDefaultRotation: false,
                  trailingIcon: Icon(Icons.more_horiz),
                ),
              ),
              _sectionLabel('selectionCustomIcon'),
              ListSelectionWidget<String>.single(
                hintText: 'Select',
                listItems: _frameworks,
                selectedValue: _frameworks[0],
                onSingleItemSelected: (_) {},
                initiallyExpanded: true,
                iconStyle: const IconStyleData(
                  selectionCustomIcon: Icon(Icons.check, color: Colors.green),
                ),
              ),
              _sectionLabel(
                'selectedIconColor · backgroundSelectedIconColor · unselectedIconColor',
              ),
              ListSelectionWidget<String>.single(
                hintText: 'Select',
                listItems: _frameworks,
                selectedValue: _frameworks[0],
                onSingleItemSelected: (_) {},
                initiallyExpanded: true,
                iconStyle: const IconStyleData(
                  selectedIconColor: Colors.white,
                  backgroundSelectedIconColor: Colors.deepPurple,
                  unselectedIconColor: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextStyleScreen extends StatelessWidget {
  const TextStyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TextStyleData')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionLabel('Default styles'),
              ListSelectionWidget<String>.single(
                hintText: 'Select a framework',
                listItems: _frameworks,
                selectedValue: _frameworks[0],
                onSingleItemSelected: (_) {},
                initiallyExpanded: true,
              ),
              _sectionLabel('titleStyle'),
              ListSelectionWidget<String>.single(
                hintText: 'Select a framework',
                listItems: _frameworks,
                selectedValue: _frameworks[0],
                onSingleItemSelected: (_) {},
                textStyle: const TextStyleData(
                  titleStyle: TextStyle(
                    color: Colors.purple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _sectionLabel('itemTextStyle + selectedItemTextStyle'),
              ListSelectionWidget<String>.single(
                hintText: 'Select a framework',
                listItems: _frameworks,
                selectedValue: _frameworks[1],
                onSingleItemSelected: (_) {},
                initiallyExpanded: true,
                textStyle: const TextStyleData(
                  itemTextStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  selectedItemTextStyle: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaddingScreen extends StatelessWidget {
  const PaddingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PaddingData')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionLabel('Default padding'),
              ListSelectionWidget<String>.single(
                hintText: 'Select',
                listItems: _frameworks,
                selectedValue: null,
                onSingleItemSelected: (_) {},
                initiallyExpanded: true,
              ),
              _sectionLabel('contentPadding + titlePadding'),
              ListSelectionWidget<String>.single(
                hintText: 'Select',
                listItems: _frameworks,
                selectedValue: null,
                onSingleItemSelected: (_) {},
                initiallyExpanded: true,
                paddingData: const PaddingData(
                  contentPadding: EdgeInsets.all(24),
                  titlePadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              _sectionLabel('itemPadding + itemMargin'),
              ListSelectionWidget<String>.single(
                hintText: 'Select',
                listItems: _frameworks,
                selectedValue: null,
                onSingleItemSelected: (_) {},
                initiallyExpanded: true,
                paddingData: const PaddingData(
                  itemPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  itemMargin: EdgeInsets.symmetric(vertical: 4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildersScreen extends StatefulWidget {
  const BuildersScreen({super.key});

  @override
  State<BuildersScreen> createState() => _BuildersScreenState();
}

class _BuildersScreenState extends State<BuildersScreen> {
  SelectionItem<String>? _singleSelected;
  List<SelectionItem<String>> _multiSelected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom builders')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionLabel('itemBuilder — custom row'),
              ListSelectionWidget<String>.single(
                hintText: 'Select a framework',
                listItems: _frameworks,
                selectedValue: _singleSelected,
                onSingleItemSelected: (item) =>
                    setState(() => _singleSelected = item),
                initiallyExpanded: true,
                iconStyle: const IconStyleData(
                  trailingIcon: Icon(Icons.more_horiz),
                  allowDefaultRotation: false,
                ),
                itemBuilder: (ctx, item, isSelected) => Row(
                  children: [
                    Icon(
                      isSelected
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: isSelected ? Colors.deepPurple : Colors.grey,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item.label,
                        style: TextStyle(
                          color:
                              isSelected ? Colors.deepPurple : Colors.black87,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                  ],
                ),
              ),
              _sectionLabel('selectedTitleBuilder — count'),
              ListSelectionWidget<String>.multi(
                hintText: 'Select frameworks',
                listItems: _frameworks,
                multiSelectValues: _multiSelected,
                onMultiItemsSelected: (items) =>
                    setState(() => _multiSelected = List.from(items)),
                initiallyExpanded: true,
                selectedTitleBuilder: (items) => items.isEmpty
                    ? 'Nothing selected'
                    : '${items.length} of ${_frameworks.length} selected',
              ),
              _sectionLabel('selectedTitleBuilder — concatenated labels'),
              ListSelectionWidget<String>.multi(
                hintText: 'Pick frameworks',
                listItems: _frameworks,
                multiSelectValues: _multiSelected,
                onMultiItemsSelected: (items) =>
                    setState(() => _multiSelected = List.from(items)),
                selectedTitleBuilder: (items) => items.isEmpty
                    ? 'Pick frameworks'
                    : items.map((e) => e.label).join(' · '),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EdgeCasesScreen extends StatefulWidget {
  const EdgeCasesScreen({super.key});

  @override
  State<EdgeCasesScreen> createState() => _EdgeCasesScreenState();
}

class _EdgeCasesScreenState extends State<EdgeCasesScreen> {
  SelectionItem<String>? _external =
      const SelectionItem(value: 'rn', label: 'React Native');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edge cases')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionLabel('Empty listItems'),
              ListSelectionWidget<String>.single(
                hintText: 'No options available',
                listItems: const [],
                selectedValue: null,
                onSingleItemSelected: (_) {},
                initiallyExpanded: true,
              ),
              _sectionLabel('selectedValue not in listItems — still shown'),
              ListSelectionWidget<String>.single(
                hintText: 'Select',
                listItems: _frameworks,
                selectedValue: const SelectionItem(
                  value: 'unknown',
                  label: 'Unknown framework',
                ),
                onSingleItemSelected: (_) {},
              ),
              _sectionLabel('maxHeight=120 — scrollable list'),
              ListSelectionWidget<String>.single(
                hintText: 'Select',
                listItems: _frameworks,
                selectedValue: null,
                onSingleItemSelected: (_) {},
                initiallyExpanded: true,
                maxHeight: 120,
              ),
              _sectionLabel('Externally controlled value'),
              ListSelectionWidget<String>.single(
                hintText: 'Controlled externally',
                listItems: _frameworks,
                selectedValue: _external,
                onSingleItemSelected: (item) =>
                    setState(() => _external = item),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ..._frameworks.map(
                    (f) => ActionChip(
                      label: Text(f.label),
                      onPressed: () => setState(() => _external = f),
                    ),
                  ),
                  ActionChip(
                    label: const Text('Clear'),
                    onPressed: () => setState(() => _external = null),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _chip(
                'Current: ${_external?.label ?? 'null'}',
                Colors.deepPurple,
              ),
              _sectionLabel('Custom decoration'),
              ListSelectionWidget<String>.single(
                hintText: 'Select',
                listItems: _frameworks,
                selectedValue: null,
                onSingleItemSelected: (_) {},
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEDE7F6), Color(0xFFD1C4E9)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF9575CD)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
