import 'package:caffelito/utils/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caffelito/data/firebase/order_service.dart';
import 'package:caffelito/data/models/form_status.dart';
import 'package:caffelito/data/models/order/order_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({required this.orderService})
      : super(const OrderState(
            status: FormStatus.pure, orderModel: [], statusText: "")) {
    on<AddOrder>(_addOrderProduct);
    on<GetOrder>(_getOrderProduct);
    on<UpdateOrder>(_updateOrderProduct);
    on<DeleteOrderEvent>(_deleteOrderProduct);
  }

  final OrderService orderService;

  List<OrderModel> newOrder = [];

  _addOrderProduct(AddOrder event, Emitter<OrderState> emit) async {
    emit(state.copyWith(
        status: FormStatus.loading,
        orderModel: [...state.orderModel],
        statusText: StatusTextConstants.addOrder));
    try {
      await orderService.addOrder(orderModel: event.newOrder);
      emit(state.copyWith(
          status: FormStatus.success,
          orderModel: [...state.orderModel],
          statusText: StatusTextConstants.addOrder));
    } catch (e) {
      emit(state.copyWith(
          status: FormStatus.error,
          orderModel: [...state.orderModel],
          statusText: "Error adding product to order"));
    }
  }

  _getOrderProduct(GetOrder event, Emitter<OrderState> emit) async {
    emit(state.copyWith(
        status: FormStatus.loading,
        orderModel: [...state.orderModel],
        statusText: StatusTextConstants.getOrder));
    try {
      await orderService.getAllProducts();
      emit(state.copyWith(
          status: FormStatus.success,
          orderModel: newOrder,
          statusText: StatusTextConstants.getOrder));
    } catch (e) {
      emit(state.copyWith(
          status: FormStatus.error,
          orderModel: [...state.orderModel],
          statusText: "Error getting order product"));
    }
  }

  _updateOrderProduct(UpdateOrder event, Emitter<OrderState> emit) async {
    emit(state.copyWith(
        status: FormStatus.loading,
        orderModel: [...state.orderModel],
        statusText: StatusTextConstants.updateOrder));
    try {
      await orderService.updateOrder(orderModel: event.newOrder);
      emit(state.copyWith(
          status: FormStatus.success,
          orderModel: [...state.orderModel],
          statusText: StatusTextConstants.updateOrder));
    } catch (e) {
      emit(state.copyWith(
          status: FormStatus.error,
          orderModel: [...state.orderModel],
          statusText: "Error updating order product"));
    }
  }

  _deleteOrderProduct(DeleteOrderEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(
        status: FormStatus.loading,
        orderModel: [...state.orderModel],
        statusText: StatusTextConstants.deleteOrder));
    try {
      await orderService.deleteOrder(orderId: event.id.toString());
      emit(state.copyWith(
          status: FormStatus.success,
          orderModel: [...state.orderModel],
          statusText: StatusTextConstants.deleteOrder));
    } catch (e) {
      emit(state.copyWith(
          status: FormStatus.error,
          orderModel: [...state.orderModel],
          statusText: "Error deleting order product"));
    }
  }
}
