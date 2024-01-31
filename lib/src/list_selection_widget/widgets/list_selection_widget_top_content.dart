import '../package.dart';

class ListSelectionWidgetTitleContent extends StatefulWidget {
  const ListSelectionWidgetTitleContent({
    super.key,
    required this.selected,
    this.titleContentPadding,
    this.icon,
    this.titleStyle,
  });
  final String selected;
  final EdgeInsets? titleContentPadding;
  final Widget? icon;
  final TextStyle? titleStyle;
  @override
  State<ListSelectionWidgetTitleContent> createState() =>
      _ListSelectionWidgetTitleContentState();
}

class _ListSelectionWidgetTitleContentState
    extends State<ListSelectionWidgetTitleContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final _globalState = GlobalState();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _animation = Tween<double>(begin: 0, end: 0.25).animate(_controller);
    //escucha los cambios de el estream para la animacion del icono
    _globalState.expansionStream.listen((event) {
      if (_globalState.expandedState) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: widget.titleContentPadding ?? defaulPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _titleContent(),
            const SizedBox(width: 24),
            _iconTitleContent(),
          ],
        ),
      ),
    );
  }

  EdgeInsets defaulPadding = const EdgeInsets.symmetric(
    horizontal: 4,
    vertical: 4,
  );

  Widget _titleContent() {
    return Expanded(
      child: Text(
        widget.selected,
        style: widget.titleStyle ?? const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _iconTitleContent() {
    return RotationTransition(
      turns: _animation,
      child: widget.icon ??
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: _globalState.expandedState ? Colors.blue : Colors.grey,
          ),
    );
  }

  void onTap() {
    if (_globalState.expandedState == true) {
      setState(() {
        _globalState.setExpansionState(false);
      });
      _controller.reverse();
    } else {
      _controller.forward();
      setState(() {
        _globalState.setExpansionState(true);
      });
    }
  }
}
