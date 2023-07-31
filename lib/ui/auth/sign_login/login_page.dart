import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mega_bazar/providers/auth_provider.dart';
import 'package:mega_bazar/ui/auth/widgets/global_text_fields.dart';
import 'package:mega_bazar/util/icons.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../util/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onChanged});

  final VoidCallback onChanged;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  controller: context.read<AuthProvider>().userNameController),
              SizedBox(height: 8.h),
              GlobalTextField(
                  hintText: "Your email",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  controller: context.read<AuthProvider>().emailController),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: TextInputType.visiblePassword ==
                      TextInputType.visiblePassword
                      ? !isVisible
                      : false,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle:TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.C_9098B1,
                        fontFamily: "Poppins"),
                    suffixIcon: TextInputType.visiblePassword ==
                            TextInputType.visiblePassword
                        ? IconButton(
                            splashRadius: 1,
                            icon: Icon(
                              isVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                          )
                        : null,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.r),
                      borderSide: BorderSide(width: 1.w, color: AppColors.C_40BFFF),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.r),
                      borderSide: BorderSide(
                        width: 1.w,
                        color: AppColors.C_40BFFF,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.r),
                      borderSide: BorderSide(
                        width: 1.w,
                        color: Colors.green,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.r),
                      borderSide: BorderSide(
                        width: 1.w,
                        color: Colors.red,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.r),
                      borderSide: BorderSide(
                        width: 1.w,
                        color: AppColors.C_40BFFF,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              ZoomTapAnimation(
                onTap: () {
                  context.read<AuthProvider>().signUpUser(context);
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
                      widget.onChanged.call();
                      context.read<AuthProvider>().signUpButtonPressed();
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
    );
  }
}
