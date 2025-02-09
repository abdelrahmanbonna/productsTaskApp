import 'package:get/get.dart';
import 'package:task_app/Features/Favorites/Blocs/favorites_bloc.dart';
import 'package:task_app/Features/Products/Data/Repositories/products_repository.dart';

class FavoritesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoritesBloc(Get.find<ProductsRepository>()));
  }
}