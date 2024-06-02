import 'package:collector/page/collections_page.dart';
import 'package:collector/page/home_page.dart';
import 'package:collector/page/items_page.dart';
import 'package:collector/page/new_item_page.dart';
import 'package:collector/page/user_profile_page.dart';
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
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_filled),
            label: HomePageWidget.pageTitle,
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_rounded),
            label: CollectionsPageWidget.pageTitle,
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outlined),
            label: NewItemPageWidget.pageTitle,
          ),
          NavigationDestination(
            icon: Icon(Icons.view_list_rounded),
            label: ItemsPageWidget.pageTitle,
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle),
            label: UserPageWidget.pageTitle,
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
