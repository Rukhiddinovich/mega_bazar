part of 'order_bloc.dart';

@immutable
abstract class OrderEvent extends Equatable {}

class AddOrder extends OrderEvent {
  final OrderModel newOrder;

  AddOrder({required this.newOrder});

  @override
  List<Object?> get props => [newOrder];
}

class GetOrder extends OrderEvent {
  @override
  List<Object?> get props => [];
}

class DeleteAllOrderEvent extends OrderEvent {
  @override
  List<Object?> get props => [];
}

class DeleteOrderEvent extends OrderEvent {
  final int id;

  DeleteOrderEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class UpdateOrder extends OrderEvent {
  final OrderModel newOrder;

  UpdateOrder({required this.newOrder});

  @override
  List<Object?> get props => [newOrder];
}
