import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mega_bazar/ui/tab_admin/products_admin/products_screen_admin.dart';
import 'package:mega_bazar/ui/tab_admin/profile_admin/profile_screen_admin.dart';
import 'package:mega_bazar/ui/tab_client/orders_client/orders_screen_client.dart';
import 'package:mega_bazar/util/colors.dart';
import 'categories_admin/categories_screen_admin.dart';

class TabBoxAdmin extends StatefulWidget {
  const TabBoxAdmin({super.key});

  @override
  State<TabBoxAdmin> createState() => _TabBoxAdminState();
}

class _TabBoxAdminState extends State<TabBoxAdmin> {
  List<Widget> screens = [];

  int currentIndex = 0;

  @override
  void initState() {
    screens = [
      const ProductsScreenAdmin(),
      const CategoriesScreenAdmin(),
      const ProfileScreenAmin(),
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
          Icon(Icons.home_filled, color: Colors.white, size: 24.sp),
          Icon(Icons.shopping_bag_rounded, color: Colors.white, size: 24.sp),
          Icon(Icons.person, color: Colors.white, size: 24.sp),
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
