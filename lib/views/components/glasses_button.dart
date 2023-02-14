import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class GlassesButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icons;
  const GlassesButton({
    Key? key,
    required this.onTap,
    required this.icons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: GlassContainer(
        height: 60,
        width: 60,
        opacity: .1,
        border: const Border.fromBorderSide(BorderSide.none),
        shape: BoxShape.circle,
        child: Icon(
          icons,
          color: Colors.grey,
        ),
      ),
    );
  }
}
