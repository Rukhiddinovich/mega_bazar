import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mega_bazar/ui/tab_client/orders_client/widgets/orders_detail_screen.dart';
import 'package:mega_bazar/util/colors.dart';
import 'package:mega_bazar/util/icons.dart';
import 'package:provider/provider.dart';
import '../../../data/model/order/order_model.dart';
import '../../../providers/order_provider.dart';

class OrdersScreenClient extends StatefulWidget {
  const OrdersScreenClient({super.key});

  @override
  State<OrdersScreenClient> createState() => _OrdersScreenClientState();
}

class _OrdersScreenClientState extends State<OrdersScreenClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.C_40BFFF,
        title: Text(
          "Orders",
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.70,
            child: StreamBuilder<List<OrderModel>>(
              stream: context
                  .read<OrderProvider>()
                  .listenOrdersList(FirebaseAuth.instance.currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<List<OrderModel>> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.isNotEmpty
                      ? ListView(
                          children: List.generate(
                            snapshot.data!.length,
                            (index) {
                              OrderModel orderModel = snapshot.data![index];
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 5.w),
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 15.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    color: AppColors.C_40BFFF),
                                child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OrderDetailScreen(
                                                  orderModel: orderModel),
                                        ),
                                      );
                                    },
                                    title: Text(
                                      orderModel.productName,
                                      style: TextStyle(
                                          fontSize: 24.sp,
                                          fontFamily: "Poppins",
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    subtitle: Text(
                                      "${orderModel.count} ta ---> ${orderModel.totalPrice}",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontFamily: "Poppins",
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            backgroundColor: Colors.white,
                                            content: const Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Text(
                                                "Delete Order",
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
                                                      .read<OrderProvider>()
                                                      .deleteOrder(
                                                        context: context,
                                                        orderId:
                                                            orderModel.orderId,
                                                      );
                                                  Navigator.of(context).pop();
                                                },
                                                isDefaultAction: true,
                                                child: Text(
                                                  "Ok",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontFamily: "Poppins",
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              CupertinoDialogAction(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                isDefaultAction: true,
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontFamily: "Poppins",
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    )),
                              );
                            },
                          ),
                        )
                      : Center(child: Lottie.asset(AppImages.orderScreen));
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Poppins",
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  );
                }
                return Center(child: CupertinoActivityIndicator(
                  radius: 20.r,
                ),);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            height: 50.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r), color: AppColors.C_40BFFF),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: ",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  Provider.of<OrderProvider>(context, listen: true)
                      .getOrdersPrice()
                      .toString(),
                  style: TextStyle(
                      fontSize: 24.spMin,
                      fontFamily: "Poppins",
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
