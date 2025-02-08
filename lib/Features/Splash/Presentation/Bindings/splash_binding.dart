import 'package:get/get.dart';
import 'package:task_app/Features/Products/Data/Repositories/products_repository.dart';
import 'package:task_app/Features/Splash/Presentation/Blocs/splash_bloc.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Register splash screen dependencies
    Get.lazyPut(() => SplashBloc(Get.find<ProductsRepository>()));
  }
}
