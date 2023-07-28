import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mega_bazar/app/app.dart';
import 'package:mega_bazar/util/colors.dart';
import 'package:mega_bazar/util/icons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(const Duration(seconds: 3));

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const App();
          },
        ),
      );
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.C_40BFFF,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.logo1,width: 100.w,height: 100.h),
            SizedBox(height: 10.h),
            Text(
              "Welcome to Mega Bazar",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                  fontSize: 24.sp,
                  color: Colors.white),
            ),
            // Lottie.asset(AppImages.splash)
          ],
        ),
      ),
    );
  }
}
