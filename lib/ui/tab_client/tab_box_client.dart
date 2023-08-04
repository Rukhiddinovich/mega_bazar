import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mega_bazar/ui/tab_client/category_client/category_screen_client.dart';
import 'package:mega_bazar/ui/tab_client/product_client/product_screen_client.dart';
import 'package:mega_bazar/ui/tab_client/profile_client/profile_screen_client.dart';
import 'package:mega_bazar/util/colors.dart';
import 'package:mega_bazar/util/icons.dart';

class TabBoxClient extends StatefulWidget {
  const TabBoxClient({super.key});

  @override
  State<TabBoxClient> createState() => _TabBoxClientState();
}

class _TabBoxClientState extends State<TabBoxClient> {
  List<Widget> screens = [];

  int currentIndex = 0;

  @override
  void initState() {
    screens = [
      const ProductScreenClient(),
      const CategoryScreenClient(),
      const ProfileScreenClient(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: AppColors.C_40BFFF,
        buttonBackgroundColor: AppColors.C_40BFFF,
        height: 60.h,
        items: <Widget>[
          SvgPicture.asset(AppImages.home, color: Colors.white),
          SvgPicture.asset(AppImages.shopActive, color: Colors.white),
          SvgPicture.asset(AppImages.profileActive, color: Colors.white),
        ],
        onTap: (index) {
          setState(
            () {
              currentIndex = index;
            },
          );
        },
      ),
    );
  }
}
