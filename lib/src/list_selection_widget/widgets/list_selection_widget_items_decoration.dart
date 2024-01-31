import '../package.dart';

class MultiSelectedWidgetItemDecoration extends StatelessWidget {
  const MultiSelectedWidgetItemDecoration({
    super.key,
    this.hideLines,
    this.child,
    this.itemMargin,
    this.itemPadding,
  });
  final bool? hideLines;
  final Widget? child;
  final EdgeInsetsGeometry? itemMargin;
  final EdgeInsetsGeometry? itemPadding;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: itemMargin ?? EdgeInsets.zero,
      padding: itemPadding ??
          const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 8,
          ),
      decoration: BoxDecoration(
        border: hideLines == true
            ? null
            : BorderDirectional(
                top: BorderSide(
                  color: Colors.grey.shade300,
                  width: 0.5,
                ),
              ),
      ),
      child: child ?? Container(),
    );
  }
}
