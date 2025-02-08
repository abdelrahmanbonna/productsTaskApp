import 'package:get/get.dart';
import 'package:task_app/Core/Config/route_names.dart';
import 'package:task_app/Features/Home/Presentation/Bindings/home_bindings.dart';
import 'package:task_app/Features/Home/Presentation/Screens/home_screen.dart';
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
    GetPage(
      name: RouteNames.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
  ];

  static String get initialRoute => RouteNames.splash;
}
