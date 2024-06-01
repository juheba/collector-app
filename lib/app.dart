import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:collector/auth/auth_service.dart';
import 'package:collector/router/router.dart';
import 'package:collector/theme/m3_bluemine_theme.dart';
import 'package:flutter/material.dart';

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
//                        : const Expanded(child: LoginPageWidget()),
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
