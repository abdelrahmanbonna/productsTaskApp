import 'package:get/get.dart';
import 'package:task_app/Features/Home/Presentation/Bloc/home_bloc.dart';
import 'package:task_app/Features/Products/Data/Repositories/products_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeBloc(Get.find<ProductsRepository>()));
  }
}