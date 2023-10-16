import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mega_bazar/util/colors.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data/model/category/category_model.dart';
import '../../../data/model/product/product_model.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/product_provider.dart';
import '../../../util/icons.dart';
import '../../tab_admin/products_admin/widgets/product_detail_screen.dart';

class ProductScreenClient extends StatefulWidget {
  const ProductScreenClient({super.key});

  @override
  State<ProductScreenClient> createState() => _ProductScreenClientState();
}

class _ProductScreenClientState extends State<ProductScreenClient> {
  String selectedCategoryId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.C_40BFFF,
        title: Text(
          "Products Client",
          style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
              fontSize: 24.sp,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 60.h,
            child: Expanded(
              child: ListView(
                children: [
                  StreamBuilder<List<CategoryModel>>(
                    stream: context.read<CategoryProvider>().getCategories(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<CategoryModel>> snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!.isNotEmpty
                            ? SizedBox(
                                height: 60.h,
                                width: MediaQuery.of(context).size.width,
                                child: Expanded(
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedCategoryId = "";
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            color: selectedCategoryId == ""
                                                ? Colors.yellow
                                                : AppColors.C_40BFFF,
                                          ),
                                          height: 60.h,
                                          margin: EdgeInsets.all(5.r),
                                          padding: EdgeInsets.all(10.r),
                                          child: Center(
                                            child: Text(
                                              "All",
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins",
                                                color: selectedCategoryId == ""
                                                    ? Colors.red
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ...List.generate(
                                        snapshot.data!.length,
                                        (index) {
                                          CategoryModel categoryModel =
                                              snapshot.data![index];
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedCategoryId =
                                                    categoryModel.categoryId;
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                color: selectedCategoryId ==
                                                        categoryModel.categoryId
                                                    ? Colors.yellow
                                                    : AppColors.C_40BFFF,
                                              ),
                                              height: 60.h,
                                              margin: EdgeInsets.all(5.r),
                                              padding: EdgeInsets.all(10.r),
                                              child: Center(
                                                child: Text(
                                                  categoryModel.categoryName,
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    color: selectedCategoryId ==
                                                            categoryModel
                                                                .categoryId
                                                        ? Colors.red
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  "Product Empty!",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            snapshot.error.toString(),
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(18.r),
              child: StreamBuilder<List<ProductModel>>(
                stream: context
                    .read<ProductsProvider>()
                    .getProducts(selectedCategoryId),
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
                                    ProductModel productModel =
                                        snapshot.data![index];
                                    return ZoomTapAnimation(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailScreen(
                                              productModel: productModel,
                                              index: index,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.r),
                                            color: AppColors.C_40BFFF),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Hero(
                                              tag: index,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16.r),
                                                child: CachedNetworkImage(
                                                  height: 100.h,
                                                  width: 100.w,
                                                  imageUrl: productModel
                                                      .productImages.first,
                                                  placeholder: (context, url) =>
                                                      const CupertinoActivityIndicator(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  productModel.productName,
                                                  style: TextStyle(
                                                      fontSize: 22.sp,
                                                      fontFamily: "Poppins",
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(height: 10.h),
                                                Text(
                                                  productModel.description,
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontFamily: "Poppins",
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(height: 10.h),
                                                Text(
                                                  "Price: ${productModel.price} ${productModel.currency}",
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      color: Colors.black,
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(height: 10.h),
                                                Text(
                                                  "Count: ${productModel.count}",
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontFamily: "Poppins",
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500),
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
                        : Center(child: Lottie.asset(AppImages.productScreen));
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 25.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    );
                  }
                  return Center(
                    child: CupertinoActivityIndicator(
                      radius: 20.r,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
