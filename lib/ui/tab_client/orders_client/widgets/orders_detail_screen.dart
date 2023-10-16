import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mega_bazar/util/colors.dart';
import '../../../../data/model/order/order_model.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.C_40BFFF,
        title: Text(
          "Order Detail",
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(38.r),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const ScrollPhysics(),
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    widget.orderModel.productName,
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontFamily: "Poppins",
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    "Count: ${widget.orderModel.count}",
                    style: TextStyle(
                        fontSize: 22.sp,
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Total Price: ${widget.orderModel.totalPrice}",
                    style: TextStyle(
                        fontSize: 22.sp,
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Created: ${widget.orderModel.createdAt.substring(0, 10)}",
                    style: TextStyle(
                        fontSize: 22.sp,
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
