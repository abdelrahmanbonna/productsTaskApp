import 'package:task_app/Core/Base/base_event.dart';
import 'package:task_app/Features/Products/Data/Models/product_model.dart';

abstract class DetailsEvents implements BaseEvent {}

class SaveToFavoriteProductsEvent implements DetailsEvents {
  final Product product;

  SaveToFavoriteProductsEvent({required this.product});

  @override
  List<Object?> get props => [product];
  
  @override
  bool? get stringify => true;
}

class RemoveFromFavoriteProductsEvent implements DetailsEvents {
  final Product product;

  RemoveFromFavoriteProductsEvent({required this.product});

  @override 
  List<Object?> get props => [product];
  
  @override 
  bool? get stringify => true;
}