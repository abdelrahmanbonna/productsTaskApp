import 'package:task_app/Core/Base/base_state.dart';
import 'package:task_app/Features/Products/Data/Models/product_model.dart';

abstract class SplashStates extends BaseState {}

class ProductsSuccessState extends SplashStates {
  final List<Product> products;

  ProductsSuccessState({required this.products});
}