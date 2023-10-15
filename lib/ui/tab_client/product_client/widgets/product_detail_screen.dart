import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/order/order_model.dart';
import '../../../../data/model/product/product_model.dart';
import '../../../../providers/order_provider.dart';
import '../../../auth/widgets/global_button.dart';


class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen(
      {super.key, required this.productModel, required this.index});

  final ProductModel productModel;
  final int index;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();


}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Product", style: TextStyle(fontSize: 20.spMin,
            color: Colors.white,
            fontWeight: FontWeight.w700),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(38.0),
        child: Column(
          children: [
            Expanded(child: ListView(
              physics: const ScrollPhysics(),
              children: [
                CarouselSlider(
                  items: List.generate(
                      widget.productModel.productImages.length, (index) =>
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: widget.productModel
                                  .productImages[index],
                              fit: BoxFit.cover,

                            )
                        ),
                      ),
                  ), options: CarouselOptions(
                    height: 250.h,
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true
                ),),
                SizedBox(height: 20.h,),
                Text(widget.productModel.productName, style: TextStyle(
                    fontSize: 32.spMin,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),),
                SizedBox(height: 20.h,),
                Text(widget.productModel.description, style: TextStyle(
                    fontSize: 22.spMin,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),),
                SizedBox(height: 20.h,),
                Text("Count: ${widget.productModel.count}", style: TextStyle(
                    fontSize: 22.spMin,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),),
                SizedBox(height: 20.h,),
                Text("Price: ${widget.productModel.price} ${widget.productModel
                    .currency}", style: TextStyle(fontSize: 22.spMin,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (count > 1) {
                          setState(() {
                            count--;
                          });
                        }
                      },
                      child: const Icon(
                        Icons.remove,color: Colors.black,
                      ),
                    ),
                    Text(
                      count.toString(),
                      style: TextStyle(
                        fontFamily: "Poppins",
                          fontSize: 20.sp,
                          color: Colors.red,
                          fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                        onPressed: () {
                          if ((count + 1) <= widget.productModel.count) {
                            setState(() {
                              count++;
                            });
                          }
                        },
                        child: const Icon(Icons.add,color: Colors.black,)),
                  ],
                ),
                Text(
                  "Total price: ${widget.productModel.price * count}.   ${widget
                      .productModel.currency}",
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            ),
            GlobalButton(onTap: () {
              Provider.of<OrderProvider>(context, listen: false).addOrder(
                context: context,
                orderModel: OrderModel(
                  count: count,
                  totalPrice: widget.productModel.price * count,
                  orderId: "",
                  productId: widget.productModel.productId,
                  userId: FirebaseAuth.instance.currentUser!.uid,
                  orderStatus: "ordered",
                  createdAt: DateTime.now().toString(),
                  productName: widget.productModel.productName,
                ),
              );
            }, title: "Add to Card",)
          ],
        ),
      ),
    );
  }
}

