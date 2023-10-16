import 'package:caffelito/data/models/coffee/coffee_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class CoffeeEvent extends Equatable {}

class AddCoffee extends CoffeeEvent {
  final CoffeeModel newCoffee;

  AddCoffee({required this.newCoffee});

  @override
  List<Object?> get props => [newCoffee];
}

class GetCoffee extends CoffeeEvent {
  @override
  List<Object?> get props => [];
}

class DeleteAllCoffeeEvent extends CoffeeEvent {
  @override
  List<Object?> get props => [];
}

class DeleteCoffeeEvent extends CoffeeEvent {
  final int id;

  DeleteCoffeeEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class UpdateCoffee extends CoffeeEvent {
  final CoffeeModel newCoffee;

  UpdateCoffee({required this.newCoffee});

  @override
  List<Object?> get props => [newCoffee];
}
