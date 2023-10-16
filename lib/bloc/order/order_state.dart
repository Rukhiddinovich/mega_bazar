part of 'order_bloc.dart';

class OrderState extends Equatable {
  final FormStatus status;
  final List<OrderModel> orderModel;
  final String statusText;

  const OrderState(
      {required this.status,
      required this.orderModel,
      required this.statusText});

  OrderState copyWith({
    FormStatus? status,
    List<OrderModel>? orderModel,
    String? statusText,
  }) =>
      OrderState(
          status: status ?? this.status,
          orderModel: orderModel ?? this.orderModel,
          statusText: statusText ?? this.statusText);

  @override
  List<Object?> get props => [status, orderModel, statusText];
}
