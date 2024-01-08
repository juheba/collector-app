import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:collector/data/access_user_credentials.dart';
import 'package:collector/router/router.dart';
import 'package:collector/theme/m3_bluemine_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class App extends StatefulWidget {
  final Auth0? auth0;
  const App({this.auth0, super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  UserProfile? _user;
  String? _idToken;

  late Auth0 auth0;
  late Auth0Web auth0Web;

  @override
  void initState() {
    super.initState();
    auth0 = widget.auth0 ?? Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
    auth0Web = Auth0Web(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);

    if (kIsWeb) {
      auth0Web.onLoad().then((final credentials) => updateState(credentials));
    }
  }

  void updateState(Credentials? credentials) {
    if (credentials != null) {
      // Has credentials -> write them to secret store and set user state.
      AccessUserCredentials().writeUserCredentials(credentials);
      setState(() {
        _user = credentials.user;
        _idToken = credentials.idToken;
      });
      return;
    }

    // Try to load credentials.
    AccessUserCredentials().isUserPresent().then((isPresent) {
      if (isPresent) {
        // Has credentials -> read them from secret store and set user state.
        AccessUserCredentials().readUserProfile().then((value) => _user = value);
        AccessUserCredentials().readUserCredentialsIdToken().then((value) => _idToken = value);
      } else {
        // No credentials -> set default state.
        setDefaultState();
      }
    });
  }

  void setDefaultState() {
    setState(() {
      _user = null;
      _idToken = null;
    });
  }

  Future<void> login() async {
    try {
      if (kIsWeb) {
        return auth0Web.loginWithRedirect(redirectUrl: 'http://localhost:3000');
      }
      Credentials credentials = await auth0.webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME']).login();
      updateState(credentials);
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      await AccessUserCredentials().removeUserCredentials();
      if (kIsWeb) {
        await auth0Web.logout(returnToUrl: 'http://localhost:3000');
      } else {
        await auth0.webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME']).logout();
        setDefaultState();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(final BuildContext context) {
    return MaterialApp.router(
      theme: m3BluemineLightTheme,
      darkTheme: m3BluemineDarkTheme,
      //darkTheme: F159DarkTheme.combination1.themeData,
      routerConfig: CollectorGoRouter().getRouter(),
    );
/*      home: Scaffold(
        appBar: CollectorAppBar(
          userPictureUrl: _user?.pictureUrl,
          userName: _user?.name ?? '',
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: padding,
            bottom: padding,
            left: padding / 2,
            right: padding / 2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    _user != null && _idToken != null
                        ? Expanded(
                            child: UserPageWidget(
                              user: _user!,
                              idToken: _idToken!,
                            ),
                          )
//                        : const Expanded(child: HeroPageWidget()),
//                        : const Expanded(child: CollectionsPageWidget()),
                        : const Expanded(child: ItemsPageWidget()),
                  ],
                ),
              ),
              _user != null
                  ? ElevatedButton(
                      onPressed: logout,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      child: const Text('Logout'),
                    )
                  : ElevatedButton(
                      onPressed: login,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      child: const Text('Login'),
                    ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('Button Pressed');
          },
          tooltip: 'Add something',
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: const CollectorNavigationBar(),
      ),
    ); */
  }
}
