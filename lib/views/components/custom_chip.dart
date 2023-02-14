import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomChip extends HookWidget {
  final String lable;
  final VoidCallback onTap;
  final bool? isSelected;
  const CustomChip({
    super.key,
    required this.lable,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Container(
        width: 100,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: isSelected! ? Colors.white : Colors.grey[800],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(lable),
      ),
    );
  }
}