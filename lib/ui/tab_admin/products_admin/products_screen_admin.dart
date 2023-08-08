import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mega_bazar/providers/product_provider.dart';
import 'package:mega_bazar/ui/tab_admin/categories_admin/sub_screen/category_about_screen.dart';
import 'package:mega_bazar/ui/tab_admin/categories_admin/sub_screen/category_add_screen.dart';
import 'package:mega_bazar/ui/tab_admin/products_admin/widgets/product_add_screen.dart';
import 'package:mega_bazar/ui/tab_admin/products_admin/widgets/product_detail_screen.dart';
import 'package:mega_bazar/util/colors.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../data/model/category/category_model.dart';
import '../../../data/model/product/product_model.dart';
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
          "Product Screen Admin",
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
      body: StreamBuilder<List<ProductModel>>(
        stream: context.read<ProductsProvider>().getProducts(""),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? Expanded(
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.6),
                      children: [
                        ...List.generate(
                          snapshot.data!.length,
                          (index) {
                            ProductModel productModel = snapshot.data![index];
                            return ZoomTapAnimation(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailScreen(
                                              productModel: productModel,
                                              index: index,
                                            )));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.blue.withOpacity(0.8)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Hero(
                                      tag: index,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: CachedNetworkImage(
                                          height: 100.h,
                                          width: 100.h,
                                          imageUrl:
                                              productModel.productImages.first,
                                          placeholder: (context, url) =>
                                              const CupertinoActivityIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          productModel.productName,
                                          style: TextStyle(
                                              fontSize: 22.spMin,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          productModel.description,
                                          style: TextStyle(
                                              fontSize: 18.spMin,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          "Price: ${productModel.price} ${productModel.currency}",
                                          style: TextStyle(
                                              fontSize: 18.spMin,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          "Count: ${productModel.count}",
                                          style: TextStyle(
                                              fontSize: 18.spMin,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
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
          return Center(child: CupertinoActivityIndicator(
            radius: 20.r,
          ),);
        },
      ),
    );
  }
}
