import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomIconAnim extends HookWidget {
  final Function() onPressed;
  final AnimatedIconData icons;
  final Color? colors;
  final double? size;
  const CustomIconAnim({
    super.key,
    required this.icons,
    required this.onPressed,
    this.colors,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 300));
    return IconButton(
      onPressed: () {
        if (animationController.status == AnimationStatus.completed) {
          animationController.reverse();
        } else {
          animationController.forward();
        }
        onPressed();
      },
      icon: AnimatedIcon(
        icon: icons,
        progress: animationController,
        color: colors,
        size: size,
      ),
    );
  }
}
