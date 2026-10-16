import 'package:flutter/material.dart';

const tabletBreakpoint = 700.0;

/// Keeps page content readable on wide screens.
class AdaptiveContent extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const AdaptiveContent({super.key, required this.child, this.maxWidth = 800});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}
