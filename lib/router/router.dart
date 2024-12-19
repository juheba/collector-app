import 'package:collector/data/persistence/access_user_credentials.dart';
import 'package:collector/presentation/pages/callback_page.dart';
import 'package:collector/presentation/pages/collections/collection_detail_page.dart';
import 'package:collector/presentation/pages/collections/collections_page.dart';
import 'package:collector/presentation/pages/collections/new_collection_page.dart';
import 'package:collector/presentation/pages/home_page.dart';
import 'package:collector/presentation/pages/items/item_detail_page.dart';
import 'package:collector/presentation/pages/items/items_page.dart';
import 'package:collector/presentation/pages/items/new_item_page.dart';
import 'package:collector/presentation/pages/location/location_detail_page.dart';
import 'package:collector/presentation/pages/location/location_editor_page.dart';
import 'package:collector/presentation/pages/location/locations_page.dart';
import 'package:collector/presentation/pages/login_page.dart';
import 'package:collector/presentation/pages/profile/user_profile_page.dart';
import 'package:collector/presentation/widgets/scaffold_with_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// CollectorGoRouter is defined as a Singleton.
class CollectorGoRouter {
  factory CollectorGoRouter() => _instance;

  CollectorGoRouter._internal() {
    _router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: LoginPageWidget.routePath,
      redirect: (context, state) async {
        final isUserPresent = await AccessUserCredentials().isUserPresent();
        final isLoginPage = state.matchedLocation == LoginPageWidget.routePath;

        if (!isUserPresent && !isLoginPage) {
          return LoginPageWidget.routePath;
        } else if (isUserPresent && isLoginPage) {
          return HomePageWidget.routePath;
        }
        return null;
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/callback',
          builder: (context, state) => const CallbackPage(),
        ),
        GoRoute(
          path: LoginPageWidget.routePath,
          redirect: (context, state) async {
            final isUserPresent = await AccessUserCredentials().isUserPresent();

            if (isUserPresent) {
              return HomePageWidget.routePath;
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
                  name: HomePageWidget.routeName,
                  path: HomePageWidget.routePath,
                  builder: (context, state) => const HomePageWidget(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: CollectionsPageWidget.routeName,
                  path: CollectionsPageWidget.routePath,
                  builder: (context, state) => const CollectionsPageWidget(),
                  routes: <RouteBase>[
                    GoRoute(
                      name: CollectionDetailPageWidget.routeName,
                      path: CollectionDetailPageWidget.routePath,
                      builder: (context, state) => CollectionDetailPageWidget(
                        collectionId: state.pathParameters['id']!,
                      ),
                    ),
                    GoRoute(
                      name: NewCollectionPageWidget.routeName,
                      path: NewCollectionPageWidget.routePath,
                      builder: (context, state) => const NewCollectionPageWidget(),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: ItemsPageWidget.routeName,
                  path: ItemsPageWidget.routePath,
                  builder: (context, state) => const ItemsPageWidget(),
                  routes: <RouteBase>[
                    GoRoute(
                      name: ItemDetailPageWidget.routeName,
                      path: ItemDetailPageWidget.routePath,
                      builder: (context, state) => ItemDetailPageWidget(
                        id: state.pathParameters['id']!,
                      ),
                    ),
                    GoRoute(
                      name: NewItemPageWidget.routeName,
                      path: NewItemPageWidget.routePath,
                      builder: (context, state) => const NewItemPageWidget(),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: LocationsPageWidget.routeName,
                  path: LocationsPageWidget.routePath,
                  builder: (context, state) => const LocationsPageWidget(),
                  routes: <RouteBase>[
                    GoRoute(
                      // Create Location
                      name: LocationEditorPageWidget.routeNameNew,
                      path: LocationEditorPageWidget.routePath,
                      builder: (context, state) => const LocationEditorPageWidget(),
                    ),
                    GoRoute(
                      // Show Location
                      name: LocationDetailPageWidget.routeName,
                      path: LocationDetailPageWidget.routePath,
                      builder: (context, state) => LocationDetailPageWidget(
                        id: state.pathParameters['id']!,
                      ),
                      routes: <RouteBase>[
                        GoRoute(
                          // Edit Location
                          name: LocationEditorPageWidget.routeNameEdit,
                          path: LocationEditorPageWidget.routePath,
                          builder: (context, state) => LocationEditorPageWidget(
                            id: state.pathParameters['id'],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: UserPageWidget.routeName,
                  path: UserPageWidget.routePath,
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
