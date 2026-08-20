import 'package:flutter/material.dart';

import '../../model/models.dart';
import 'icon.dart';

class ListSelectionWidgetTitleContent extends StatelessWidget {
  final String selected;
  final EdgeInsets? titleContentPadding;
  final IconStyleData? iconStyleData;
  final TextStyle? titleStyle;
  final bool isExpanded;
  final Duration animationDuration;
  final VoidCallback onTap;

  const ListSelectionWidgetTitleContent({
    super.key,
    required this.selected,
    required this.isExpanded,
    required this.animationDuration,
    required this.onTap,
    this.titleContentPadding,
    this.iconStyleData,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: titleContentPadding ?? defaultPadding,
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

  EdgeInsets get defaultPadding => const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 4,
      );

  Widget get _titleContent {
    return Expanded(
      child: Text(
        selected,
        style: titleStyle ?? const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget get _icon {
    return IconContent(
      changed: isExpanded,
      defaultColor: iconStyleData?.collapsedIconColor,
      icon: iconStyleData?.trailingIcon,
      undefaultColor: iconStyleData?.expandedIconColor,
    );
  }

  Widget get _iconTitleContent {
    if (iconStyleData == null || iconStyleData!.allowDefaultRotation == true) {
      return AnimatedRotation(
        turns: isExpanded ? 0.25 : 0,
        duration: animationDuration,
        child: _icon,
      );
    }
    return _icon;
  }
}
