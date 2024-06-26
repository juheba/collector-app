import 'package:collector/page/shared/collector_app_bar.dart';
import 'package:collector/page/shared/user_profile_widget.dart';
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
      appBar: CollectorAppBar(
        userPictureUrl: MockUser.pictureUrl,
        userName: MockUser.name,
        //userPictureUrl: _user?.pictureUrl,
        //userName: _user?.name ?? '',
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Collections',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outlined),
            label: 'Add',
          ),
          NavigationDestination(
            icon: Icon(Icons.view_list_rounded),
            label: 'Items',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
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
