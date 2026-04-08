import 'package:flutter/material.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const CommonAppbar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
