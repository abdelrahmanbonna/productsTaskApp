import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class AnimatedBounceable extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Duration duration;
  final Duration delay;
  final double scaleFactor;
  final Curve curve;
  final AnimationType animationType;

  const AnimatedBounceable({
    super.key,
    required this.child,
    this.onTap,
    this.duration = const Duration(milliseconds: 1500),
    this.delay = Duration.zero,
    this.scaleFactor = 0.9,
    this.curve = Curves.easeOut,
    this.animationType = AnimationType.fadeInDown,
  });

  @override
  Widget build(BuildContext context) {
    Widget animatedWidget;

    switch (animationType) {
      case AnimationType.fadeIn:
        animatedWidget = FadeIn(
          duration: duration,
          delay: delay,
          child: child,
        );
      case AnimationType.fadeInDown:
        animatedWidget = FadeInDown(
          duration: duration,
          delay: delay,
          child: child,
        );
      case AnimationType.fadeInUp:
        animatedWidget = FadeInUp(
          duration: duration,
          delay: delay,
          child: child,
        );
      case AnimationType.fadeInLeft:
        animatedWidget = FadeInLeft(
          duration: duration,
          delay: delay,
          child: child,
        );
      case AnimationType.fadeInRight:
        animatedWidget = FadeInRight(
          duration: duration,
          delay: delay,
          child: child,
        );
    }

    return Bounceable(
      onTap: onTap,
      scaleFactor: scaleFactor,
      curve: curve,
      child: animatedWidget,
    );
  }
}

enum AnimationType {
  fadeIn,
  fadeInDown,
  fadeInUp,
  fadeInLeft,
  fadeInRight,
}
