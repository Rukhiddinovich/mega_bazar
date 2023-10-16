import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:caffelito/data/models/order/order_model.dart';
import 'package:caffelito/data/models/universal_data.dart';
import 'package:flutter/material.dart';

class OrderService {
  Future<UniversalData> addOrder({required OrderModel orderModel}) async {
    try {
      DocumentReference newCategory = await FirebaseFirestore.instance
          .collection("orders")
          .add(orderModel.toJson());

      await FirebaseFirestore.instance
          .collection("orders")
          .doc(newCategory.id)
          .update({"orderId": newCategory.id});

      return UniversalData(data: "Order added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> updateOrder({required OrderModel orderModel}) async {
    debugPrint("INSIDE UPDATE: ${orderModel.orderId}");
    try {
      await FirebaseFirestore.instance
          .collection("orders")
          .doc(orderModel.orderId)
          .update(
            orderModel.toJson(),
          );

      return UniversalData(data: "Order updated!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> deleteOrder({required String orderId}) async {
    try {
      await FirebaseFirestore.instance
          .collection("orders")
          .doc(orderId)
          .delete();

      return UniversalData(data: "Order deleted!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> getAllProducts() async {
    try {
      FirebaseFirestore.instance.collection("order").snapshots().map((event) =>
          event.docs.map((doc) => OrderModel.fromJson(doc.data())).toList());
      return UniversalData(data: "Order fetched!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
