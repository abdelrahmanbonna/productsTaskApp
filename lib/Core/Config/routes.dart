import 'package:get/get.dart';
import 'package:task_app/Core/Config/route_names.dart';
import 'package:task_app/Features/Splash/Presentation/Bindings/splash_binding.dart';
import 'package:task_app/Features/Splash/Presentation/Pages/splash_screen.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: RouteNames.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    // Add more routes here
  ];

  static String get initialRoute => RouteNames.splash;
}
