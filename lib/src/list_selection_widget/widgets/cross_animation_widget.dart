import '../package.dart';

class CrossAnimationWidget extends StatefulWidget {
  final Widget child;
  final StreamController<bool> stream;
  @override
  final Key? key;
  const CrossAnimationWidget({
    required this.child,
    this.key,
    required this.stream,
  }) : super(key: key);

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
          duration: const Duration(milliseconds: 250),
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
