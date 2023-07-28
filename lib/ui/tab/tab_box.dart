import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mega_bazar/ui/tab/products/products_screen.dart';
import 'package:mega_bazar/ui/tab/profile/profile_screen.dart';
import 'package:mega_bazar/util/colors.dart';
import 'package:mega_bazar/util/icons.dart';

import 'categories/categories_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [];

  int currentIndex = 0;

  @override
  void initState() {
    screens = [
      const ProductsScreen(),
      const CategoriesScreen(),
      const ProfileScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10.sp,
            fontFamily: "Poppins",
            color: AppColors.white),
        selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
            fontFamily: "Poppins",
            color: AppColors.C_40BFFF),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImages.home),
            label: "Home",
            activeIcon: SvgPicture.asset(AppImages.homeActive),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImages.shop),
            label: "Shop",
            activeIcon: SvgPicture.asset(AppImages.shopActive),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImages.profile),
            label: "Profile",
            activeIcon: SvgPicture.asset(AppImages.profileActive),
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
