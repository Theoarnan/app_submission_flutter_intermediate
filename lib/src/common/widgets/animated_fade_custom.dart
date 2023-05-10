import 'package:flutter/material.dart';

class AnimatedFadeCustom extends StatelessWidget {
  final Widget child;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final double opacity;

  const AnimatedFadeCustom(
      {super.key,
      required this.child,
      this.top,
      this.bottom,
      this.left,
      this.right,
      required this.opacity});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: opacity,
        child: child,
      ),
    );
  }
}
