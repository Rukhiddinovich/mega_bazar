import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mega_bazar/ui/tab/products/products_screen.dart';
import 'package:mega_bazar/ui/tab/profile/profile_screen.dart';
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
      ProductsScreen(),
      CategoriesScreen(),
      ProfileScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppImages.home), label: "Home"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppImages.shop), label: "Shop"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppImages.profile), label: "Profile"),
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
