

import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier{

  final TextEditingController passwordController=TextEditingController();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController userNameController=TextEditingController();

  AuthProvider();

  bool isLoading=false;



}