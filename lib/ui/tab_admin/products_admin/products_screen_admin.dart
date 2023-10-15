import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mega_bazar/ui/tab_admin/products_admin/widgets/product_add_screen.dart';
import 'package:mega_bazar/util/colors.dart';
import 'package:provider/provider.dart';
import '../../../data/model/product/product_model.dart';
import '../../../providers/product_provider.dart';

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
          "Products Admin",
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 24.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
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
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(18.r),
        child: StreamBuilder<List<ProductModel>>(
          stream: context.read<ProductsProvider>().getProducts(""),
          builder: (BuildContext context,
              AsyncSnapshot<List<ProductModel>> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.isNotEmpty
                  ? ListView(
                      children: List.generate(
                        snapshot.data!.length,
                        (index) {
                          ProductModel productModel = snapshot.data![index];
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 15.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: AppColors.C_40BFFF),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(16.r),
                                child: CachedNetworkImage(
                                  height: 50.h,
                                  width: 50.w,
                                  imageUrl: productModel.productImages.first,
                                  placeholder: (context, url) =>
                                      const CupertinoActivityIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    backgroundColor: Colors.white,
                                    content: const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Delete Product",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          context
                                              .read<ProductsProvider>()
                                              .deleteProduct(
                                                context: context,
                                                productId:
                                                    productModel.productId,
                                              );
                                          Navigator.of(context).pop();
                                        },
                                        isDefaultAction: true,
                                        child: Text(
                                          "Ok",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 20.sp,
                                              fontFamily: "Poppins"),
                                        ),
                                      ),
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        isDefaultAction: true,
                                        child: Text("Cancel", style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontSize: 20.sp,
                                            fontFamily: "Poppins"),),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              title: Text(
                                productModel.productName,
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 24.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productModel.description,
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 18.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Price: ${productModel.price} ${productModel.currency}",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 18.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Count: ${productModel.count}",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 18.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ProductAddScreen(
                                          productModel: productModel,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text(
                      "Product Empty!",
                      style: TextStyle(
                          fontSize: 32.spMin,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString(), style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontFamily: "Poppins"),),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
