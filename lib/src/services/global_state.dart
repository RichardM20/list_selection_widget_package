import '../list_selection_widget/package.dart';

class GlobalState {
  bool _isExpanded = false;
  final StreamController<bool> _expansionController =
      StreamController<bool>.broadcast();

  static final GlobalState _instance = GlobalState._internal();

  GlobalState._internal();

  factory GlobalState() {
    return _instance;
  }

  bool get expandedState => _isExpanded;

  Stream<bool> get expansionStream => _expansionController.stream;

  void setExpansionState(bool newValue) {
    _isExpanded = newValue;
    _expansionController.add(newValue);
  }
}
