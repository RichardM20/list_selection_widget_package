import '../package.dart';

class CrossAnimationWidget extends StatefulWidget {
  final Widget child;
  final StreamController<bool> stream;

  const CrossAnimationWidget({
    super.key,
    required this.child,
    required this.stream,
  });

  @override
  State<CrossAnimationWidget> createState() => _CrossAnimationWidgetState();
}

class _CrossAnimationWidgetState extends State<CrossAnimationWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.stream.stream,
      builder: (context, snapshot) {
        return AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState: snapshot.data ?? false
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: Container(),
          secondChild: widget.child,
        );
      },
    );
  }
}
