import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mega_bazar/ui/tab_client/category_client/category_screen_client.dart';
import 'package:mega_bazar/ui/tab_client/tab_box_client.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../data/model/category/category_model.dart';
import '../../../../data/model/product/product_model.dart';
import '../../../../providers/product_provider.dart';
import '../../../../util/colors.dart';
import '../../../tab_admin/products_admin/widgets/product_detail_screen.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.C_40BFFF,
        title: Text(
          "${widget.categoryModel.categoryName} Category",
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(18.r),
              child: StreamBuilder<List<ProductModel>>(
                stream: context
                    .read<ProductsProvider>()
                    .getProducts(widget.categoryModel.categoryId),
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
                                                    index: index),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          color: AppColors.C_40BFFF,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              child: Hero(
                                                tag: index,
                                                child: CachedNetworkImage(
                                                  height: 100.h,
                                                  width: 100.h,
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
                                                      fontFamily: "Poppins",
                                                      fontSize: 22.sp,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(height: 10.h),
                                                Text(
                                                  productModel.description,
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 18.sp,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(height: 10.h),
                                                Text(
                                                  "Price: ${productModel.price} ${productModel.currency}",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 18.sp,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(height: 10.h),
                                                Text(
                                                  "Count: ${productModel.count}",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 18.sp,
                                                      color: Colors.white,
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
                        : Center(
                            child: Text(
                              "Product Empty!",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 25.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 25.sp,
                            color: Colors.white,
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
