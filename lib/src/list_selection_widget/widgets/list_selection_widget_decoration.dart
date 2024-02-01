import '../package.dart';

// ignore: must_be_immutable
class ListSelectionWidgetDecoration extends StatelessWidget {
  final Widget child;
  final EdgeInsets? paddingContent;
  final Decoration? decoration;

  const ListSelectionWidgetDecoration({
    super.key,
    required this.child,
    this.paddingContent,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    EdgeInsets defaultPadding = const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 8,
    );
    Decoration defaultDecoration = BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          blurRadius: 1,
          spreadRadius: 0,
          color: Colors.grey.shade400.withOpacity(0.6),
        ),
      ],
      borderRadius: BorderRadius.circular(4),
    );
    return Container(
      width: double.infinity,
      decoration: decoration ?? defaultDecoration,
      padding: paddingContent ?? defaultPadding,
      child: child,
    );
  }
}
