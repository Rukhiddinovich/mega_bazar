import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:mega_bazar/providers/auth_provider.dart';
import 'package:mega_bazar/ui/auth/sign_login/login_page.dart';
import 'package:mega_bazar/ui/auth/widgets/global_text_fields.dart';
import 'package:mega_bazar/util/icons.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../util/colors.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key, required this.onChanged});

  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Column(
            children: [
              Lottie.asset(AppImages.lottie, height: 250.h),
              Text(
                "Welcome to Mega Bazar",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                    fontSize: 16.sp,
                    color: AppColors.C_223263),
              ),
              SizedBox(height: 8.h),
              Text(
                "Sign in to continue",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins",
                    fontSize: 12.sp,
                    color: AppColors.C_9098B1),
              ),
              SizedBox(height: 28.h),
              GlobalTextField(
                  hintText: "Your email",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  controller: context.read<AuthProvider>().emailController),
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
                      "Sign In",
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 134.w,
                          height: 0.5.h,
                          decoration:
                          const BoxDecoration(color: AppColors.C_EBF0FF),
                        ),
                        SizedBox(width: 28.w),
                        Text(
                          "OR",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              fontFamily: "Poppins",
                              color: AppColors.C_9098B1),
                        ),
                        SizedBox(width: 23.w),
                        Container(
                          width: 134.w,
                          height: 0.5.h,
                          decoration:
                          const BoxDecoration(color: AppColors.C_EBF0FF),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    ZoomTapAnimation(
                      onTap: () {
                        context.read<AuthProvider>().signInWithGoogle(context);
                      },
                      child: Container(
                        height: 57.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.white,
                          border: Border.all(color: AppColors.C_EBF0FF),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 16.w),
                            SvgPicture.asset(AppImages.google,
                                width: 35.w, height: 35.h),
                            SizedBox(width: 60.w),
                            Text(
                              "Login with Google",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.C_9098B1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ZoomTapAnimation(
                      onTap: () {
                        context.read<AuthProvider>().signInWithGoogle(context);
                      },
                      child: Container(
                        height: 57.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.white,
                          border: Border.all(color: AppColors.C_EBF0FF),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 16.w),
                            SvgPicture.asset(AppImages.facebook,
                                width: 35.w, height: 35.h),
                            SizedBox(width: 60.w),
                            Text(
                              "Login with Facebook",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.C_9098B1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp,
                          fontFamily: "Poppins",
                          color: AppColors.C_40BFFF),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have a account? ",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.C_9098B1),
                        ),
                        ZoomTapAnimation(
                          onTap: () {
                            onChanged();
                            context.read<AuthProvider>().loginButtonPressed();
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.C_40BFFF),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
