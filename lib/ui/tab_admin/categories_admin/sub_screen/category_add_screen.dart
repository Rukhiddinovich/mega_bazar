import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/category/category_model.dart';
import '../../../../providers/category_provider.dart';
import '../../../../util/colors.dart';
import '../../../../util/constants.dart';
import '../../../auth/widgets/global_button.dart';
import '../../../auth/widgets/global_text_fields.dart';

class CategoryAddScreen extends StatefulWidget {
  CategoryAddScreen({super.key, this.categoryModel});
  CategoryModel? categoryModel;

  @override
  State<CategoryAddScreen> createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<CategoryAddScreen> {
  ImagePicker picker = ImagePicker();
  String imagePath = defaultImageConstant;

  @override
  void initState() {
    if (widget.categoryModel != null) {
      context.read<CategoryProvider>().setInitialValues(widget.categoryModel!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<CategoryProvider>(context, listen: false).clearTexts();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            widget.categoryModel == null ? "Category Add" : "Category Update",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
                fontFamily: "Poppins",
                color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Provider.of<CategoryProvider>(context, listen: false)
                  .clearTexts();
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.r),
                children: [
                  GlobalTextField(
                      hintText: "Name",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      controller: context
                          .read<CategoryProvider>()
                          .categoryNameController),
                  SizedBox(height: 24.h),
                  SizedBox(
                    height: 200.h,
                    child: GlobalTextField(
                        hintText: "Description",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        textAlign: TextAlign.start,
                        controller: context
                            .read<CategoryProvider>()
                            .categoryDescController),
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: 100.w,
                    height: 50.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 90.w),
                      child: TextButton(
                        onPressed: () {
                          showBottomSheetDialog();
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: AppColors.C_40BFFF),
                        child: imagePath == defaultImageConstant
                            ? Text(
                                imagePath,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontSize: 15.sp),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            : Image.file(File(imagePath)),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: GlobalButton(
                title: widget.categoryModel == null
                    ? "Add category"
                    : "Update Category",
                onTap: () {
                  if (imagePath != defaultImageConstant) {
                    if (widget.categoryModel == null) {
                      context.read<CategoryProvider>().addCategory(
                            context: context,
                            imageUrl: imagePath,
                          );
                    } else {
                      context.read<CategoryProvider>().updateCategory(
                          context: context,
                          imagePath: imagePath,
                          currentCategory: widget.categoryModel!);
                    }
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
                          "Select image!!!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(24.r),
          height: 200.h,
          decoration: BoxDecoration(
            color: AppColors.C_40BFFF,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading:
                    const Icon(Icons.camera_alt, color: Colors.white, size: 30),
                title: Text(
                  "Select from Camera",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo, color: Colors.white, size: 30),
                title: Text(
                  "Select from Gallery",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null) {
      setState(() {
        imagePath = xFile.path;
      });
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null) {
      setState(() {
        imagePath = xFile.path;
      });
    }
  }
}
