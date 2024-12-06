import 'package:collector/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CallbackPage extends StatefulWidget {
  const CallbackPage({super.key});

  @override
  _CallbackPageState createState() => _CallbackPageState();
}

class _CallbackPageState extends State<CallbackPage> {
  @override
  void initState() {
    super.initState();
    _handleCallback();
  }

  Future<void> _handleCallback() async {
    final uri = Uri.base;
    final code = uri.queryParameters['code'];
    final returnedState = uri.queryParameters['state'];

    if (code != null && returnedState != null) {
      try {
        await AuthService().auth0Web.onLoad();
        await AuthService().loadWebCredentials();
        context.go('/home');
      } catch (e) {
        context.go('/login');
      }
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
