import 'package:flutter/material.dart';
import 'package:mega_bazar/ui/auth/sign_login/login_page.dart';
import 'package:mega_bazar/ui/auth/sign_login/signup_page.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          isLoginPage
              ? LoginPage(
                  onChanged: () {
                    setState(() {
                      isLoginPage = false;
                    });
                  },
                )
              : SignUpPage(
                  onChanged: () {
                    setState(() {
                      isLoginPage = true;
                    });
                  },
                ),
          Visibility(
            visible: context.watch<AuthProvider>().isLoading,
            child: const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
}
