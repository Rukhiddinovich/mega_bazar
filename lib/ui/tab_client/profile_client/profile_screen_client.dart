import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mega_bazar/ui/auth/widgets/global_text_fields.dart';
import 'package:mega_bazar/util/colors.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/profiles_provider.dart';
import '../../../util/icons.dart';

class ProfileScreenClient extends StatefulWidget {
  const ProfileScreenClient({super.key});

  @override
  State<ProfileScreenClient> createState() => _ProfileScreenClientState();
}

class _ProfileScreenClientState extends State<ProfileScreenClient> {
  @override
  Widget build(BuildContext context) {
    User? user = context.read<ProfileProvider>().currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.C_40BFFF,
        title: Text(
          "Profile Screen Admin",
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthProvider>().logOutUser(context);
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
        centerTitle: true,
      ),
      backgroundColor: AppColors.white,
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Lottie.asset(AppImages.profileScreen,
                    width: 300.w, height: 280.h),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Email: ${user?.email ?? "Empty"}",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Full Name: ${user?.displayName ?? "Empty"}",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Phone Number: ${user?.phoneNumber ?? "Empty"}",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 10.h),
              GlobalTextField(
                  hintText: "Change Email",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  controller: context.read<ProfileProvider>().emailController),
              SizedBox(height: 10.h),
              GlobalTextField(
                  hintText: "Change Full Name",
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  controller: context.read<ProfileProvider>().nameController),
              SizedBox(height: 10.h),
              GlobalTextField(
                  hintText: "Change Phone Number",
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  controller: context.read<ProfileProvider>().phoneController),
              SizedBox(height: 20.h),
              Center(
                child: SizedBox(
                  width: 200.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.C_40BFFF),
                    onPressed: () {
                      context.read<ProfileProvider>().updateEmail(context);
                      context.read<ProfileProvider>().updateUsername(context);
                    },
                    child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            fontFamily: "Poppins",
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
