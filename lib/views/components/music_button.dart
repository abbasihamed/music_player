import 'package:flutter/material.dart';

class MusicButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icons;
  final Color? colors;
  final double? size;
  const MusicButton({
    super.key,
    required this.icons,
    required this.onPressed,
    this.colors,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icons,
        color: colors,
        size: size,
      ),
    );
  }
}
