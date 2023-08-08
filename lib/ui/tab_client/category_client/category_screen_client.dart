import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mega_bazar/ui/tab_client/category_client/widgets/category_detail_screen.dart';
import 'package:mega_bazar/util/colors.dart';
import 'package:mega_bazar/util/icons.dart';
import 'package:provider/provider.dart';
import '../../../data/model/category/category_model.dart';
import '../../../providers/category_provider.dart';

class CategoryScreenClient extends StatefulWidget {
  const CategoryScreenClient({super.key});

  @override
  State<CategoryScreenClient> createState() => _CategoryScreenClientState();
}

class _CategoryScreenClientState extends State<CategoryScreenClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.C_40BFFF,
        title: Text(
          "Categories",
          style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
              fontSize: 24.sp,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
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
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 10.h),
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: AppColors.C_40BFFF),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryDetailScreen(
                                      categoryModel: categoryModel),
                                ),
                              );
                            },
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: CachedNetworkImage(
                                height: 50.h,
                                width: 50.w,
                                imageUrl: categoryModel.imageUrl,
                                placeholder: (context, url) =>
                                    const CupertinoActivityIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            title: Text(
                              categoryModel.categoryName,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 24.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              categoryModel.description,
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: "Poppins",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Center(child: Lottie.asset(AppImages.categoryScreen));
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(
                    fontSize: 24.sp,
                    fontFamily: "Poppins",
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            );
          }
          return Center(
            child: CupertinoActivityIndicator(radius: 20.r),
          );
        },
      ),
    );
  }
}
