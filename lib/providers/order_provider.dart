import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:caffelito/data/models/coffee/coffee_model.dart';
import 'package:caffelito/data/models/order/order_model.dart';
import 'package:caffelito/data/models/universal_data.dart';
import 'package:caffelito/utils/ui_utils/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data/firebase/order_service.dart';

class OrderProvider with ChangeNotifier {
  OrderProvider({required this.orderService}) {
    listenOrders(FirebaseAuth.instance.currentUser!.uid);
  }

  final OrderService orderService;
  List<OrderModel> userOrders = [];


  Future<CoffeeModel> getItem({required BuildContext context,required OrderModel orderModel})async{
    showLoading(context: context);
    CoffeeModel coffeeModel = (FirebaseFirestore.instance
        .collection("products")
        .where("productId", isEqualTo: orderModel.productId)
        .snapshots()
        .map(
            (event1) => event1.docs
            .map((doc) => CoffeeModel.fromJson(doc.data()))) as CoffeeModel);
    if(context.mounted){
      hideLoading(dialogContext: context);
    }
    return coffeeModel;
  }


  int  getOrdersPrice(){
    int summa = 0;
    for(var element in userOrders){
      summa+=element.totalPrice;
    }
    notifyListeners();
    return summa;
  }

  Future<void> addOrder({
    required BuildContext context,
    required OrderModel orderModel,
  }) async {
    List<OrderModel> exists = userOrders
        .where((element) => element.productId == orderModel.productId)
        .toList();

    OrderModel? oldOrderModel;
    if (exists.isNotEmpty) {
      oldOrderModel = exists.first;
      oldOrderModel = oldOrderModel.copWith(
          count: orderModel.count + oldOrderModel.count,
          totalPrice:
          (orderModel.count + oldOrderModel.count) * orderModel.totalPrice);
    }

    showLoading(context: context);
    UniversalData universalData = exists.isNotEmpty
        ? await orderService.updateOrder(orderModel: oldOrderModel!)
        : await orderService.addOrder(orderModel: orderModel);

    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
        Navigator.pop(context);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> updateOrder({
    required BuildContext context,
    required OrderModel orderModel,
  }) async {
    showLoading(context: context);

    UniversalData universalData =
    await orderService.updateOrder(orderModel: orderModel);

    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> deleteOrder({
    required BuildContext context,
    required String orderId,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
    await orderService.deleteOrder(orderId: orderId);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Stream<List<OrderModel>> listenOrdersList(String? uid) async* {
    if (uid == null) {
      yield* FirebaseFirestore.instance.collection("orders").snapshots().map(
            (event1) => event1.docs
            .map((doc) => OrderModel.fromJson(doc.data()))
            .toList(),
      );
    } else {
      yield* FirebaseFirestore.instance
          .collection("orders")
          .where("userId", isEqualTo: uid)
          .snapshots()
          .map(
            (event1) => event1.docs
            .map((doc) => OrderModel.fromJson(doc.data()))
            .toList(),
      );
    }
  }

  listenOrders(String userId) async {
    listenOrdersList(userId).listen((List<OrderModel> orders) {
      userOrders = orders;
      debugPrint("CURRENT USER ORDERS LENGTH:${userOrders.length}");
      notifyListeners();
    });
  }

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    notifyListeners();
  }
}
