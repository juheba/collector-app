import 'package:collector/data/access_user_credentials.dart';
import 'package:collector/model/collection_model.dart';
import 'package:collector/page/callback_page.dart';
import 'package:collector/page/collection_detail_page.dart';
import 'package:collector/page/collections_page.dart';
import 'package:collector/page/home_page.dart';
import 'package:collector/page/item_detail_page.dart';
import 'package:collector/page/items_page.dart';
import 'package:collector/page/login_page.dart';
import 'package:collector/page/new_item_page.dart';
import 'package:collector/page/shared/scaffold_nav_bar.dart';
import 'package:collector/page/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// CollectorGoRouter is defined as a Singleton.
class CollectorGoRouter {
  factory CollectorGoRouter() => _instance;

  CollectorGoRouter._internal() {
    _router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/login',
      redirect: (context, state) async {
        final isUserPresent = await AccessUserCredentials().isUserPresent();
        final isLoginPage = state.matchedLocation == '/login';

        if (!isUserPresent && !isLoginPage) {
          return '/login';
        } else if (isUserPresent && isLoginPage) {
          return '/home';
        }
        return null;
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/callback',
          builder: (context, state) => const CallbackPage(),
        ),
        GoRoute(
          path: '/login',
          redirect: (context, state) async {
            final isUserPresent = await AccessUserCredentials().isUserPresent();

            if (isUserPresent) {
              return '/home';
            }
            return null;
          },
          builder: (context, state) => const LoginPageWidget(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            // Return the widget that implements the custom shell (e.g a BottomNavigationBar).
            // The [StatefulNavigationShell] is passed to be able to navigate to other branches in a stateful way.
            return ScaffoldWithNavbar(navigationShell);
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: _sectionNavigatorKey,
              // Add this branch routes
              // each routes with its sub routes if available e.g feed/uuid/details
              routes: <RouteBase>[
                GoRoute(
                  name: 'home', // Optional, add name to your routes. Allows you navigate by name instead of path
                  path: '/home',
                  builder: (context, state) => const HomePageWidget(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: 'collections',
                  path: '/collections',
                  builder: (context, state) => const CollectionsPageWidget(),
                  routes: <RouteBase>[
                    GoRoute(
                      name: 'collection-details',
                      path: ':id/items',
                      builder: (context, state) => CollectionDetailPageWidget(
                        collection: MockCollections.getCollections()[int.parse(state.pathParameters['id']!)],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: 'new-item',
                  path: '/items/new',
                  builder: (context, state) => const NewItemPageWidget(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: 'items',
                  path: '/items',
                  builder: (context, state) => const ItemsPageWidget(),
                  routes: <RouteBase>[
                    GoRoute(
                      name: 'item-details',
                      path: ':id/details',
                      builder: (context, state) => ItemDetailPageWidget(
                        id: state.pathParameters['id']!,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: 'user',
                  path: '/user',
                  builder: (context, state) => const UserPageWidget(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
  late GoRouter _router;
  static final CollectorGoRouter _instance = CollectorGoRouter._internal();

  // Create keys for `root` & `section` navigator avoiding unnecessary rebuilds
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _sectionNavigatorKey = GlobalKey<NavigatorState>();

  GoRouter getRouter() {
    return _router;
  }
}
