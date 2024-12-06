import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:collector/data/persistence/access_user_credentials.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  factory AuthService() => _instance;

  AuthService._internal() {
    auth0 = Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
    auth0Web = Auth0Web(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
  }

  static final AuthService _instance = AuthService._internal();

  late Auth0 auth0;
  late Auth0Web auth0Web;
  late bool isAuthorized = false;

  Future<void> login() async {
    try {
      Credentials credentials;
      if (kIsWeb) {
        return auth0Web.loginWithRedirect(redirectUrl: 'http://localhost:3000/#/callback');
      } else {
        credentials = await auth0.webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME']).login();
        await updateState(credentials);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await AccessUserCredentials().removeUserCredentials();
      if (kIsWeb) {
        await auth0Web.logout(returnToUrl: 'http://localhost:3000');
      } else {
        await auth0.webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME']).logout();
      }
      await updateState(null);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> loadWebCredentials() async {
    if (kIsWeb) {
      try {
        await auth0Web.onLoad().then(updateState);
      } catch (e) {
        debugPrint('Failed to load web credentials: $e');
      }
    }
  }

  Future<void> updateState(Credentials? credentials) async {
    if (credentials != null) {
      // Has credentials -> write them to secret store and set user state.
      isAuthorized = true;
      await AccessUserCredentials().writeUserCredentials(credentials);
      return;
    }
    isAuthorized = await AccessUserCredentials().isUserPresent();
  }
}
