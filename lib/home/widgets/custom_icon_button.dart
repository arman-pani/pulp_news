
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color? color;
  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        // padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: color ?? Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}