import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:mega_bazar/util/colors.dart';
import '../../../../data/model/category/category_model.dart';
import '../../../../util/icons.dart';

class CategoryAboutScreen extends StatefulWidget {
  const CategoryAboutScreen({super.key, required this.categoryModel, required this.index});
  final CategoryModel categoryModel;
  final int index;

  @override
  State<CategoryAboutScreen> createState() => _CategoryAboutScreenState();
}

class _CategoryAboutScreenState extends State<CategoryAboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.C_40BFFF,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppImages.shop, color: Colors.white),
          )
        ],
      ),
      backgroundColor: AppColors.C_40BFFF,
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Hero(
            tag: widget.index,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              child: Image.file(File(widget.categoryModel.imageUrl),
                  width: 208.w,
                  height: 220.h,
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 48.59.h),
          Stack(
            children: [
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: 30.w),
                width: double.infinity,
                height: 450.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                    color: AppColors.C_262626),
                child: ListView(
                  children: [
                    SizedBox(height: 40.h),
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              widget.categoryModel.categoryName,
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight.w600,
                                  fontFamily: "Poppins",
                                  fontSize: 20.sp,
                                  color: Colors.white),
                            ),
                            const Spacer(),
                            LikeButton(size: 25.r),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Center(
                          child: Text(
                            "Product Details",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                                fontSize: 20.sp,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          widget.categoryModel.description,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                              fontSize: 15.sp,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}
