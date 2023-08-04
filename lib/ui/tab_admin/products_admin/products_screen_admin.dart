import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mega_bazar/ui/tab_admin/categories_admin/sub_screen/category_about_screen.dart';
import 'package:mega_bazar/ui/tab_admin/categories_admin/sub_screen/category_add_screen.dart';
import 'package:mega_bazar/ui/tab_admin/products_admin/widgets/product_add_screen.dart';
import 'package:mega_bazar/util/colors.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../data/model/category/category_model.dart';
import '../../../providers/category_provider.dart';

class ProductsScreenAdmin extends StatefulWidget {
  const ProductsScreenAdmin({super.key});

  @override
  State<ProductsScreenAdmin> createState() => _ProductsScreenAdminState();
}

class _ProductsScreenAdminState extends State<ProductsScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.C_40BFFF,
        title: Text(
          "Category Screen Admin",
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProductAddScreen();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.add_circle_outlined,
              color: Colors.white,
            ),
          ),
        ],
        centerTitle: true,
      ),
      backgroundColor: AppColors.white,
      body: StreamBuilder<List<CategoryModel>>(
        stream: context.read<CategoryProvider>().getCategories(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoryModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView(
              children: List.generate(
                snapshot.data!.length,
                    (index) {
                  CategoryModel categoryModel = snapshot.data![index];
                  return ZoomTapAnimation(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CategoryAboutScreen(
                                categoryModel: categoryModel,
                                index: index);
                          },
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      width: 352.w,
                      height: 150.h,
                      margin: EdgeInsets.symmetric(
                          vertical: 5.h, horizontal: 10.w),
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: Colors.blue, width: 3.w),
                          borderRadius: BorderRadius.circular(15.r),
                          color: AppColors.C_40BFFF),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Hero(
                                    tag: index,
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(16.r),
                                      child: Image.file(
                                        File(categoryModel.imageUrl),
                                        width: 100.w,
                                        height: 120.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 14.w),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        categoryModel.categoryName,
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      SizedBox(height: 5.h),
                                      SizedBox(
                                        width: 150.w,
                                        child: Text(
                                            categoryModel.description,
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 15.sp,
                                                fontWeight:
                                                FontWeight.w500,
                                                color: Colors.white),
                                            maxLines: 4,
                                            overflow:
                                            TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              onPressed: () {
                                context
                                    .read<CategoryProvider>()
                                    .deleteCategory(
                                    context: context,
                                    categoryId:
                                    categoryModel.categoryId);
                              },
                              icon: const Icon(Icons.delete_forever,
                                  color: Colors.red),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CategoryAddScreen(
                                        categoryModel: categoryModel,
                                      );
                                    },
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit,
                                  color: Colors.yellow),
                            ),
                          ),

                        ],
                      ),
                      // child: ListTile(
                      //   onLongPress: () {
                      //     context.read<CategoryProvider>().deleteCategory(
                      //           context: context,
                      //           categoryId: categoryModel.categoryId,
                      //         );
                      //   },
                      //   leading: ClipRRect(
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     child: Image.file(
                      //       File(categoryModel.imageUrl),
                      //       width: 127.w,
                      //       height: 111.h,
                      //     ),
                      //   ),
                      //   title: Text(
                      //     categoryModel.categoryName,
                      //     style: TextStyle(
                      //         fontFamily: "Poppins",
                      //         fontSize: 15.sp,
                      //         fontWeight: FontWeight.w500,
                      //         color: Colors.white),
                      //   ),
                      //   subtitle: Text(
                      //     categoryModel.description,
                      //     style: TextStyle(
                      //         fontFamily: "Poppins",
                      //         fontSize: 15.sp,
                      //         fontWeight: FontWeight.w500,
                      //         color: Colors.white),
                      //   ),
                      //   trailing: IconButton(
                      //     onPressed: () {
                      //     },
                      //     icon: const Icon(Icons.edit, color: Colors.white),
                      //   ),
                      // ),
                    ),
                  );
                },
              ),
            )
                : Center(
              child: Text(
                "Empty!",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
