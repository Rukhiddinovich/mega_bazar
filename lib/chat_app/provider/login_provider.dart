import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mega_bazar/ui/auth/sign_login/signup_page.dart';
import 'package:mega_bazar/ui/tab_client/tab_box_client.dart';

import '../../ui/tab_admin/tab_box_admin.dart';
import '../../util/ui_utils/error_message.dart';
import '../../util/ui_utils/loading_dialog.dart';

class LoginProvider with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  bool obscureText = true;
  bool obscureText1 = true;
  User? user = FirebaseAuth.instance.currentUser;

  clear() {
    emailController.clear();
    passwordController.clear();
    repeatPasswordController.clear();
    notifyListeners();
  }

  Stream<User?> listenAuthState() => FirebaseAuth.instance.authStateChanges();

  Future<void> createUser(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    try {
      showLoading(context: context);
      if (password == repeatPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (context.mounted) {
          showErrorMessage(
              message: "User created successfully! ", context: context);
        }
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpPage(onChanged: () {}),
              ),
              (route) => false);
        }
        clear();
      } else {
        showErrorMessage(
            message: "Both passwords must be the same!", context: context);
      }
      hideLoading(dialogContext: context);
    } on FirebaseAuthException catch (e) {
      showErrorMessage(message: e.code.toString(), context: context);
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (error) {
      showErrorMessage(message: error.toString(), context: context);
    }
  }

  Future<void> login(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    try {
      showLoading(context: context);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (context.mounted) {
        hideLoading(dialogContext: context);
        if (email == "admin123@mail.ru") {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const TabBoxAdmin(),
              ),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const TabBoxClient(),
              ),
              (route) => false);
        }
        showConfirmMessage(
            message: "Logged in successfully! ", context: context);

        clear();
      }
    } on FirebaseAuthException catch (e) {
      showErrorMessage(message: e.code.toString(), context: context);
    } catch (error) {
      showErrorMessage(message: error.toString(), context: context);
    }
  }

  Future<void> logOut(BuildContext context) async {
    try {
      showLoading(context: context);
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        hideLoading(dialogContext: context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SignUpPage(
                onChanged: () {},
              ),
            ),
            (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      showErrorMessage(message: e.code.toString(), context: context);
    } catch (error) {
      showErrorMessage(message: error.toString(), context: context);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      showLoading(context: context);
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      hideLoading(dialogContext: context);
    } on FirebaseAuthException catch (e) {
      showErrorMessage(message: e.code.toString(), context: context);
    } catch (error) {
      showErrorMessage(message: error.toString(), context: context);
    }
  }

  obs1() {
    obscureText = !obscureText;
    notifyListeners();
  }

  obs2() {
    obscureText1 = !obscureText1;
    notifyListeners();
  }
}
