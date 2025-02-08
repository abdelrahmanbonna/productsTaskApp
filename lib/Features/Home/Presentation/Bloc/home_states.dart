import 'package:equatable/equatable.dart';
import 'package:task_app/Core/Base/base_state.dart';
import 'package:task_app/Core/Error/failures.dart';
import 'package:task_app/Features/Products/Data/Models/product_model.dart';

abstract class HomeStates extends Equatable implements BaseState {}

class HomeInitialState extends HomeStates {
  @override
  List<Object> get props => [];

  @override
  Failure? get failure => null;

  @override
  bool get isLoading => false;
}

class ProductsSuccessState extends HomeStates {
  final List<Product> products;

  ProductsSuccessState({required this.products});

  @override
  List<Object> get props => [products];

  @override
  Failure? get failure => null;

  @override
  bool get isLoading => false;
}

class LoadingState extends HomeStates {
  @override
  List<Object> get props => [];

  @override
  Failure? get failure => null;

  @override
  bool get isLoading => true;
}

class ErrorState extends HomeStates {
  final Failure fail;

  ErrorState({required this.fail});

  @override
  List<Object> get props => [fail];

  @override
  Failure? get failure => fail;

  @override
  bool get isLoading => false;
}
