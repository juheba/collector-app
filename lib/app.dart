import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:collector/access_user_credentials.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'constants.dart';
import 'hero.dart';
import 'user.dart';

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
    auth0 = widget.auth0 ??
        Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
    auth0Web =
        Auth0Web(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);

    if (kIsWeb) {
      auth0Web.onLoad().then(
            (final credentials) => setState(() {

              if (credentials != null) {
                AccessUserCredentials().writeUserCredentials(credentials);
                _user = credentials.user;
                _idToken = credentials.idToken;
                return;
              }

              AccessUserCredentials().isUserPresent().then((isPresent) {
                if (isPresent) {
                  AccessUserCredentials().readUserProfile().then((value) => _user = value);
                  AccessUserCredentials().readUserCredentialsIdToken().then((value) => _idToken = value);
                }
                else {
                  _user = null;
                  _idToken = null;
                }
              });
            }),
          );
    }
  }

  Future<void> login() async {
    try {
      if (kIsWeb) {
        return auth0Web.loginWithRedirect(redirectUrl: 'http://localhost:3000');
      }

      Credentials credentials = await auth0
          .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
          .login();
      AccessUserCredentials().writeUserCredentials(credentials);

      setState(() {
        _user = credentials.user;
        _idToken = credentials.idToken;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      if (kIsWeb) {
        await AccessUserCredentials().removeUserCredentials();
        await auth0Web.logout(returnToUrl: 'http://localhost:3000');
      } else {
        await auth0
            .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
            .logout();
        setState(() {
          AccessUserCredentials().removeUserCredentials();
          _user = null;
          _idToken = null;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                            child: UserWidget(
                              user: _user!,
                              idToken: _idToken!,
                            ),
                          )
                        : const Expanded(child: HeroWidget())
                  ],
                ),
              ),
              _user != null
                  ? ElevatedButton(
                      onPressed: logout,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      child: const Text('Logout'),
                    )
                  : ElevatedButton(
                      onPressed: login,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      child: const Text('Login'),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
