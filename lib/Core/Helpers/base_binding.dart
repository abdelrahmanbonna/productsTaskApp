import 'package:get/get.dart';

/// BaseBinding is responsible for initializing route-specific dependencies
/// and any additional bindings needed after the app has started
class BaseBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize route-specific dependencies
    _initRouteBindings();
    
    // Initialize UI-related dependencies
    _initUIBindings();
  }

  void _initRouteBindings() {
    // Route-specific dependencies are initialized here
    // These are typically controllers that are needed across multiple routes
    // Example:
    // Get.lazyPut<NavigationController>(() => NavigationController());
    // Get.lazyPut<BottomBarController>(() => BottomBarController());
  }

  void _initUIBindings() {
    // UI-related dependencies are initialized here
    // These are typically controllers for shared UI components
    // Example:
    // Get.lazyPut<ThemeController>(() => ThemeController());
    // Get.lazyPut<LocalizationController>(() => LocalizationController());
  }
}
