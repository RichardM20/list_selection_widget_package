import '../../services/provider.dart';
import '../package.dart';

class ListSelectionWidgetTitleContent extends StatefulWidget {
  final String selected;
  final EdgeInsets? titleContentPadding;
  final Widget? icon;
  final Color? collapsedIconColor;
  final Color? expandedIconColor;
  final TextStyle? titleStyle;

  const ListSelectionWidgetTitleContent({
    super.key,
    required this.selected,
    this.titleContentPadding,
    this.icon,
    this.titleStyle,
    this.collapsedIconColor,
    this.expandedIconColor,
  });

  @override
  State<ListSelectionWidgetTitleContent> createState() =>
      _ListSelectionWidgetTitleContentState();
}

class _ListSelectionWidgetTitleContentState
    extends State<ListSelectionWidgetTitleContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _animation = Tween<double>(begin: 0, end: 0.25).animate(_controller);
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
            color: isExpanded
                ? widget.expandedIconColor ?? Colors.blue
                : widget.collapsedIconColor ?? Colors.grey,
          ),
    );
  }

  void onTap() {
    if (isExpanded == true) {
      setState(() {
        _controller.reverse();
        isExpanded = false;
        Provider.of(context)!.toggleExpansion(false);
      });
    } else {
      setState(() {
        _controller.forward();
        isExpanded = true;
        Provider.of(context)!.toggleExpansion(true);
      });
    }
  }
}
