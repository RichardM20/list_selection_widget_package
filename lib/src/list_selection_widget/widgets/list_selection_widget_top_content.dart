import 'package:list_selection_widget/src/list_selection_widget/widgets/icon.dart';

import '../../services/provider.dart';
import '../package.dart';

class ListSelectionWidgetTitleContent extends StatefulWidget {
  final String selected;
  final EdgeInsets? titleContentPadding;
  final IconStyleData? iconStyleData;
  final TextStyle? titleStyle;

  const ListSelectionWidgetTitleContent({
    super.key,
    required this.selected,
    this.titleContentPadding,
    this.iconStyleData,
    this.titleStyle,
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
            _titleContent,
            const SizedBox(width: 24),
            _iconTitleContent,
          ],
        ),
      ),
    );
  }

  EdgeInsets defaulPadding = const EdgeInsets.symmetric(
    horizontal: 4,
    vertical: 4,
  );

  Widget get _titleContent {
    return Expanded(
      child: Text(
        widget.selected,
        style: widget.titleStyle ?? const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget get _icon {
    return IconContent(
      changed: isExpanded,
      defaultColor: widget.iconStyleData?.collapsedIconColor,
      icon: widget.iconStyleData?.tailingIcon,
      undefaultColor: widget.iconStyleData?.expandedIconColor,
    );
  }

  Widget get _iconTitleContent {
    if (widget.iconStyleData == null ||
        widget.iconStyleData!.allowDefaultRotation == true) {
      return RotationTransition(
        turns: _animation,
        child: _icon,
      );
    } else if (widget.iconStyleData != null) {}
    return _icon;
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
