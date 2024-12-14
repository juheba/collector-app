import 'package:collector/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  const ScaffoldWithNavbar(
    this.navigationShell, {
    super.key,
  });

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_filled),
            label: l10n.home_page_title,
          ),
          NavigationDestination(
            icon: const Icon(Icons.grid_view_rounded),
            label: l10n.collections_page_title,
          ),
          NavigationDestination(
            icon: const Icon(Icons.add_circle_outlined),
            label: l10n.new_item_page_title,
          ),
          NavigationDestination(
            icon: const Icon(Icons.view_list_rounded),
            label: l10n.items_page_title,
          ),
          NavigationDestination(
            icon: const Icon(Icons.account_circle),
            label: l10n.user_profile_page_title,
          ),
        ],
      ),
    );
  }

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
