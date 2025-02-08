import 'package:task_app/Core/Base/base_state.dart';
import 'package:task_app/Core/Error/failures.dart';
import 'package:task_app/Features/Products/Data/Models/product_model.dart';

abstract class SplashStates implements BaseState {}

class ProductsSuccessState extends SplashStates {
  final List<Product> products;

  ProductsSuccessState({required this.products});

  @override
  Failure? get failure => null;

  @override
  bool get isLoading => false;

  @override
  List<Object?> get props => [products];

  @override
  bool? get stringify => true;
}