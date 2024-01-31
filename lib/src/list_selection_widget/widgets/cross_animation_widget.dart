import '../package.dart';

class CrossAnimationWidget extends StatefulWidget {
  @override
  final Key? key;
  const CrossAnimationWidget({
    required this.child,
    this.key,
  }) : super(key: key);

  final Widget child;

  @override
  State<CrossAnimationWidget> createState() => _CrossAnimationWidgetState();
}

class _CrossAnimationWidgetState extends State<CrossAnimationWidget> {
  final _globalState = GlobalState();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _globalState.expansionStream,
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
