import 'package:caffelito/data/models/coffee/coffee_model.dart';
import 'package:caffelito/data/models/form_status.dart';
import 'package:equatable/equatable.dart';

class CoffeeState extends Equatable {
  final FormStatus status;
  final List<CoffeeModel> coffeeModel;
  final String statusText;

  const CoffeeState(
      {required this.status,
      required this.coffeeModel,
      required this.statusText});

  CoffeeState copyWith({
    FormStatus? status,
    List<CoffeeModel>? coffeeModel,
    String? statusText,
  }) =>
      CoffeeState(
          status: status ?? this.status,
          coffeeModel: coffeeModel ?? this.coffeeModel,
          statusText: statusText ?? this.statusText);

  @override
  List<Object?> get props => [status, coffeeModel, statusText];
}
