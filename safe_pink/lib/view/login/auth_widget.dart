import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_pink/services/auth_service.dart';
import 'package:safe_pink/view/home/home_page.dart';
import 'package:safe_pink/view/login/login_page.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    print('--------------------');
    print(auth.isLoading);
    if (auth.isLoading) {
      return loading();
    } else if (auth.usuario == null) {
      return const LoginPage();
    } else {
      return const MyHomePage();
    }
  }
}
