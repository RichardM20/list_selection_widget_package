import 'package:flutter/material.dart';

class CrossAnimationWidget extends StatelessWidget {
  final Widget child;
  final bool isExpanded;
  final Duration duration;

  const CrossAnimationWidget({
    super.key,
    required this.child,
    required this.isExpanded,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      curve: Curves.easeInOut,
      tween: Tween<double>(
        begin: isExpanded ? 1 : 0,
        end: isExpanded ? 1 : 0,
      ),
      child: child,
      builder: (context, value, child) {
        return ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: value,
            child: Opacity(
              opacity: value,
              child: IgnorePointer(
                ignoring: !isExpanded,
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
