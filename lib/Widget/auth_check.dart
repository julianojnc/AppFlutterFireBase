import 'package:flutter/material.dart';
import 'package:homepage/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:homepage/pages/login.dart';
import 'package:homepage/pages/homepage.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading)
      return loading();
    else if (auth.usuario == null)
      return telalogin();
    else
      return telahomepage();
  }

  loading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
