import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:collector/auth/auth_service.dart';
import 'package:collector/generated/l10n.dart';
import 'package:collector/router/router.dart';
import 'package:collector/theme/m3_bluemine_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  const App({this.auth0, super.key});
  final Auth0? auth0;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    AuthService().loadWebCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: m3BluemineLightTheme,
      darkTheme: m3BluemineDarkTheme,
      localizationsDelegates: const [
        L10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.delegate.supportedLocales,
      routerConfig: CollectorGoRouter().getRouter(),
    );
  }
}
