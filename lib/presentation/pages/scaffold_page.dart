import 'package:collector/presentation/pages/shared/collector_app_bar.dart';
import 'package:flutter/material.dart';

class ScaffoldPage extends StatelessWidget {
  const ScaffoldPage({
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.onNavigateBack,
    this.appBarBackgroundColor,
    this.appBarForegroundColor,
    super.key,
  });

  final String title;
  final Widget body;
  final FloatingActionButton? floatingActionButton;
  final List<Widget>? actions;
  final void Function()? onNavigateBack;

  final Color? appBarBackgroundColor;
  final Color? appBarForegroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CollectorAppBar(
        label: Text(title),
        onNavigateBack: onNavigateBack,
        actions: actions,
        backgroundColor: appBarBackgroundColor,
        foregroundColor: appBarForegroundColor,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
