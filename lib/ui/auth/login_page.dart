import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mega_bazar/providers/auth_provider.dart';
import 'package:mega_bazar/ui/auth/signup_page.dart';
import 'package:mega_bazar/ui/auth/widgets/global_text_fields.dart';
import 'package:mega_bazar/util/icons.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../util/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                Lottie.asset(AppImages.lottie, height: 250.h),
                Text(
                  "Let's Get Started",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: "Poppins",
                      fontSize: 16.sp,
                      color: AppColors.C_223263),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Create an new account",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontSize: 12.sp,
                      color: AppColors.C_9098B1),
                ),
                SizedBox(height: 28.h),
                GlobalTextField(
                    hintText: "Full Name",
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                    controller: context.read<AuthProvider>().userNameController),
                SizedBox(height: 8.h),
                GlobalTextField(
                    hintText: "Your email",
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.start,
                    controller:
                        context.read<AuthProvider>().emailController),
                SizedBox(height: 8.h),
                GlobalTextField(
                    hintText: "Password",
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.start,
                    controller:
                        context.read<AuthProvider>().passwordController),
                SizedBox(height: 16.h),
                ZoomTapAnimation(
                  onTap: () {
                    context.read<AuthProvider>().logInUser(context);
                  },
                  child: Container(
                    width: 343.w,
                    height: 57.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: AppColors.C_40BFFF),
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have a account? ",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.C_9098B1),
                    ),
                    ZoomTapAnimation(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const SignUpPage();
                        }));
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.C_40BFFF),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
