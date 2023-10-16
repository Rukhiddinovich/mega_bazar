import 'package:caffelito/cubit/tab_box/tab_box_cubit.dart';
import 'package:caffelito/cubit/tab_box/tab_box_state.dart';
import 'package:caffelito/presentation/basket/basket_screen.dart';
import 'package:caffelito/presentation/home/home_screen.dart';
import 'package:caffelito/presentation/profile/profile_screen.dart';
import 'package:caffelito/utils/colors/colors.dart';
import 'package:caffelito/utils/icons/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class TabBox extends StatelessWidget {
  TabBox({super.key});

  List<Widget> pages = [
    const HomeScreen(),
    const BasketScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: context.watch<TabCubit>().state,
        children: pages,
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
          child: BottomNavigationBar(
            backgroundColor: AppColors.phantom,
            elevation: 0,
            currentIndex: context.watch<TabCubit>().state,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: context.read<TabCubit>().changeTab,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.home),
                activeIcon: SvgPicture.asset(AppIcons.home,
                    colorFilter:
                        const ColorFilter.mode(Color(0xFFFDA429), BlendMode.srcIn)),
                label: '•',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.basket),
                activeIcon: SvgPicture.asset(AppIcons.basket,
                    colorFilter:
                        const ColorFilter.mode(Color(0xFFFDA429), BlendMode.srcIn)),
                label: "•",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.profile),
                activeIcon: SvgPicture.asset(AppIcons.profile,
                    colorFilter:
                        const ColorFilter.mode(Color(0xFFFDA429), BlendMode.srcIn)),
                label: '•',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getScreenForTabState(TabState state) {
    switch (state.runtimeType) {
      case InitialTabState:
        return const HomeScreen();
      case CartTabState:
        return const BasketScreen();
      case ProfileTabState:
        return const ProfileScreen();
      default:
        return const Center(child: Text('Unknown Tab'));
    }
  }

  int _currentIndexForTabState(TabState state) {
    if (state is InitialTabState) {
      return 0;
    } else if (state is CartTabState) {
      return 1;
    } else if (state is ProfileTabState) {
      return 2;
    } else {
      return -1;
    }
  }
}
