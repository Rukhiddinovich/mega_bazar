import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffelito/bloc/coffee/coffee_bloc.dart';
import 'package:caffelito/bloc/coffee/coffee_state.dart';
import 'package:caffelito/data/models/coffee/coffee_model.dart';
import 'package:caffelito/utils/colors/colors.dart';
import 'package:caffelito/utils/icons/icons.dart';
import 'package:caffelito/utils/size/size_extension.dart';
import 'package:caffelito/utils/ui_utils/shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.phantom,
      ),
      body: BlocConsumer<CoffeeBloc, CoffeeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              Stack(
                children: [
                  Image.asset(AppIcons.topBar,
                      fit: BoxFit.cover, width: double.infinity),
                  ListTile(
                    leading: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.list_bullet_below_rectangle,
                        color: Colors.white,
                        size: 30.r,
                      ),
                    ),
                    trailing:
                        Image.asset(AppIcons.human, width: 44.w, height: 44.h),
                  ),
                ],
              ),
              Expanded(
                child: GridView(
                  padding: EdgeInsets.all(18.r),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.65,
                  ),
                  children: [
                    ...List.generate(
                      state.coffeeModel.length,
                      (index) {
                        CoffeeModel coffeeModel = state.coffeeModel[index];
                        return ZoomTapAnimation(
                          onTap: () {},
                          child: Container(
                            width: 155.w,
                            height: 230.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.grey),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: index,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16)),
                                    child: CachedNetworkImage(
                                      height: 172.h,
                                      width: 175.w,
                                      fit: BoxFit.fill,
                                      imageUrl: coffeeModel.coffeeImage.toString(),
                                      placeholder: (context, url) =>
                                          const ShimmerPhoto(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                5.ph,
                                Text(
                                  coffeeModel.coffeeName,
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 22.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                10.ph,
                                Text(
                                  "Price: ${coffeeModel.price} So'm",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                13.ph,
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
