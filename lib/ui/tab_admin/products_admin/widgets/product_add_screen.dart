import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mega_bazar/util/colors.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/category/category_model.dart';
import '../../../../data/model/product/product_model.dart';
import '../../../../providers/category_provider.dart';
import '../../../../providers/product_provider.dart';
import '../../../auth/widgets/global_button.dart';
import '../../../auth/widgets/global_text_fields.dart';

class ProductAddScreen extends StatefulWidget {
  ProductAddScreen({super.key, this.productModel});

  ProductModel? productModel;

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  ImagePicker picker = ImagePicker();

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(24.r),
          height: 200.h,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo),
                title: Text(
                  "Select from Gallery",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      color: Colors.white),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromGallery() async {
    List<XFile> xFiles = await picker.pickMultiImage(
      maxHeight: 512.h,
      maxWidth: 512.w,
    );
    await Provider.of<ProductsProvider>(context, listen: false)
        .uploadProductImages(
      context: context,
      images: xFiles,
    );
  }

  String currency = "";

  List<String> currencies = ["UZS", "USD", "RUB"];

  String selectedCurrency = "UZS";
  String selectedCategoryId = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<ProductsProvider>(context, listen: false).clearParameters();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            widget.productModel == null ? "Product Add" : "Product Update",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
                fontFamily: "Poppins"),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Provider.of<ProductsProvider>(context, listen: false)
                  .clearParameters();
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.all(16.r),
                    child: GlobalTextField(
                        hintText: "Product Name",
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start,
                        controller: context
                            .read<ProductsProvider>()
                            .productNameController),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.all(16.r),
                    child: GlobalTextField(
                        isDescription: true,
                        hintText: "Description",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start,
                        controller: context
                            .read<ProductsProvider>()
                            .productDescController),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.all(16.r),
                    child: GlobalTextField(
                      digit: true,
                      hintText: "Product Count",
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      controller: context
                          .read<ProductsProvider>()
                          .productCountController,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.all(16.r),
                    child: GlobalTextField(
                      digit: true,
                      hintText: "Product Price",
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      controller: context
                          .read<ProductsProvider>()
                          .productPriceController,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 157.w),
                    child: DropdownButton(
                      value: selectedCurrency,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: currencies.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18.sp,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCurrency = newValue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 24.h),
                  StreamBuilder<List<CategoryModel>>(
                    stream: context.read<CategoryProvider>().getCategories(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<CategoryModel>> snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!.isNotEmpty
                            ? SizedBox(
                                height: 100.h,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(
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
                                                BorderRadius.circular(16.r),
                                            color: selectedCategoryId ==
                                                    categoryModel.categoryId
                                                ? Colors.green
                                                : Colors.white,
                                          ),
                                          height: 100.h,
                                          margin: EdgeInsets.all(16.r),
                                          padding: EdgeInsets.all(16.r),
                                          child: Center(
                                            child: Text(
                                              categoryModel.categoryName,
                                              style: TextStyle(
                                                color: selectedCategoryId ==
                                                        categoryModel.categoryId
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                "Empty!",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500),
                              ));
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            snapshot.error.toString(),
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }
                      return Center(child: CupertinoActivityIndicator(
                        radius: 20.r,
                      ),);
                    },
                  ),
                  SizedBox(height: 24.h),
                  context.watch<ProductsProvider>().uploadedImagesUrls.isEmpty
                      ? Container(
                          padding: EdgeInsets.all(20.r),
                          height: 80.h,
                          child: TextButton(
                            onPressed: () {
                              showBottomSheetDialog();
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: AppColors.C_40BFFF),
                            child: Center(
                              child: Text(
                                "Select Image",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontFamily: "Poppins"),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 100.h,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ...List.generate(
                                context
                                    .watch<ProductsProvider>()
                                    .uploadedImagesUrls
                                    .length,
                                (index) {
                                  String singleImage = context
                                      .watch<ProductsProvider>()
                                      .uploadedImagesUrls[index];
                                  return Container(
                                    padding: EdgeInsets.all(5.r),
                                    margin: EdgeInsets.all(5.r),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Image.network(
                                      singleImage,
                                      width: 80.w,
                                      height: 80.h,
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                  Visibility(
                    visible: context
                        .watch<ProductsProvider>()
                        .uploadedImagesUrls
                        .isNotEmpty,
                    child: TextButton(
                      onPressed: () {
                        showBottomSheetDialog();
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: AppColors.C_40BFFF),
                      child: Text(
                        "Select Image",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 18.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: GlobalButton(
                title: widget.productModel == null
                    ? "Add product"
                    : "Update product",
                onTap: () {
                  if (context
                          .read<ProductsProvider>()
                          .uploadedImagesUrls
                          .isNotEmpty &&
                      selectedCategoryId.isNotEmpty) {
                    context.read<ProductsProvider>().addProduct(
                          context: context,
                          categoryId: selectedCategoryId,
                          productCurrency: selectedCurrency,
                        );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(milliseconds: 500),
                        backgroundColor: Colors.red,
                        margin: EdgeInsets.symmetric(
                          vertical: 100.h,
                          horizontal: 20.w,
                        ),
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          "The information is incomplete!!!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20.h)
          ],
        ),
      ),
    );
  }
}
