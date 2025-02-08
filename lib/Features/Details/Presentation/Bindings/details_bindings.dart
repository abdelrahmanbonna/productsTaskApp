import 'package:get/get.dart';
import 'package:task_app/Features/Details/Presentation/Blocs/details_bloc.dart';
import 'package:task_app/Features/Products/Data/Repositories/products_repository.dart';

class DetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<DetailsBloc>(DetailsBloc(productsRepository: Get.find<ProductsRepository>()));
  }
}