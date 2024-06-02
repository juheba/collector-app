import 'package:flutter/material.dart';

class CollectorAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CollectorAppBar({
    required this.label,
    this.onNavigateBack,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    super.key,
  });

  final Widget label;
  final void Function()? onNavigateBack;
  final List<Widget>? actions;

  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: label,
      leading: (onNavigateBack != null)
          ? IconButton(
              onPressed: onNavigateBack,
              icon: Icon(
                Icons.arrow_back,
                color: foregroundColor,
              ),
            )
          : null,
      actions: actions,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
